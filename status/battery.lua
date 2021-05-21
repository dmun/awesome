local awful = require("awful")

local interval = 10

awful.widget.watch("acpi", interval, function(_, stdout)
    local capacity = 0
    local charging = false

    capacity = tonumber(string.match(stdout, "(%d?%d?%d)%%"))
    if (string.match(stdout, ": (%w+)") == "Charging") then
        charging = true
    end

    awesome.emit_signal("status::battery", capacity, charging)
end)
