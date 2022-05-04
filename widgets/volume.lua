local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.volume")

local widget = require("widgets")
local icon = widget:new_icon("墳 ")
local text = widget:new_text("100%")

local M = wibox.widget {
    icon,
    text,
    layout = wibox.layout.align.horizontal,
    left_click = "pactl set-sink-mute 0 toggle",
    scroll_up = "pactl set-sink-volume 0 +5%",
    scroll_down = "pactl set-sink-volume 0 -5%",
}

local status_icon = {
    {40, "墳 "},
    {20, "奔 "},
    {0, "奄 "},
}

awesome.connect_signal("status::volume", function(volume, muted)
    M.font = beautiful.font
    text:set_markup(volume .. "%")
    if muted then
        text:hide()
        icon:set("婢", beautiful.red)
    else
        text:show()
        for _, value in pairs(status_icon) do
            if volume >= value[1] then
                icon:set(value[2], beautiful.fg_normal)
                break
            end
        end
    end
end)

return M
