local wibox = require("wibox")
require("status.memory")

local widget = require("widgets")
local icon = widget:new_icon(" ")
icon:set_right(-8)
local text = widget:new_text(" ")
text:hide()

local memory = wibox.widget {
    icon,
    text,
    layout = wibox.layout.align.horizontal,
    left_click = function ()
        text:toggle()
    end,
    right_click = "kitty -e bpytop",
}

awesome.connect_signal("status::memory", function(usage)
    text:set_markup(" " .. usage .. " MB")
end)

return memory
