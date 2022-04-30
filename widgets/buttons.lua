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
        "#FF6C6B",
        "#fc9292",
        function ()
            client.focus:kill()
        end
    },
    {
        "#ECBE7B",
        "#edcb97",
        function ()
            util.change("default")
        end
    },
    {
        "#98BE65",
        "#b1d187",
        function ()
            util.change("maximized")
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
        bg = button[1],
        shape = shape.circle(dpi(5)),
        widget = wibox.container.background,
    }
    circle:connect_signal("mouse::enter", function(c)
        if client.focus ~= nil then
            c:set_bg(button[2])
        end
    end)
    circle:connect_signal("mouse::leave", function(c)
        if client.focus ~= nil then
            c:set_bg(button[1])
        end
    end)
    client.connect_signal("focus", function()
        circle:set_bg(button[1])
    end)
    client.connect_signal("unfocus", function()
        circle:set_bg("#5B6268")
    end)
    circle:connect_signal("button::press", function ()
        if client.focus ~= nil then
            button[3]()
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
