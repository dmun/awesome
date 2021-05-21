local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local widget_padding = 10
local wibar_height = 22

-- Widget imports
local mytaglist = require("widgets.taglist")
local mysystray = require("widgets.systray")
local mybattery = require("widgets.battery")
local mynetwork = require("widgets.network")
local mytextclock = require("widgets.textclock")

-- Activated widgets
local right_widgets = {
    mysystray,
    mybattery,
    mynetwork,
    mytextclock
}

local wibar = {}

function wibar.get(s)
    local mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = dpi(wibar_height)
    })

    local taglist = mytaglist.get(s)

    -- TODO modular left widgets
    local left = {
        layout = wibox.layout.fixed.horizontal,
        taglist
    }

    local right = {
        layout = wibox.layout.fixed.horizontal,
    }

    for i,v in ipairs(right_widgets) do
        right[#right+1] = ({
            v,
            left = widget_padding,
            right = widget_padding,
            widget = wibox.container.margin
        })
    end

    -- Add widgets to the wibox
    mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            left,
            left = 20,
            right = 10,
            widget = wibox.container.margin
        },
        { -- Middle widgets
            layout = wibox.layout.align.horizontal,
        },
        { -- Right widgets
            right,
            right = 10,
            widget = wibox.container.margin
        }
    }

    return mywibox
end

return wibar
