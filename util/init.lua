local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

function M.update_border(c)
    local s = awful.screen.focused()
    if c.maximized
        or (#s.tiled_clients == 1 and not c.floating)
        or (s.selected_tag and (s.selected_tag.layout.name == 'max' or s.selected_tag.layout.name == 'fullscreen'))
    then
        c.border_width = 0
    else
        c.border_width = beautiful.border_width
    end
end

return M
