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
		})
	})
end

if not instance then
	instance = widget()
end
return instance
