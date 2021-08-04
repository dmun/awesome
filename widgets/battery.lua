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
                markup = "<span foreground='#5B6268'>" .. value[3] .. "</span>" .. markup
            else
				if capacity <= 10 then
					markup = "<span foreground='#E3605F'>" .. value[2] .. "</span>" .. markup
				else
					markup = "<span foreground='#5B6268'>" .. value[2] .. "</span>" .. markup
				end
            end
            break
        end
    end

    battery.markup = markup
end)

return battery
