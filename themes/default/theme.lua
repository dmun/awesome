---------------------------
-- Default awesome theme --
---------------------------

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")

local themes_path = "~/.config/awesome/themes/"

local theme = {}

theme.red           = "#E3605F"

theme.font          = "PingFangSC-Medium 9"
theme.icon_font     = "JetBrainsMono Nerd Font 10"

-- theme.bg_normal     = "#232831"
-- theme.bg_focus      = "#2d333f"
theme.bg_normal     = "#000"
theme.bg_hover      = "#1a1a1a"
theme.bg_focus      = "#ffffff"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal
theme.systray_icon_spacing = 20

theme.taglist_bg_empty = "#333333"
theme.taglist_bg_occupied = "#5B6268"

theme.fg_normal     = "#ffffff"
theme.taglist_shape = require("util.shape").rounded_rect(dpi(8))
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.gap_single_client = false
theme.useless_gap   = dpi(4)
-- theme.useless_gap   = -1
theme.border_width  = 1
theme.inner_border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = "#000000"
theme.border_marked = "#a9a1e1"

theme.notification_font = "sans 11"
theme.notification_margin = 100
theme.notification_spacing = dpi(15)
theme.notification_border_width = 2

theme.snap_bg = "#00ff0044"
theme.snap_shape = require("util.shape").rounded_rect(0)

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = themes_path .. "default/background.jpg"
theme.wallpaper_color = "#1b1e23"
theme.icon_theme = nil

return theme
