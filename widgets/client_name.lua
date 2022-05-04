local wibox     = require("wibox")
local beautiful = require("beautiful")

local text = require("widgets").new_text("")

local M = wibox.widget {
    text,
    widget = wibox.layout.align.horizontal,
    left_click = function ()
        require("util.client_colors").update()
    end
}

client.connect_signal("unfocus", function()
    text:set_markup("")
end)

client.connect_signal("focus", function(c)
    local class_name
    if c.class == nil then
        class_name = "Application"
    else
        class_name = c.class:sub(1,1):upper() .. c.class:sub(2)
    end
    text:set_markup(string.format("<b>%s</b>", class_name))
end)

return M
