local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local shape = require("util.shape")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local taglist = {}

local taglist_padding = 12

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
        filter = awful.widget.taglist.filter.all,
        widget_template = {
            top = dpi(4),
            bottom = dpi(4),
            left = dpi(0),
            right = dpi(0),
            forced_width = dpi(22),
            widget = wibox.container.margin,
            {
                {
                    {
                        {
                            left = dpi(taglist_padding),
                            right = dpi(taglist_padding),
                            widget = wibox.container.margin
                        },
                        id = 'background_role',
                        widget = wibox.container.background,
                    },
                    top = dpi(6),
                    bottom = dpi(6),
                    left = dpi(6),
                    right = dpi(6),
                    widget = wibox.container.margin,
                },
                shape = shape.rounded_rect(10),
                widget = wibox.container.background,
            },
            create_callback = function(self, c3, _)
                self:connect_signal("mouse::enter", function ()
                    self.widget.bg = beautiful.bg_hover
                end)
                self:connect_signal("mouse::leave", function ()
                    self.widget.bg = nil
                end)
            end,
        },
        buttons = taglist_buttons
    }

    return widget
end

return taglist
