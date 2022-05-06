local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

-- TODO: Make it not bad
function M.update_border(c)
    local s = c.screen
    if #s.tiled_clients == 1
        or s.selected_tag and (s.selected_tag.layout.name == 'max' or s.selected_tag.layout.name == 'fullscreen')
    then
        if c.floating then
            c.border_width = beautiful.border_width
            awful.titlebar.show(c, "top")
            awful.titlebar.show(c, "right")
            awful.titlebar.show(c, "bottom")
            awful.titlebar.show(c, "left")
        elseif s.selected_tag.layout.name == "max" then
            awful.screen.padding(s, { top = 0, right = -2, bottom = -2, left = -2 })
            awful.titlebar.show(c, "top")
            awful.titlebar.show(c, "right")
            awful.titlebar.show(c, "bottom")
            awful.titlebar.show(c, "left")
        elseif s.selected_tag.layout.name == 'fullscreen' then
            awful.titlebar.hide(c, "top")
            awful.titlebar.hide(c, "right")
            awful.titlebar.hide(c, "bottom")
            awful.titlebar.hide(c, "left")
            c.border_width = 0
        else
            awful.screen.padding(s, 0)
            awful.screen.padding(s, { top = 0, right = -2, bottom = -2, left = -2 })
        end
    else
        awful.titlebar.show(c, "top")
        awful.titlebar.show(c, "right")
        awful.titlebar.show(c, "bottom")
        awful.titlebar.show(c, "left")
        awful.screen.padding(s, { top = 1, right = 2, bottom = 2, left = 2 })
        awful.placement.honor_padding = false
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
    for _,tc in pairs(c.screen.tiled_clients) do
        M.update_border(tc)
    end
    M.update_border(c)
end

return M
