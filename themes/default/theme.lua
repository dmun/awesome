---------------------------
-- Default awesome theme --
---------------------------

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local themes_path = "~/.config/awesome/themes/"

local theme = {}

theme.font          = "monospace 8"

-- theme.bg_normal     = "#232831"
-- theme.bg_focus      = "#2d333f"
theme.bg_normal     = "#21242b"
theme.bg_focus      = "#181a23"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal
theme.systray_icon_spacing = 15

theme.fg_normal     = "#dddddd"
theme.taglist_fg_empty = "#5B6268"
theme.fg_focus      = "#dddddd"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.gap_single_client = false
theme.useless_gap   = dpi(5)
theme.border_width  = 1
theme.inner_border_width  = 2
theme.border_normal = "#000000"
theme.border_focus  = "#000000"
-- theme.border_focus  = "#9177ac"
theme.border_marked = "#91231c"

theme.notification_font = "sans 11"
theme.notification_margin = 100
theme.notification_spacing = dpi(15)
theme.notification_border_width = 2

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = themes_path .. "default/background.png"
theme.wallpaper_color = "#1b1e23"
theme.icon_theme = nil

return theme
