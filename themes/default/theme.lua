---------------------------
-- Default awesome theme --
---------------------------

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")

local themes_path = "~/.config/awesome/themes/"

local theme = {}

theme.font          = "JetBrainsMono Nerd Font Medium 8"

-- theme.bg_normal     = "#232831"
-- theme.bg_focus      = "#2d333f"
theme.bg_normal     = "#1d2026"
theme.bg_focus      = "#dddddd"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal
theme.systray_icon_spacing = 15

theme.fg_normal     = "#dddddd"
theme.taglist_fg_empty = "#5B6268"
theme.taglist_bg_occupied = "#2b313b"
theme.taglist_shape = require("util.shape").rounded_rect(dpi(2))
theme.fg_focus      = "#21242b"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.gap_single_client = false
theme.useless_gap   = dpi(0)
theme.useless_gap   = -1
theme.border_width  = 1
theme.inner_border_width  = 0
theme.border_normal = "#000000"
theme.border_focus  = "#51afef"
theme.border_marked = "#a9a1e1"

theme.notification_font = "sans 11"
theme.notification_margin = 100
theme.notification_spacing = dpi(15)
theme.notification_border_width = 2

theme.snap_bg = "#51afef"
theme.snap_shape = require("util.shape").rounded_rect(0)

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = themes_path .. "default/background.png"
theme.wallpaper_color = "#1b1e23"
theme.icon_theme = nil

return theme
