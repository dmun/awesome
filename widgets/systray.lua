local wibox      = require("wibox")
local xresources = require("beautiful.xresources")
local dpi        = xresources.apply_dpi

local systray = {
    wibox.widget.systray(),
    top = dpi(7),
    bottom = dpi(6),
    widget = wibox.container.margin
}

return systray
