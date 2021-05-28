local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.battery")

local battery = wibox.widget {
    widget = wibox.widget.textbox
}

local status_icon = {
    {99, " ", " "},
    {90, " ", " "},
    {80, " ", " "},
    {70, " ", " "},
    {60, " ", " "},
    {50, " ", " "},
    {40, " ", " "},
    {30, " ", " "},
    {20, " ", " "},
    {10, " ", " "},
    { 0, " ", " "},
}

awesome.connect_signal("status::battery", function(capacity, charging)
    battery.font = beautiful.font
    local markup = capacity .. "%"

    for _, value in pairs(status_icon) do
        if capacity >= value[1] then
            if (charging == true) then
                markup = "<span foreground='608b4e'>" .. value[3] .. "</span>".. markup
            else
                markup = value[2] .. markup
            end
            break
        end
    end

    battery.markup = markup
end)

return battery
