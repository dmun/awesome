local awful = require "awful"
local util  = require("util")

local M = {}

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
    util.update_border(c)
end

return M
