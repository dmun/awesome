local wibox      = require("wibox")
local util       = require("util")
local xresources = require("beautiful.xresources")
local dpi        = xresources.apply_dpi

local M = {}

local button_spacing = 8

local close = wibox.widget {
    {
        markup = "<span foreground='#FF6C6B'>" .. "" .. "</span>",
        fg = "#FF6C6B",
        widget = wibox.widget.textbox,
    },
    right = dpi(button_spacing),
    widget = wibox.container.margin,
}

local minimize = wibox.widget {
    {
        markup = "<span foreground='#ECBE7B'>" .. "" .. "</span>",
        fg = "#ECBE7B",
        widget = wibox.widget.textbox,
    },
    right = dpi(button_spacing),
    widget = wibox.container.margin,
}

local maximize = wibox.widget {
    {
        markup = "<span foreground='#98BE65'>" .. "" .. "</span>",
        fg = "#98BE65",
        widget = wibox.widget.textbox,
    },
    widget = wibox.container.margin,
}

close:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        client.focus:kill()
    end
end)

minimize:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        util.change("default")
    end
end)

maximize:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        util.change("maximized")
    elseif button == 2 then
        util.change("fullscreen")
    end
end)

M = wibox.widget {
    layout = wibox.layout.align.horizontal,
    close,
    minimize,
    maximize,
    highlight = false,
}

return M
