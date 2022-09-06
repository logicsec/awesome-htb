local awful = require("awful")
local menu = require("ui.widgets.menu")
local gfs = require("gears.filesystem")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("configuration.apps")
local beautiful = require("beautiful")
local focused = awful.screen.focused()

--- Beautiful right-click menu
--- ~~~~~~~~~~~~~~~~~~~~~~~~~~

local instance = nil

local function awesome_menu()
	return menu({
		menu.button({
			icon = { icon = "", font = "Material Icons Round " },
			text = "Show Help",
			on_press = function()
				hotkeys_popup.show_help(nil, awful.screen.focused())
			end,
		}),
		menu.button({
			icon = { icon = "", font = "Material Icons Round " },
			text = "Manual",
			on_press = function()
				awful.spawn(apps.default.terminal .. " -e man awesome")
			end,
		}),
		menu.button({
			icon = { icon = "", font = "Material Icons Round " },
			text = "Edit Config",
			on_press = function()
				awful.spawn(apps.default.text_editor .. " " .. awesome.conffile)
			end,
		}),
		menu.button({
			icon = { icon = "", font = "Material Icons Round " },
			text = "Restart",
			on_press = function()
				awesome.restart()
			end,
		}),
		menu.button({
			icon = { icon = "", font = "Material Icons Round " },
			text = "Quit",
			on_press = function()
				awesome.quit()
			end,
		}),
	})
end

local function widget()
	return menu({
		menu.button({
			icon = { icon = "", font = beautiful.icon_font, size = 10, color = beautiful.accent },
			text = "Shutdown",
			text_size = 10,
			on_press = function()
				awful.spawn.with_shell("shutdown now")
			end,
		}),
		menu.button({
			icon = { icon = "", font = beautiful.icon_font, size = 10, color = beautiful.accent },
			text = "Restart",
			text_size = 10,
			on_press = function()
				awful.spawn.with_shell("reboot")
			end,
		}),
		menu.button({
			icon = { icon = "", font = beautiful.icon_font, size = 10, color = beautiful.accent },
			text = "Logoff",
			text_size = 10,
			on_press = function()
				awesome.quit()
			end,
		}),
		-- menu.sub_menu_button({
		-- 	icon = { icon = "", font = "Material Icons Round " },
		-- 	text = "AwesomeWM",
		-- 	text_size = 10,
		-- 	sub_menu = awesome_menu(),
		-- }),
	})
end

if not instance then
	instance = widget()
end
return instance
