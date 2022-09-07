# Setup


## Install Required Dependencies and Enable Services

**This setup instructions only provided for Arch Linux (and other Arch-based distributions)**

Assuming your _AUR Helper_ is [paru](https://github.com/Morganamilo/paru).

> First of all you should install the [git version of AwesomeWM](https://github.com/awesomeWM/awesome/).
```sh
paru -S awesome-git
```

> Install necessary dependencies
```sh
paru -Sy picom-git wezterm rofi acpi acpid acpi_call upower lxappearance-gtk3 \
jq inotify-tools polkit-gnome xdotool xclip gpick ffmpeg blueman redshift \
pipewire pipewire-alsa pipewire-pulse alsa-utils brightnessctl feh maim \
mpv mpd mpc mpdris2 python-mutagen ncmpcpp playerctl --needed
```

> Install Needed Fonts
- **Roboto** - [here](https://fonts.google.com/specimen/Roboto)
- **Material Design Icons** - [here](https://github.com/google/material-design-icons)
- **Icomoon** - [here](https://www.dropbox.com/s/hrkub2yo9iapljz/icomoon.zip?dl=0)

And run this command for your system to detect the newly installed fonts.

```sh
fc-cache -fv
```

> Enable Services
```sh
systemctl --user enable mpd.service
systemctl --user start mpd.service
```


## Clone the Repo and Edit Necessary Files

> Git Clone the Repo with Submodules
```sh
git clone --recurse-submodules https://github.com/lexlogic/awesome-htb
cd awesome-htb
git submodule update --remote --merge
```
> Install the vicious module. Navigate to the root of your awesome config and run the following:
```sh
git clone https://github.com/vicious-widgets/vicious
```

> Rename user_variables.lua.bak to user_variables.lua
```sh
mv user_variables.lua.bak user_variables.lua
```

**Edit user_variables.lua with Github username, API Key (From openweathermap.org), and Lat/Lon of your location**

> Move awesome-htb into ~/.config/awesome
```sh
mv ~/.config/awesome ~/.config/awesome.bak
mv awesome-htb ~/.config/awesome
```

**Log out from your current desktop session and log in into AwesomeWM**