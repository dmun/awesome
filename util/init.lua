local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

-- TODO: Make it not bad
function M.update_border(c)
    local s = c.screen
    if #s.tiled_clients == 1
        or s.selected_tag and (s.selected_tag.layout.name == "max" or s.selected_tag.layout.name == "fullscreen")
    then
        pcall(c.show_inner_shades, c)
        c.border_width = 0
        if c.floating then
            c.border_width = beautiful.border_width
            pcall(c.show_inner_shades, c)
        elseif s.selected_tag.layout.name == "max" then
            pcall(c.show_inner_shades, c)
            c.border_width = 0
        elseif s.selected_tag.layout.name == "fullscreen" then
            pcall(c.hide_inner_shades, c)
            c.border_width = 0
        end
    else
        pcall(c.show_inner_shades, c)
        c.border_width = beautiful.border_width
    end
end

function M.change(state)
    local c = client.focus
    c.fullscreen = false
    c.maximized = false
    c.ontop = false
    c.floating = false
    awful.layout.set(awful.layout.suit.tile.right)
    if state == "floating" or state == "stacking" then
        c.floating = true
        c.ontop = true
    elseif state == "maximized" then
        awful.layout.set(awful.layout.suit.max)
    elseif state == "fullscreen" then
        awful.layout.set(awful.layout.suit.max.fullscreen)
    end
    for _, tc in pairs(c.screen.tiled_clients) do
        M.update_border(tc)
    end
    M.update_border(c)
end

return M
