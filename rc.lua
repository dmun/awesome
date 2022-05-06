local beautiful = require("beautiful")
beautiful.init(require("themes.default.theme"))

local naughty = require("naughty")
function Log(message)
    naughty.notify({ title = debug.getinfo(1, 'S').source, text = tostring(message) })
end

local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local rules     = require("rules")
local wibar     = require("widgets.wibar")
local json      = require("util.json")
local keys      = require("keys")
local config    = require("config")
require("awful.autofocus")

do
    -- Error handling
    -- Check if awesome encountered an error during startup and fell back to
    -- another config (This code will only ever execute for the fallback config)
    if awesome.startup_errors then
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, there were errors during startup!",
                         text = awesome.startup_errors })

    end
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if not in_error then
            in_error = true
            naughty.notify({ preset = naughty.config.presets.critical,
                             title = "Oops, an error happened!",
                             text = tostring(err) })
            in_error = false
        end
    end)
end

-- Layouts
awful.layout.layouts = {
    awful.layout.suit.tile.right,
    awful.layout.suit.tile.left,
}

-- Menu
local myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}
local mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
    }
})

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        -- gears.wallpaper.maximized(wallpaper, s, true)
        gears.wallpaper.set(beautiful.wallpaper_color)
    end
end
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])
    local bar = wibar.get(s)
    local hover = wibox({
        screen = s,
        height = 2,
        width = s.workarea.width,
        bg = "#000000",
        opacity = 1,
        ontop = true,
        visible = true,
        y = 0,
        x = 0,
    })
    hover:connect_signal("mouse::enter", function ()
        gears.timer.start_new(0.5, function ()
            if mouse.coords().y == 0 then
                bar.ontop = true
            end
        end)
    end)
    bar:connect_signal("mouse::enter", function ()
        bar.ontop = true
        hover.input_passthrough = true
    end)
    bar:connect_signal("mouse::leave", function ()
        bar.ontop = false
        hover.input_passthrough = false
    end)
end)

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

root.keys(keys.globalkeys)
awful.rules.rules = rules

-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    local file = io.open(string.format("%s/.config/awesome/client_colors.json", os.getenv("HOME")), "rb")
    local client_color = {}

    if file ~= nil then
        client_color = json.decode(file:read("*all"))[c.class] or { focus = "#3c3c3c", normal = "#303030", focus_top = "#3c3c3c", normal_top = "#303030" }
        gears.timer.start_new(1, function ()
            require("util.client_colors").update()
        end)
        file:close()
    end

    awful.titlebar(c, {
            position = "top",
            size = beautiful.inner_border_width,
            bg_focus = client_color["focus_top"],
            bg_normal = client_color["normal_top"],
        }) : setup {
        layout = wibox.layout.align.horizontal
    }

    for _,v in ipairs({ "right", "bottom", "left" }) do
        awful.titlebar(c, {
                position = v,
                size = beautiful.inner_border_width,
                bg_focus = client_color["focus"],
                bg_normal = client_color["normal"],
            }) : setup {
            layout = wibox.layout.align.horizontal
        }
    end
end)

-- Sloppy focus
if config.sloppy_focus then
    client.connect_signal("mouse::enter", function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end)
end

local util = require("util")

client.connect_signal("focus", function(c) util.update_border(c) c.border_color = beautiful.border_focus c:raise() end)
client.connect_signal("unfocus", function(c) util.update_border(c) c.border_color = beautiful.border_normal end)

client.connect_signal("request::border", util.update_border)
client.connect_signal("property::maximized", util.update_border)
client.connect_signal("property::floating", util.update_border)

for _,v in pairs(config.autostart) do
    awful.spawn.with_shell("pgrep -x '" .. v .. "' > /dev/null || " .. v .. " &")
end
