local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.memory")

local memory = wibox.widget {
    widget = wibox.widget.textbox
}

awesome.connect_signal("status::memory", function(usage)
    memory.font = beautiful.font
    local markup = "<span foreground='" .. memory.icon_color .. "'> </span>" .. usage .. " MiB"

    memory.markup = markup
end)

return memory
