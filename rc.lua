-- Standard awesome library
local gears = require("gears")
local gsurface = require("gears.surface")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

local wibar = require("widgets.wibar")
local floor = math.floor
local gcolor = require('gears.color')
local lgi = require("lgi")
local cairo = lgi.cairo
local gdk = lgi.Gdk
local get_default_root_window = gdk.get_default_root_window
local pixbuf_get_from_surface = gdk.pixbuf_get_from_surface

local function lighten(color, amount)
    local r, g, b
    r, g, b = gcolor.parse_color(color)
    r = 255 * r
    g = 255 * g
    b = 255 * b
    r = r + floor(2.55 * amount)
    g = g + floor(2.55 * amount)
    b = b + floor(2.55 * amount)
    r = r > 255 and 255 or r
    g = g > 255 and 255 or g
    b = b > 255 and 255 or b
    return ("#%02x%02x%02x"):format(r, g, b)
end

local json = require("util.json")

local function reset_client_color(c, focus, normal)
	local read_file = io.open(string.format("%s/.config/awesome/client_color.json", os.getenv("HOME")), "rb")
	local client_colors = json.decode(read_file:read("*all"))
	read_file:close()

	client_colors[c.class] = {
		["focus"] = focus,
		["normal"] = normal,
	}

	local write_file = io.open(string.format("%s/.config/awesome/client_color.json", os.getenv("HOME")), "w")
	write_file:write(json.encode(client_colors))
	write_file:close()
end

function reset_titlebar_color()
	local c = client.focus
	local mode = require('titlebar')(c)
    local focus = lighten(mode, 10)
    local normal = lighten(mode, 5)
	reset_client_color(c, focus, normal)
    local positions = { "top", "right", "bottom", "left" }
    for i = 1, 4 do
        awful.titlebar(c, { position = positions[i], size = 2, bg_focus = focus, bg_normal = normal }) : setup {
            layout = wibox.layout.align.horizontal
        }
    end
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "default")
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Layouts.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        -- gears.wallpaper.maximized(wallpaper, s, true)
        gears.wallpaper.set("#131313")
    end
end
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "", "", "", "", "" }, s, awful.layout.layouts[1])

    wibar.get(s)
end)

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

require("keys")

require("rules")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	local file = io.open(string.format("%s/.config/awesome/client_color.json", os.getenv("HOME")), "rb")
	local client_color = {}

	if file ~= nil then
		client_color = json.decode(file:read("*all"))[c.class]
		file:close()
	end

	local positions = { "top", "right", "bottom", "left" }
	for i = 1, 4 do
		awful.titlebar(c, {
				position = positions[i],
				size = 2,
				bg_focus = client_color["focus"] or "#3c3c3c",
				bg_normal = client_color["normal"] or "#303030",
			}) : setup {
			layout = wibox.layout.align.horizontal
		}
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus c:raise() end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

function change_client_state(state)
    client.focus.fullscreen = false
    client.focus.maximized = false
    client.focus.ontop = false
    client.focus.floating = false
    if state == "floating" or state == "stacking" then
        client.focus.floating = true
        client.focus.ontop = true
    elseif state == "maximized" then
        client.focus.maximized = true
        client.focus.ontop = true
    elseif state == "fullscreen" then
        client.focus.ontop = true
        client.focus.fullscreen = true
    end
end

-- Autostart
awful.spawn.with_shell("xset r rate 200 60")
awful.spawn.with_shell("sxhkd")
