local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.volume")

local M = wibox.widget {
    widget = wibox.widget.textbox
}

local status_icon = {
    {40, "墳 "},
    {20, "奔 "},
    {0, "奄 "},
}

awesome.connect_signal("status::volume", function(volume, muted)
    M.font = beautiful.font
    local markup = volume .. "%"

    for _, value in pairs(status_icon) do
        if muted then
            markup = "<span foreground='#E3605F'>" .. "婢 " .. "</span>"
            break
        end
        if volume >= value[1] then
            markup = "<span foreground='#51AFEF'>" .. value[2] .. "</span>" .. markup
            break
        end
    end

    M.markup = markup
end)

return M
