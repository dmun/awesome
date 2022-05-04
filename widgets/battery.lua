local wibox     = require("wibox")
local beautiful = require("beautiful")
require("status.battery")

local widget = require("widgets")
local icon = widget:new_icon("  ")
local text = widget:new_text("100%")

local battery = wibox.widget {
    icon,
    text,
    layout = wibox.layout.align.horizontal,
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
    text:set_markup(capacity .. "%")
    if charging then
        local _icon = status_icon[prev][2]
        prev = prev - 1
        if prev < 1 then
            prev = #status_icon
        end
        icon:set(_icon, beautiful.fg_normal)
    else
        if capacity <= 10 then
            icon:set(status_icon[#status_icon][2], beautiful.red)
        end
        for _, value in pairs(status_icon) do
            if capacity >= value[1] then
                icon:set(value[2], beautiful.fg_normal)
            end
        end
    end
end)

return battery
