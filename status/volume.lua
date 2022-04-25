local awful = require("awful")
local gears = require("gears")

local emittable = true
local debounce = 0.1

local M = {}

awful.spawn.easy_async_with_shell("killall pactl", function()
    function M.emit()
        awful.spawn.easy_async_with_shell("pactl get-sink-volume 0", function(stdout)
            local volume = tonumber(stdout:match("(%d*)%%"))
            awful.spawn.easy_async_with_shell("pactl get-sink-mute 0 | cut -d ' ' -f 2", function(stdout)
                local muted = false
                if stdout:find("yes") then
                    muted = true
                end
                awesome.emit_signal("status::volume", volume, muted)
            end)
        end)
    end

    awful.spawn.with_line_callback("pactl subscribe", {
        stdout = function()
            if emittable then
                emittable = false
                M.emit()
            end
            gears.timer.start_new(debounce, function()
                emittable = true
            end)
        end
    })

    M.emit()
end)

return M
