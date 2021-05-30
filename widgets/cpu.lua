local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.cpu")

local cpu = wibox.widget {
    widget = wibox.widget.textbox
}

awesome.connect_signal("status::cpu", function(usage)
    cpu.font = beautiful.font
    local markup = "<span foreground='#C586C0'> </span>" .. usage .. "%"

    cpu.markup = markup
end)

return cpu
