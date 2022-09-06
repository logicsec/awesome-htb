local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"
local scripts_dir = config_dir .. "scripts/"

return {
	--- Default Applications
	default = {
		--- Default terminal emulator
		terminal = "alacritty",
		powershell = "powershell",
		--- Default music client
		music_player = "wezterm start --class music ncmpcpp",
		--- Default text editor
		text_editor = "wezterm start nvim",
		--- Default code editor
		code = "code",
		--- Default web browser
		firefox = "firefox",
		--- Default file manager
		nautilus = "nautilus",
		--- Default email client
		mailspring = "mailspring",
		--- Default network manager
		network_manager = "wezterm start nmtui",
		--- Default bluetooth manager
		bluetooth_manager = "blueberry",
		--- Default power manager
		power_manager = "xfce4-power-manager",
		--- Default rofi global menu
		app_launcher = "rofi -show drun -theme applications -show-icons"
	},
	--- List of binaries/shell scripts that will execute for a certain task
	utils = {
		--- Fullscreen screenshot
		full_screenshot = utils_dir .. "screensht full",
		--- Area screenshot
		area_screenshot = utils_dir .. "screensht area",
		--- Color Picker
		color_picker = utils_dir .. "xcolor-pick",
		hd_audio = utils_dir .. "hd_audio",
		headset_audio = utils_dir .. "headset_audio",
	},
}
