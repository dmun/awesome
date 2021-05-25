local awful = require("awful")

local interval = 10

awful.widget.watch("cat /proc/meminfo", interval, function(_, stdout)
    local memory

    memory = stdout
    for line in stdout do
        memory = line
    end

    awesome.emit_signal("status::memory", memory)
end)
