local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = require("beautiful.xresources").apply_dpi

local M = {}

function M:new_icon(icon, fg)
    return wibox.widget {
        {
            fg = fg or beautiful.fg_normal,
            icon = icon or "<?>",
            markup = string.format("<span foreground='%s'>%s</span>", fg or beautiful.fg_normal, icon or "<?>"),
            font = beautiful.icon_font,
            widget = wibox.widget.textbox,
        },
        bottom = 1,
        widget = wibox.container.margin,
        set = function(self, icon, fg, right)
            self.widget.markup = string.format("<span foreground='%s'>%s</span>", fg or self.widget.fg, icon or self.widget.icon)
            self.right = dpi(right or 0)
        end,
        set_right = function(self, right)
            self.right = dpi(right or 0)
        end,
    }
end

function M:new_text(markup)
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
        toggle = function(self)
            self.forced_width = self.forced_width == nil and 0.01 or nil
        end,
    }
end

return M
