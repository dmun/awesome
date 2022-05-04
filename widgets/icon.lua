local wibox     = require("wibox")
local beautiful = require("beautiful")

local M = {}

function M:new(icon, fg)
    return wibox.widget {
        {
            fg = fg or beautiful.fg_normal,
            markup = string.format("<span foreground='%s'>%s</span>", fg, icon),
            font = beautiful.icon_font,
            widget = wibox.widget.textbox,
        },
        bottom = 1,
        widget = wibox.container.margin,
        set = function(self, icon, fg)
            self.widget.markup = string.format("<span foreground='%s'>%s</span>", fg or self.widget.fg, icon)
        end,
    }
end

function M:new(markup)
    return wibox.widget {
        {
            markup = markup,
            font = beautiful.font,
            widget = wibox.widget.textbox,
        },
        top = 0,
        widget = wibox.container.margin,
        set_markup = function(self, markup)
            self.widget.markup = markup
        end,
        get_markup = function(self)
            return self.widget.markup
        end,
        hide = function(self)
            -- Small value to prevent a delay before showing the widget again
            self.forced_width = 0.01
        end,
        show = function(self)
            self.forced_width = nil
        end,
    }
end

return M
