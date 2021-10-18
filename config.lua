return {
    autostart = {
        "feh --bg-fill ~/.config/awesome/themes/default/background.webp",
        "xset r rate 225 33",
        "sxhkd",
        "nm-applet",
    },
    bar = {
        position = "top",
        widget_padding = 18,
        height = 24,
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
