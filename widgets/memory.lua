local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.memory")

local memory = wibox.widget {
    widget = wibox.widget.textbox
}

awesome.connect_signal("status::memory", function(usage)
    local text = usage

    memory.text = text
end)

return memory
