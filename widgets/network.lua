local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.network")

local network = wibox.widget {
    widget = wibox.widget.textbox
}

awesome.connect_signal("status::network", function(state)
    network.font = beautiful.icon_font
    local text

    if (state == "UP") then
        text = ""
    else
        text = ""
    end

    network.text = text
end)

return network
