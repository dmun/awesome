local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local taglist = {}

local taglist_padding = 8

local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)


function taglist.get(s)
    local widget = awful.widget.taglist {
        screen = s,
        filter = function (t) return (t.selected or #t:clients() > 0) and t.screen == s end,
        widget_template = {
            {
                {
                    {
                        id = 'text_role',
                        widget = wibox.widget.textbox
                    },
                    left = dpi(taglist_padding),
                    right = dpi(taglist_padding),
                    widget = wibox.container.margin
                },
                id = 'background_role',
                widget = wibox.container.background
            },
            top = 6,
            bottom = 6,
            left = 5,
            right = 5,
            widget = wibox.container.margin,
        },
        buttons = taglist_buttons
    }

    return widget
end

return taglist
