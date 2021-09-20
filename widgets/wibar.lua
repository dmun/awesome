local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local widget_padding = 18
local wibar_height = 24

-- Widgets
local mytaglist   = require "widgets.taglist"
local mysystray   = require "widgets.systray"
local mybattery   = require "widgets.battery"
local mynetwork   = require "widgets.network"
local mymemory    = require "widgets.memory"
local mycpu       = require "widgets.cpu"
local mytextclock = require "widgets.textclock"
local mykblayout  = awful.widget.keyboardlayout()

-- Activated widgets
local left_widgets = {
    wibox.widget {
        markup = "",
        widget = wibox.widget.textbox,
    },
}

local middle_widgets = {}

local right_widgets = {
    mysystray,
    -- mymemory,
    -- mycpu,
    mykblayout,
    mybattery,
    -- mynetwork,
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
    }

    local middle = {
        layout = wibox.layout.fixed.horizontal,
        taglist,
    }

    local right = {
        layout = wibox.layout.fixed.horizontal,
    }

    for _,v in ipairs(right_widgets) do
        right[#right+1] = ({
            v,
            left = widget_padding,
            right = widget_padding,
            widget = wibox.container.margin,
        })
    end

    for _,v in ipairs(middle_widgets) do
        middle[#middle+1] = ({
            v,
            left = widget_padding,
            right = widget_padding,
            widget = wibox.container.margin,
        })
    end

    for _,v in ipairs(left_widgets) do
        left[#left+1] = ({
            v,
            left = widget_padding,
            right = widget_padding,
            widget = wibox.container.margin,
        })
    end

    -- Add widgets to the wibox
    mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            left,
            widget = wibox.container.margin
        },
        { -- Middle widgets
            middle,
            layout = wibox.layout.align.horizontal,
        },
        { -- Right widgets
            right,
            widget = wibox.container.margin
        }
    }

    return mywibox
end

return wibar
