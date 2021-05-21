---------------------------
-- Default awesome theme --
---------------------------

local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local themes_path = "~/.config/awesome/themes/"

local theme = {}

theme.font          = "Ubuntu 11"
theme.icon_font     = "Ubuntu 11"
theme.taglist_font  = "Symbols Nerd Font 12"

-- theme.bg_normal     = "#232831"
-- theme.bg_focus      = "#2d333f"
theme.bg_normal     = "#090909"
theme.bg_focus      = "#1e1e1e"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal
theme.systray_icon_spacing = 15

theme.fg_normal     = "#ffffff"
theme.taglist_fg_empty = "#555555"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.gap_single_client = false
theme.useless_gap   = dpi(5)
theme.border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = "#000000"
theme.border_marked = "#91231c"

-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = themes_path .. "default/macOS-Big-Sur-Daylight-Wallpaper-iDownloadBlog-2.jpg"
theme.icon_theme = nil

return theme
