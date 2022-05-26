local systray     = require "widgets.systray"
local textclock   = require "widgets.textclock"
local battery     = require "widgets.battery"
local volume      = require "widgets.volume"
local buttons     = require "widgets.buttons"
local client_name = require "widgets.client_name"
local cpu         = require "widgets.cpu"
local memory      = require "widgets.memory"

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
        widget_padding = 10,
        height = 30,
        widgets = {
            left = {
                buttons,
                client_name,
            },
            middle = {},
            right = {
                systray,
                memory,
                cpu,
                volume,
                battery,
                -- require("awful").widget.keyboardlayout(),
                textclock,
            }
        },
    },
    sloppy_focus = false,
}
