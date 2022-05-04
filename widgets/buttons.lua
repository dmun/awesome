local wibox      = require("wibox")
local util       = require("util")
local xresources = require("beautiful.xresources")
local dpi        = xresources.apply_dpi
local shape      = require("util.shape")
local awful      = require("awful")

local M = {}

local button_spacing = 8

local buttons = {
    {
        fg       = "#FF6C6B",
        fg_hover = "#fcbaba",
        left = function ()
            client.focus:kill()
        end
    },
    {
        fg       = "#ECBE7B",
        fg_hover = "#fcdeb0",
        left = function ()
            util.change("default")
        end
    },
    {
        fg       = "#98BE65",
        fg_hover = "#cce5ac",
        right = function ()
            if awful.screen.focused().selected_tag.layout.name == "fullscreen" or client.focus.fullscreen then
                util.change("default")
            else
                util.change("fullscreen")
            end
        end,
        left = function ()
            if awful.screen.focused().selected_tag.layout.name == "max" or client.focus.maximized then
                util.change("default")
            else
                util.change("maximized")
            end
        end
    },
}

local processed = {}

for i, button in pairs(buttons) do
    -- local tre = awful.widget.button()
    local circle = wibox.widget {
        {
            forced_width = dpi(10),
            forced_height = dpi(10),
            widget = awful.widget.button,
        },
        bg = "#333333",
        shape = shape.circle(dpi(5)),
        widget = wibox.container.background,
    }
    circle:connect_signal("mouse::enter", function(c)
        if client.focus ~= nil then
            c:set_bg(button.fg_hover)
        end
    end)
    circle:connect_signal("mouse::leave", function(c)
        if client.focus ~= nil then
            c:set_bg(button.fg)
        end
    end)
    client.connect_signal("focus", function()
        circle:set_bg(button.fg)
    end)
    client.connect_signal("unfocus", function()
        circle:set_bg("#333333")
    end)
    circle:connect_signal("button::press", function(_, _, _, pressed)
        if client.focus ~= nil then
            if pressed == 1 and button.left then
                button.left()
            elseif pressed == 3 and button.right then
                button.right()
            end
        end
    end
    )
    table.insert(processed, {
        circle,
        right = i == #buttons and 0 or dpi(button_spacing),
        top = dpi(8),
        bottom = dpi(8),
        widget = wibox.container.margin,
    })
end

M = wibox.widget {
    layout = wibox.layout.align.horizontal,
    processed[1],
    processed[2],
    processed[3],
    highlight = false,
}

return M
