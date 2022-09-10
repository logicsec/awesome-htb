local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")

--- Clock Widget
--- ~~~~~~~~~~~~

return function(s)
	local accent_color = beautiful.accent
	local clock = wibox.widget({
		widget = wibox.widget.textclock,
		format = "%I:%M %p",
		align = "center",
		valign = "center",
		font = beautiful.font_name .. "Medium 10",
	})

	clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
	clock:connect_signal("widget::redraw_needed", function()
		clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
	end)
	clock:connect_signal("mouse::enter", function(c) c.opacity = 0.5 end)
	clock:connect_signal("mouse::leave", function(c) c.opacity = 1.0 end)

	local widget = wbutton.elevated.state({
		child = clock,
		text_hover_bg = beautiful.transparent,
		hover_bg = beautiful.transparent,
		normal_bg = beautiful.transparent,
		text_normal_bg = beautiful.xforeground,
		on_release = function()
			awesome.emit_signal("central_panel::toggle", s)
		end,
	})

	return widget
end
