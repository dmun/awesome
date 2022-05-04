local wibox = require("wibox")
require("status.cpu")

local widget = require("widgets")
local icon = widget:new_icon(" ")
local text = widget:new_text(" ")

local cpu = wibox.widget {
    icon,
    text,
    widget = wibox.layout.align.horizontal,
    left_click = "kitty -e bpytop",
}

awesome.connect_signal("status::cpu", function(usage)
    text:set_markup(" " .. usage .. "%")
end)

return cpu
