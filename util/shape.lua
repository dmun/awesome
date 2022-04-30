local gears = require("gears")

local M = {}

function M.rounded_rect(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

function M.circle(radius)
    return function(cr, width, height)
        gears.shape.circle(cr, width, height, radius)
    end
end

return M
