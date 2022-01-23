local awful      = require("awful")
local wibox      = require("wibox")
local xresources = require("beautiful.xresources")
local dpi        = xresources.apply_dpi
local config     = require("config")

local wibar = {}

function wibar.get(s)
    local mywibox = awful.wibar({
        position = config.bar.position,
        screen = s,
        height = dpi(config.bar.height)
    })

    local taglist = require("widgets.taglist").get(s)

    local widgets = {
        left = {
            {
                taglist,
                left = 5,
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.horizontal,
        },
        middle = {
            layout = wibox.layout.fixed.horizontal,
        },
        right = {
            layout = wibox.layout.fixed.horizontal,
        },
    }

    for k,_ in pairs(config.bar.widgets) do
        for _,v in pairs(config.bar.widgets[k]) do
            table.insert(widgets[k], {
                v,
                left = config.bar.widget_padding,
                right = config.bar.widget_padding,
                widget = wibox.container.margin,
            })
        end
    end

    -- Add widgets to the wibox
    mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
            widgets.left,
            widget = wibox.container.margin
        },
        {
            widgets.middle,
            layout = wibox.layout.align.horizontal,
        },
        {
            widgets.right,
            widget = wibox.container.margin
        }
    }

    return mywibox
end

return wibar
