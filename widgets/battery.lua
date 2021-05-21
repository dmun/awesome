local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.battery")

local battery = wibox.widget {
    widget = wibox.widget.textbox
}

awesome.connect_signal("status::battery", function(capacity, charging)
    battery.font = beautiful.icon_font
    local text = capacity .. "% "

    if (charging == true) then
        text = text .. ""
    elseif (capacity >= 99) then
        text = text .. ""
    elseif (capacity > 80) then
        text = text .. ""
    elseif (capacity > 50) then
        text = text .. ""
    elseif (capacity > 20) then
        text = text .. ""
    else
        text = text .. ""
    end

    battery.text = text
end)

return battery
