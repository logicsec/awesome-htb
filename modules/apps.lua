local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"

return {
	--- Default Applications
	default = {
		--- Default terminal emulator
		terminal = "alacritty",
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
		bluetooth_manager = "blueman-manager",
		--- Default power manager
		power_manager = "xfce4-power-manager",
		--- Default rofi global menu
		app_launcher = "rofi -show drun -theme applications -show-icons",
		hd_audio = "pacmd set-card-profile " .. bluetooth_index .. "off; pacmd set-card-profile $index a2dp_sink",
		headset_audio = "pacmd set-card-profile " .. bluetooth_index .. "off; pacmd set-card-profile $index handsfree_head_unit",
	},

	

	--- List of binaries/shell scripts that will execute for a certain task
	utils = {
		--- Set Bluetooth index
		bluetooth_index = "pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}'"
		--- Fullscreen screenshot
		full_screenshot = utils_dir .. "screensht full",
		--- Area screenshot
		area_screenshot = utils_dir .. "screensht area",
		--- Color Picker
		color_picker = utils_dir .. "xcolor-pick",
	},
}
