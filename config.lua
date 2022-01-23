local systray   = require("widgets.systray")
local textclock = require("widgets.textclock")
local battery   = require("widgets.battery")
local client_name = require("widgets.client_name")
client_name.text_color = "#5B6268"

local cpu       = require "widgets.cpu"
cpu.icon_color = '#c678dd'

local memory    = require "widgets.memory"
memory.icon_color = '#98be65'

return {
    autostart = {
        "~/.fehbg",
        "xset r rate 225 33",
        "sxhkd",
        "nm-applet",
        "killall redshift-gtk; redshift-gtk -l 52.3:4.8",
    },
    bar = {
        position = "top",
        widget_padding = 18,
        height = 29,
        widgets = {
            left = {
            },
            middle = {
                client_name
            },
            right = {
                systray,
                memory,
                cpu,
                battery,
                require("awful").widget.keyboardlayout(),
                textclock,
            }
        },
    },
    sloppy_focus = true,
}
