local gears = require("gears")
local awful = require("awful")

-- Default modkey.
modkey = "Mod4"

-- {{{ Key bindings
globalkeys = gears.table.join()

clientkeys = gears.table.join()

clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    ),
    awful.button(
        {modkey},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {modkey},
        3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)

globalkeys = gears.table.join(
	awful.key({ modkey }, "r",
		function ()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal(
					"request::activate", "key.unminimize", {raise = true}
				)
			end
		end,
	{ description = "restore minimized", group = "client" })
)

-- Set keys
root.keys(globalkeys)
-- }}}
