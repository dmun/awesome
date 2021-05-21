local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.battery")

local battery = wibox.widget {
    widget = wibox.widget.textbox
}

local status_icon = {
    {99, "", ""},
    {90, "", ""},
    {80, "", ""},
    {70, "", ""},
    {60, "", ""},
    {50, "", ""},
    {40, "", ""},
    {30, "", ""},
    {20, "", ""},
    {10, "", ""},
    { 0, "", ""},
}

awesome.connect_signal("status::battery", function(capacity, charging)
    battery.font = beautiful.icon_font
    local text = capacity .. "% "

    for _, value in pairs(status_icon) do
        if capacity >= value[1] then
            if (charging == true) then
                text = text .. value[2]
            else
                text = text .. value[3]
            end
            break
        end
    end

    battery.text = text
end)

return battery
