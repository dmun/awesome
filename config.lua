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
        "xrdb ~/.Xresources",
        "xset r rate 225 33",
        "xmodmap ~/.Xmodmap",
        "xset m 2/1 0",
        "sxhkd",
        "nm-applet",
        "blueman-applet",
        "redshift-gtk",
    },
    bar = {
        position = "top",
        widget_padding = 16,
        height = 28,
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
                -- require("awful").widget.keyboardlayout(),
                textclock,
            }
        },
    },
    sloppy_focus = false,
}
