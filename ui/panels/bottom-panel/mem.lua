local wibox = require('wibox')
local vc = require('vicious')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local beautiful = require("beautiful")
local widgets = require("ui.widgets")
local helpers = require("helpers")

local accent_color = beautiful.accent
local mem = {}
local w = wibox.widget.textbox()
vc.cache(vc.widgets.mem)

mem.label = widgets.button.text.normal({
   text_hover_bg = beautiful.xforeground,
   text_normal_bg = beautiful.xforeground,
   hover_bg = beautiful.transparent,
   normal_bg = beautiful.transparent,
   margins = dpi(1),
   text = "MEM",
   size = 10
})
mem.text = vc.register(w, vc.widgets.mem, "<span foreground='" .. beautiful.accent .."'>$1%</span>")

return mem
