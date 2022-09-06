local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")


vpn_text = wibox.widget.textbox()
watch(
    "ip addr show tun0", 2,
    function(widget, stdout, stderr, exitreason, exitcode)
        widget.markup= "<span foreground='#9fef00'>HTB VPN:</span> "
    end,
    vpn_text
)

vpn_ip = wibox.widget.textbox()
watch(
    "ip addr show tun0", 2,
    function(widget, stdout, stderr, exitreason, exitcode)
        if(stdout == '' or stdout==nil or stdout=='Device "tun0" does not exist.') then
            widget.text= "Disconnected"
        else
            local handle = io.popen("ip addr | grep tun0 | grep inet | grep 10. | tr -s ' ' | cut -d ' ' -f 3 | cut -d '/' -f 1")
            local vpn_ip = handle:read("*a")
            widget.text= vpn_ip 
        end
    end,
    vpn_ip
)

