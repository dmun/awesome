local awful = require("awful")

local interval = 10

awful.widget.watch('sh -c "top -bn1 | grep \"Cpu\""', interval, function(_, stdout)
    local us = tonumber(string.match(stdout, ' (.*) us'))
    local sy = tonumber(string.match(stdout, ', *(.*) sy'))
    local usage = us + sy
    awesome.emit_signal("status::cpu", usage)
end)
