local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local colors = require("util.colors")
local json = require("util.json")

local gsurface = require("gears.surface")
local floor = math.floor
local lgi = require("lgi")
local gdk = lgi.Gdk
local pixbuf_get_from_surface = gdk.pixbuf_get_from_surface

local M = {}

function M.get_dominant(client)
    local color
    -- gsurface(client.content):write_to_png(
    --     "/home/mutex/nice/" .. client.class .. "_" .. client.instance .. ".png")
    local pb
    local bytes
    local tally = {}
    local content = gsurface(client.content)
    local cgeo = client:geometry()
    local x_offset = 2
    local y_offset = 2
    local x_lim = floor(cgeo.width / 2)
    for x_pos = 0, x_lim, 2 do
        for y_pos = 0, 8, 1 do
            pb = pixbuf_get_from_surface(
                     content, x_offset + x_pos, y_offset + y_pos, 1, 1)
            bytes = pb:get_pixels()
            color = "#" ..
                        bytes:gsub(
                            ".",
                            function(c)
                        return ("%02x"):format(c:byte())
                    end)
            if not tally[color] then
                tally[color] = 1
            else
                tally[color] = tally[color] + 1
            end
        end
    end
    local mode
    local mode_c = 0
    for kolor, kount in pairs(tally) do
        if kount > mode_c then
            mode_c = kount
            mode = kolor
        end
    end
	return mode
end

function M.save(c, focus, focus_top, normal, normal_top)
	local read_file = io.open(string.format("%s/.config/awesome/client_colors.json", os.getenv("HOME")), "rb")
	local client_colors = {}

	if read_file ~= nil then
		client_colors = json.decode(read_file:read("*all")) or {}
		read_file:close()
	else
		awful.spawn.with_shell("touch ~/.config/awesome/client_colors.json")
	end

	client_colors[c.class] = {
		['focus'] = focus,
		['normal'] = normal,
		['focus_top'] = focus_top,
		['normal_top'] = normal_top,
	}

	local write_file = io.open(string.format("%s/.config/awesome/client_colors.json", os.getenv("HOME")), "w")
	write_file:write(json.encode(client_colors))
	write_file:close()
end

function M.update()
	local c = client.focus
	local color = M.get_dominant(c)

	-- Lighten the colors
    local focus = colors.lighten(color, 10)
    local focus_top = colors.lighten(color, 20)
    local normal = colors.lighten(color, 5)
    local normal_top = colors.lighten(color, 10)

	M.save(c, focus, focus_top, normal, normal_top)

	-- Set titlebar
    local positions = { 'top', 'right', 'bottom', 'left' }
	awful.titlebar(c, { position = positions[1], size = beautiful.inner_border_width, bg_focus = focus_top, bg_normal = normal_top }) : setup {
		layout = wibox.layout.align.horizontal
	}
    for i = 2, 4 do
        awful.titlebar(c, { position = positions[i], size = beautiful.inner_border_width, bg_focus = focus, bg_normal = normal }) : setup {
            layout = wibox.layout.align.horizontal
        }
    end
end

return M
