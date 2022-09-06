local awful = require("awful")
local gears = require("gears")
local gfs = require("gears.filesystem")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local widgets = require("ui.widgets")
local wbutton = require("ui.widgets.button")
local animation = require("modules.animation")
local apps = require("configuration.apps")
require('ui.panels.bottom-panel.vpn')

--- Modern Bottom Panel
--- ~~~~~~~~~~~~~~~~~~~

return function(s)
	
	--- Widgets
	s.clock = require("ui.panels.bottom-panel.clock")(s)
	s.network = require("ui.panels.bottom-panel.network")()
	s.systray = wibox.widget.systray()
	s.cpu = require('ui.panels.bottom-panel.cpu')
	s.hdd = require('ui.panels.bottom-panel.hdd')
	s.mem = require('ui.panels.bottom-panel.mem')

	--- Custom Name Text
	--- ~~~~~~~~~~~~~~~~~
	local accent_color = beautiful.xcolor4

	local separator = widgets.button.text.normal({
		font = "icomoon bold ",
		normal_bg = beautiful.transparent,
		text_normal_bg = beautiful.htb4,
		margins = dpi(3),
		text = "|",
		size = 14
	})
	--- username
	local user_text = wibox.widget({
		widget = wibox.widget.textbox,
		markup = "$ <span foreground='" .. beautiful.accent .."'> logic</span>",
		font = beautiful.font_name .. "Normal 11",
		valign = "center",
	})

	awful.spawn.easy_async_with_shell(
		[[
		sh -c '
		fullname="$(getent passwd `whoami` | cut -d ':' -f 5 | cut -d ',' -f 1 | tr -d "\n")"
		if [ -z "$fullname" ];
		then
			printf "$(whoami)@$(hostname)"
		else
			printf "$fullname"
		fi
		'
		]],
		function(stdout)
			local stdout = stdout:gsub("%\n", "")
			user_text:set_markup("$ <span foreground='" .. beautiful.accent .."'> " .. stdout .. "</span>")
		end
	)
	local app_launcher = wibox.widget {
		image   = gfs.get_configuration_dir() .. "theme/assets/htb.svg",
		resize = true,
		forced_height = 20,
		forced_width = 20,
		valign = "center",
		buttons = {
			awful.button({}, 1, nil, function ()
				awful.spawn.with_shell(apps.default.app_launcher)
			end)
		},
		widget = wibox.widget.imagebox
	}
	local main_menu = require("ui.power-menu")
	-- local power = wibox.widget {
	-- 	font = beautiful.icon_font,
	-- 	text = "",
	-- 	buttons = {
	-- 		awful.button({}, 1, nil, function ()
	-- 			main_menu:toggle({
	-- 				coords = {x = s.geometry.x + s.geometry.width - dpi(10), y = beautiful.wibar_height + dpi(10)}
	-- 			})
	-- 		end)
	-- 	},
	-- 	widget = wibox.widget.imagebox
	-- }
	local power = widgets.button.text.normal({
		font = beautiful.icon_font,
		normal_bg = beautiful.transparent,
		text_normal_bg = beautiful.htb2,
		margins = dpi(3),
		text = "",
		size = 10,
		on_release = function()
			main_menu:toggle({
				coords = {x = s.geometry.x + s.geometry.width - dpi(10), y = beautiful.wibar_height + dpi(10)}
			})
		end
	})
	
	local console = wibox.widget {
		image   = gfs.get_configuration_dir() .. "theme/assets/console.svg",
		resize = true,
		text_normal_bg = beautiful.xforeground,
		forced_height = 25,
		forced_width = 25,
		valign = "center",
		buttons = {
			awful.button({}, 1, nil, function ()
				awful.spawn.with_shell(apps.default.terminal)
			end)
		},
		widget = wibox.widget.imagebox
	}
	console:connect_signal("mouse::enter", function(c) c.opacity = 0.5 end)
	console:connect_signal("mouse::leave", function(c) c.opacity = 1.0 end)

	local powershell = wibox.widget {
		image   = gfs.get_configuration_dir() .. "theme/assets/powershell.svg",
		resize = true,
		text_normal_bg = beautiful.xforeground,
		forced_height = 25,
		forced_width = 25,
		valign = "center",
		buttons = {
			awful.button({}, 1, nil, function ()
				awful.spawn.with_shell(apps.default.powershell)
			end)
		},
		widget = wibox.widget.imagebox
	}
	powershell:connect_signal("mouse::enter", function(c) c.opacity = 0.5 end)
	powershell:connect_signal("mouse::leave", function(c) c.opacity = 1.0 end)

	--- Taglist buttons
	local modkey = "Mod4"
	local taglist_buttons = gears.table.join(
		awful.button({}, 1, function(t)
			t:view_only()
		end),
		awful.button({ modkey }, 1, function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end),
		awful.button({}, 3, awful.tag.viewtoggle),
		awful.button({ modkey }, 3, function(t)
			if client.focus then
				client.focus:toggle_tag(t)
			end
		end),
		awful.button({}, 4, function(t)
			awful.tag.viewnext(t.screen)
		end),
		awful.button({}, 5, function(t)
			awful.tag.viewprev(t.screen)
		end)
	)

	local function tag_list(s)
		local taglist = awful.widget.taglist({
			screen = s,
			filter = awful.widget.taglist.filter.all,
			layout = { layout = wibox.layout.fixed.horizontal },
			widget_template = {
				widget = wibox.container.margin,
				forced_width = dpi(30),
				forced_height = dpi(40),
				create_callback = function(self, c3, _)
					local indicator = wibox.widget({
						widget = wibox.container.place,
						valign = "center",
						{
							widget = wibox.container.background,
							forced_height = dpi(8),
							shape = gears.shape.rounded_bar,
						}
					})

					self.indicator_animation = animation:new({
						duration = 0.125,
						easing = animation.easing.linear,
						update = function(self, pos)
							indicator.children[1].forced_width = pos
						end,
					})

					self:set_widget(indicator)

					if c3.selected then
						self.widget.children[1].bg = beautiful.htb4
						self.indicator_animation:set(dpi(8))
					elseif #c3:clients() == 0 then
						self.widget.children[1].bg = beautiful.htb4
						self.indicator_animation:set(dpi(8))
					else
						self.widget.children[1].bg = beautiful.htb4
						self.indicator_animation:set(dpi(8))
					end

					--- Tag preview
					self:connect_signal("mouse::enter", function()
						if #c3:clients() > 0 then
							awesome.emit_signal("bling::tag_preview::update", c3)
							awesome.emit_signal("bling::tag_preview::visibility", s, true)
						end
					end)

					self:connect_signal("mouse::leave", function()
						awesome.emit_signal("bling::tag_preview::visibility", s, false)
					end)
				end,
				update_callback = function(self, c3, _)
					if c3.selected then
						self.widget.children[1].bg = beautiful.accent
						self.indicator_animation:set(dpi(8))
					elseif #c3:clients() == 0 then
						self.widget.children[1].bg = beautiful.htb4
						self.indicator_animation:set(dpi(8))
					else
						self.widget.children[1].bg = beautiful.htb2
						self.indicator_animation:set(dpi(8))
					end
				end,
			},
			buttons = taglist_buttons,
		})

		local widget = widgets.button.elevated.state({
			normal_bg = beautiful.htb5,
			normal_shape = gears.shape.rounded_rect,
			child = {
				taglist,
				margins = { left = dpi(10), right = dpi(10) },
				widget = wibox.container.margin,
			},
		})

		return wibox.widget({
			widget,
			margins = { left = dpi(10), right = dpi(10), top = dpi(5), bottom = dpi(5) },
			widget = wibox.container.margin,
		})
	end


	--- Notif panel
	--- ~~~~~~~~~~~
	local function notif_panel()
		local icon = wibox.widget({
			markup = helpers.ui.colorize_text("", beautiful.xforeground),
			align = "center",
			valign = "center",
			font = beautiful.icon_font .. "Round 10",
			widget = wibox.widget.textbox,
		})

		local widget = wbutton.elevated.state({
			child = icon,
			normal_bg = beautiful.transparent,
			margins = dpi(3),
			on_release = function()
				awesome.emit_signal("notification_panel::toggle", s)
			end,
		})

		return widget
	end

	
	--- Create the top_panel
	--- ~~~~~~~~~~~~~~~~~~~~~~~
	s.top_panel = awful.popup({
		screen = s,
		type = "dock",
		maximum_height = beautiful.wibar_height,
		minimum_width = s.geometry.width,
		maximum_width = s.geometry.width,
		placement = function(c)
			awful.placement.top(c)
		end,
		bg = beautiful.transparent,
		widget = {
			{
				{
					layout = wibox.layout.align.horizontal,
					expand = "none",
					
					{
						app_launcher,
						tag_list(s),
						console,
						powershell,
						layout = wibox.layout.fixed.horizontal,
					},
					s.clock,
					{
						s.hdd.label,
						s.hdd.text,
						s.cpu.label,
						s.cpu.text,
						s.mem.label,
						s.mem.text,
						separator,
						s.network,
						notif_panel(),
						power,
						layout = wibox.layout.fixed.horizontal
					},
				},
				left = dpi(10),
				right = dpi(10),
				widget = wibox.container.margin,
			},
			bg = beautiful.htb3,
			widget = wibox.container.background,
		},
	})

	s.top_panel:struts({
		top = s.top_panel.maximum_height,
	})

	--- Create the bottom_panel
	--- ~~~~~~~~~~~~~~~~~~~~~~~
	s.bottom_panel = awful.popup({
		screen = s,
		type = "dock",
		maximum_height = beautiful.wibar_height,
		minimum_width = s.geometry.width,
		maximum_width = s.geometry.width,
		placement = function(c)
			awful.placement.bottom(c)
		end,
		bg = beautiful.transparent,
		widget = {
			{
				{
					layout = wibox.layout.align.horizontal,
					expand = "none",
					{
						vpn_text,
						vpn_ip,
						layout = wibox.layout.fixed.horizontal,
					},
					nil,
					user_text
				},
				left = dpi(10), 
				right = dpi(10), 
				top = dpi(5), 
				bottom = dpi(5),
				widget = wibox.container.margin,
			},
			bg = beautiful.htb3,
			widget = wibox.container.background,
		},
	})

	s.bottom_panel:struts({
		bottom = s.bottom_panel.maximum_height,
	})

	--- Remove panels on full screen
	local function remove_panels(c)
		if c.fullscreen or c.maximized then
			c.screen.top_panel.visible = false
			c.screen.bottom_panel.visible = false
		else
			c.screen.top_panel.visible = true
			c.screen.bottom_panel.visible = true
		end
	end

	--- Remove bottom_panel on full screen
	local function add_panels(c)
		if c.fullscreen or c.maximized then
			c.screen.top_panel.visible = true
			c.screen.bottom_panel.visible = true
		end
	end

	--- Hide bar when a splash widget is visible
	awesome.connect_signal("widgets::splash::visibility", function(vis)
		screen.primary.top_panel.visible = not vis
		screen.primary.bottom_panel.visible = not vis
	end)

	client.connect_signal("property::fullscreen", remove_panels)
	client.connect_signal("request::unmanage", add_panels)
end
