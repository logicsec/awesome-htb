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

local disconnect_notice = awful.tooltip { }
disconnect_notice:add_to_object(vpn_ip)

vpn_ip:connect_signal("button::press", 
    function(c)  
        awful.spawn.easy_async_with_shell(
            [[
            sh -c 'ip addr show tun0'
            ]],
            function(stdout)
                local stdout = stdout:gsub("%\n", "")
                if(stdout == '' or stdout==nil or stdout=='Device "tun0" does not exist.') then
                    awful.spawn.with_shell("gksudo systemctl start openvpn-client@htb.service")

                else
                    awful.spawn.with_shell("gksudo systemctl stop openvpn-client@htb.service")
                end
            end
        )
    end
)
vpn_ip:connect_signal("mouse::enter", function(c) c.opacity = 0.5 disconnect_notice.text = "Toggle VPN Connection" end)
vpn_ip:connect_signal("mouse::leave", function(c) c.opacity = 1.0 end)


