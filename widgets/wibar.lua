local awful      = require("awful")
local wibox      = require("wibox")
local beautiful  = require("beautiful")
local shape      = require("util.shape")
local xresources = beautiful.xresources
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
    taglist.highlight = false
    table.insert(config.bar.widgets.left, taglist)

    local widgets = {
        left = {
            -- {
            --     {
            --         text = " ",
            --         widget = wibox.widget.textbox
            --     },
            --     left = dpi(18),
            --     widget = wibox.container.margin
            -- },
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
            local widget = wibox.widget {
                {
                    v,
                    top = 2,
                    left = config.bar.widget_padding,
                    right = config.bar.widget_padding,
                    widget = wibox.container.margin,
                },
                shape = shape.rounded_rect(6),
                widget = wibox.container.background,
            }
            if v.highlight ~= false then
                widget:connect_signal("mouse::enter", function(c) c:set_bg("#282C34") end)
                widget:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)
            end
            table.insert(widgets[k], widget)
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
