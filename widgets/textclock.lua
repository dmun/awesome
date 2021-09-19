local wibox = require("wibox")

local textclock = {
    format = " %A, %d %b %H:%M",
    widget = wibox.widget.textclock
}

return textclock
