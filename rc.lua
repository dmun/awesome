local beautiful = require("beautiful")
beautiful.init("/home/david/.config/awesome/themes/default/theme.lua")

local naughty = require("naughty")
function Log(message)
    naughty.notify({ title = debug.getinfo(1, "S").source, text = tostring(message) })
end

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local rules = require("rules")
local wibar = require("widgets.wibar")
local json = require("util.json")
local keys = require("keys")
local config = require("config")
local util = require("util")
local shape = require("util.shape")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
require("awful.autofocus")

do
    -- Error handling
    -- Check if awesome encountered an error during startup and fell back to
    -- another config (This code will only ever execute for the fallback config)
    if awesome.startup_errors then
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors,
        })
    end
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if not in_error then
            in_error = true
            naughty.notify({
                preset = naughty.config.presets.critical,
                title = "Oops, an error happened!",
                text = tostring(err),
            })
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
    {
        "hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end,
    },
    { "restart", awesome.restart },
    {
        "quit",
        function()
            awesome.quit()
        end,
    },
}
local mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
    },
})

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper({
        screen = s,
        widget = {
            {
                image = beautiful.wallpaper,
                widget = wibox.widget.imagebox,
                upscale = true,
                downscale = true,
                clip_shape = shape.rounded_rect(15),
                horizontal_fit_policy = "fit",
                vertical_fit_policy = "fit",
                valign = "center",
                halign = "center",
            },
            margins = { top = dpi(config.bar.height) },
            widget = wibox.container.margin,
        },
    })
end)

awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
    local bar = wibar.get(s)
    local hover = wibox({
        screen = s,
        height = 2,
        width = s.workarea.width,
        bg = "#000000",
        opacity = 0,
        ontop = true,
        visible = true,
        y = 0,
        x = 0,
    })
    hover:connect_signal("mouse::enter", function()
        gears.timer.start_new(0.5, function()
            if mouse.coords().y == 0 then
                bar.ontop = true
            end
        end)
    end)
    bar:connect_signal("mouse::enter", function()
        bar.ontop = true
        hover.input_passthrough = true
    end)
    bar:connect_signal("mouse::leave", function()
        bar.ontop = false
        hover.input_passthrough = false
    end)
end)

root.buttons(gears.table.join(
    awful.button({}, 3, function()
        mymainmenu:toggle()
    end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))

root.keys(keys.globalkeys)
awful.rules.rules = rules
-- inner_shades = {}
-- inner_shades:setup({
--     {
--         markup = "XD",
--         widget = wibox.widget.textbox,
--     },
--     x = 0,
--     y = 0,
--     input_passthrough = true,
--     layout = wibox.layout.align.horizontal,
-- })
-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
    c.shape = shape.rounded_rect(15)
    -- inner_shades[c.window] = {}
    -- inner_shades[c.window].top = wibox({
    --     height = 1,
    --     ontop = true,
    --     visible = true,
    --     input_passthrough = true,
    -- })
    -- inner_shades[c.window].right = wibox({
    --     width = 1,
    --     ontop = true,
    --     visible = true,
    --     input_passthrough = true,
    -- })
    -- inner_shades[c.window].bottom = wibox({
    --     height = 1,
    --     ontop = true,
    --     visible = true,
    --     input_passthrough = true,
    -- })
    -- inner_shades[c.window].left = wibox({
    --     width = 1,
    --     ontop = true,
    --     visible = true,
    --     input_passthrough = true,
    -- })
    -- c.update_inner_shade = function(c)
    --     local ok, _ = pcall(function()
    --         return c.border_width
    --     end)
    --     if not ok then
    --         return nil
    --     end
    --
    --     local bw = c.border_width
    --     if c then
    --         inner_shades[c.window].top.bg = c == client.focus and "#ffffff66" or "#ffffff44"
    --         inner_shades[c.window].top.x = c:geometry().x + bw
    --         inner_shades[c.window].top.y = c:geometry().y + bw
    --         inner_shades[c.window].top.width = c:geometry().width
    --         inner_shades[c.window].top.input_passthrough = true
    --
    --         inner_shades[c.window].right.bg = c == client.focus and "#ffffff44" or "#ffffff33"
    --         inner_shades[c.window].right.x = c:geometry().x + c:geometry().width + bw - 1
    --         inner_shades[c.window].right.y = c:geometry().y + bw + 1
    --         inner_shades[c.window].right.height = c:geometry().height - 2
    --         inner_shades[c.window].right.input_passthrough = true
    --
    --         inner_shades[c.window].bottom.bg = c == client.focus and "#ffffff44" or "#ffffff33"
    --         inner_shades[c.window].bottom.x = c:geometry().x + bw
    --         inner_shades[c.window].bottom.y = c:geometry().y + c:geometry().height + bw - 1
    --         inner_shades[c.window].bottom.width = c:geometry().width
    --         inner_shades[c.window].bottom.input_passthrough = true
    --
    --         inner_shades[c.window].left.bg = c == client.focus and "#ffffff44" or "#ffffff33"
    --         inner_shades[c.window].left.x = c:geometry().x + bw
    --         inner_shades[c.window].left.y = c:geometry().y + bw + 1
    --         inner_shades[c.window].left.height = c:geometry().height - 2
    --         inner_shades[c.window].left.input_passthrough = true
    --     end
    -- end
    --
    -- c.hide_inner_shades = function(c)
    --     inner_shades[c.window].visible = false
    --     inner_shades[c.window].top.visible = false
    --     inner_shades[c.window].right.visible = false
    --     inner_shades[c.window].bottom.visible = false
    --     inner_shades[c.window].left.visible = false
    -- end
    -- c.show_inner_shades = function(c)
    --     inner_shades[c.window].visible = true
    --     inner_shades[c.window].top.visible = true
    --     inner_shades[c.window].right.visible = true
    --     inner_shades[c.window].bottom.visible = true
    --     inner_shades[c.window].left.visible = true
    -- end
    -- c.update_visible = function(c)
    --     if c then
    --         if c.screen.selected_tag then
    --             if not c.first_tag then
    --                 return nil
    --             end
    --             for _, value in pairs(c.first_tag:clients()) do
    --                 if inner_shades[value.window] then
    --                     -- value.visible = false
    --                     -- for _, v in pairs(inner_shades[value.window]) do
    --                     inner_shades[value.window].top.visible = true
    --                     inner_shades[value.window].right.visible = true
    --                     inner_shades[value.window].bottom.visible = true
    --                     inner_shades[value.window].left.visible = true
    --                     -- end
    --                 end
    --             end
    --         else
    --             for _, value in pairs(c.first_tag:clients()) do
    --                 inner_shades[value.window].visible = false
    --                 inner_shades[value.window].top.visible = false
    --                 inner_shades[value.window].right.visible = false
    --                 inner_shades[value.window].bottom.visible = false
    --                 inner_shades[value.window].left.visible = false
    --             end
    --         end
    --     end
    -- end
    -- c.update_inner_shade()
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
--client.connect_signal("request::titlebars", function(c)
--    local file = io.open(string.format("%s/.config/awesome/client_colors.json", os.getenv("HOME")), "rb")
--    local client_color = {}
--
--    if file ~= nil then
--        client_color = json.decode(file:read("*all"))[c.class]
--            or { focus = "#3c3c3c", normal = "#303030", focus_top = "#3c3c3c", normal_top = "#303030" }
--        gears.timer.start_new(1, function()
--            require("util.client_colors").update()
--        end)
--        file:close()
--    end
--
--    awful.titlebar(c, {
--        position = "top",
--        size = beautiful.inner_border_width,
--        bg_focus = client_color["focus_top"],
--        bg_normal = client_color["normal_top"],
--    }):setup({
--        layout = wibox.layout.align.horizontal,
--    })
--
--    for _, v in ipairs({ "right", "bottom", "left" }) do
--        awful.titlebar(c, {
--            position = v,
--            size = beautiful.inner_border_width,
--            bg_focus = client_color["focus"],
--            bg_normal = client_color["normal"],
--        }):setup({
--            layout = wibox.layout.align.horizontal,
--        })
--    end
--end)

-- Sloppy focus
if config.sloppy_focus then
    client.connect_signal("mouse::enter", function(c)
        c:emit_signal("request::activate", "mouse_enter", { raise = false })
    end)
end

client.connect_signal("mouse::press", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
    -- util.update_border(c)
    c.border_color = beautiful.border_focus
    c:raise()
    -- if c.update_inner_shade then
    --     c:update_inner_shade()
    --     c:update_visible()
    -- end
end)
client.connect_signal("unfocus", function(c)
    -- util.update_border(c)
    c.border_color = beautiful.border_normal
    -- if c.update_inner_shade then
    --     c:update_inner_shade()
    --     c:update_visible()
    -- end
end)
-- client.connect_signal("unmanage", function(c)
--     c:hide_inner_shades()
-- end)

-- client.connect_signal("request::border", util.update_border)
-- client.connect_signal("property::maximized", util.update_border)
client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        c.shape = nil
    else
        c.shape = shape.rounded_rect(15)
    end
end)
-- client.connect_signal("property::floating", util.update_border)
-- client.connect_signal("property::size", function(c)
--     -- Log(c.class)
--     if c.update_inner_shade then
--         c:update_inner_shade()
--     end
-- end)
-- client.connect_signal("property::position", function(c)
--     -- Log(c.class)
--     if c.update_inner_shade then
--         c:update_inner_shade()
--     end
-- end)

naughty.config.defaults.title = "Notification"
naughty.config.presets.normal = {
    bg = "#ff0000",
}
naughty.config.presets.low = {
    bg = "#ff0000",
}
naughty.config.presets.critical = {
    bg = "#ff0000",
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical

-- Run garbage collector regularly to prevent memory leaks
gears.timer({
    timeout = 30,
    autostart = true,
    callback = function()
        collectgarbage()
    end,
})

for _, v in pairs(config.autostart) do
    awful.spawn.with_shell("pgrep -x '" .. v .. "' > /dev/null || " .. v .. " &")
end
