local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

function M.update_border(c)
    local s = c.screen
    if #s.tiled_clients == 1
        or s.selected_tag and (s.selected_tag.layout.name == 'max' or s.selected_tag.layout.name == 'fullscreen')
    then
        awful.screen.padding(s, 0)
        if c.floating then
            c.border_width = beautiful.border_width
        else
            c.border_width = 0
        end
    else
        awful.screen.padding(s, { top = 1, right = 2, bottom = 2, left = 2 })
        awful.placement.honor_padding = false
        c.border_width = beautiful.border_width
    end
end

return M
