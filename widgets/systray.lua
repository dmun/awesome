local wibox      = require("wibox")
local xresources = require("beautiful.xresources")
local dpi        = xresources.apply_dpi

local systray = {
    wibox.widget.systray(),
    top = dpi(8),
    bottom = dpi(8),
    widget = wibox.container.margin,
    highlight = false,
}

return systray
