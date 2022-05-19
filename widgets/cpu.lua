local wibox = require("wibox")
require("status.cpu")

local widget = require("widgets")
local icon = widget:new_icon(" ")
icon:set_right(-8)
local text = widget:new_text(" ")
text:hide()

local cpu = wibox.widget {
    icon,
    text,
    widget = wibox.layout.align.horizontal,
    left_click = function ()
        text:toggle()
    end,
    right_click = "kitty -e bpytop",
}

awesome.connect_signal("status::cpu", function(usage)
    text:set_markup(" " .. usage .. "%")
end)

return cpu
