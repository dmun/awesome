local wibox     = require("wibox")
local beautiful = require("beautiful")
require("status.battery")

local battery = wibox.widget {
    widget = wibox.widget.textbox
}

local status_icon = {
    {90, "  "},
    {70, "  "},
    {40, "  "},
    {10, "  "},
    {0, "  "},
}

local prev = #status_icon

awesome.connect_signal("status::battery", function(capacity, charging)
    battery.font = beautiful.font
    local markup = capacity .. "%"

    for _, value in pairs(status_icon) do
        if capacity >= value[1] then
            if (charging == true) then
                local icon = status_icon[prev][2]
                prev = prev - 1
                if prev < 1 then
                    prev = #status_icon
                end
                markup = icon .. markup
            else
				if capacity <= 10 then
					markup = "<span foreground='#E3605F'>" .. value[2] .. "</span>" .. markup
				else
					-- markup = "<span foreground='#5B6268'>" .. value[2] .. "</span>" .. markup
                    markup = value[2] .. markup
				end
            end
            break
        end
    end

    battery.markup = markup
end)

return battery
