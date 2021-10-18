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
    M.markup = "<b>" .. c.class .. "</b>"
end)

return M
