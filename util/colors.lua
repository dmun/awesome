local floor = math.floor
local gcolor = require('gears.color')

local M = {}

function M.lighten(color, amount)
    local r, g, b
    r, g, b = gcolor.parse_color(color)
    r = 255 * r
    g = 255 * g
    b = 255 * b
    r = r + floor(2.55 * amount)
    g = g + floor(2.55 * amount)
    b = b + floor(2.55 * amount)
    r = r > 255 and 255 or r
    g = g > 255 and 255 or g
    b = b > 255 and 255 or b
    return ("#%02x%02x%02x"):format(r, g, b)
end

return M
