local wibox     = require("wibox")
local beautiful = require("beautiful")

local M = wibox.widget {
    widget = wibox.widget.textbox,
}

client.connect_signal("unfocus", function(_)
    M.markup = ""
end)

client.connect_signal("focus", function(c)
    M.font = beautiful.font
    local class_name
    if c.class == nil then
        class_name = "Application"
    else
        class_name = c.class:sub(1,1):upper() .. c.class:sub(2)
    end
    M.markup = "<b>" .. class_name .. "</b>"
end)

return M
