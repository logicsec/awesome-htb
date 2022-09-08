local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local gfs = require("gears.filesystem")
local helpers = require("helpers")

local function autostart_apps()
	--- Compositor
	helpers.run.check_if_running("picom --experimental-backends", nil, function()
		awful.spawn.with_shell("picom --experimental-backends --backend glx --config ".. gfs.get_configuration_dir() .. "configuration/picom.conf", false)
	end)
	--- Music Server
	-- helpers.run.run_once_pgrep("mpd")
	-- helpers.run.run_once_pgrep("mpDris2")
	--- Polkit Agent
	helpers.run.run_once_ps(
		"polkit-gnome-authentication-agent-1",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
	)
	--- Other stuff
	helpers.run.run_once_grep("blueman-applet")
	helpers.run.run_once_grep("nm-applet")
	helpers.run.run_once_grep("xset s off")
	helpers.run.run_once_grep("xrandr --output DP2 --auto --left-of DP1")
	helpers.run.run_once_grep("feh --bg-fill ".. gfs.get_configuration_dir() .. "theme/assets/wallpaper.jpg")
end

autostart_apps()
