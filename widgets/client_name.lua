local wibox = require("wibox")
local beautiful = require("beautiful")

local text = require("widgets").new_text("<b>Desktop</b>")

local M = wibox.widget({
    text,
    widget = wibox.layout.align.horizontal,
})

client.connect_signal("unfocus", function()
    text:set_markup("<b>Desktop</b>")
end)

client.connect_signal("focus", function(c)
    local class_name = ""
    if c.class == nil then
        class_name = "Application"
    else
        class_name = c.class:gsub("^%l", string.upper)
    end
    text:set_markup(string.format("<b>%s</b>", class_name))
end)

return M
