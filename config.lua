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
        height = 28,
        widgets = {
            left = {
                require("wibox").widget {
                    markup = "",
                    widget = require("wibox").widget.textbox,
                },
                require("widgets.client_name"),
            },
            middle = {},
            right = {
                require("widgets.systray"),
                require("awful").widget.keyboardlayout(),
                require("widgets.battery"),
                require("widgets.textclock"),
            }
        },
    },
    sloppy_focus = true,
}
