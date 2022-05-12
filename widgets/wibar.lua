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
    table.insert(config.bar.widgets.middle, taglist)

    local widgets = {
        left = {
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
        for _,widget in pairs(config.bar.widgets[k]) do
            local spaced = wibox.widget {
                {
                    widget,
                    top = 2,
                    left = dpi(config.bar.widget_padding),
                    right = dpi(config.bar.widget_padding),
                    widget = wibox.container.margin,
                },
                shape = shape.rounded_rect(dpi(6)),
                widget = wibox.container.background,
            }

            if widget.highlight ~= false then
                spaced:connect_signal("mouse::enter", function(c) c:set_fg("#FFFFFF") c:set_bg(beautiful.bg_hover) end)
                spaced:connect_signal("mouse::leave", function(c) c:set_fg(beautiful.fg_normal) c:set_bg(beautiful.bg_normal) end)
            end

            local buttons = {
                {1, widget.left_click},
                {2, widget.middle_click},
                {3, widget.right_click},
                {4, widget.scroll_up},
                {5, widget.scroll_down},
            }

            for _, button in pairs(buttons) do
                if button[2] then
                    spaced:connect_signal("button::press", function(_, _, _, pressed)
                        if pressed == button[1] then
                            if type(button[2]) == "string" then
                                awful.spawn(button[2])
                            elseif type(button[2]) == "function" then
                                button[2](widget)
                            end
                        end
                    end)
                end
            end


            table.insert(widgets[k], spaced)
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
            right = dpi(8),
            widget = wibox.container.margin
        }
    }

    return mywibox
end

return wibar
