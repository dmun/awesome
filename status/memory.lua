local awful = require("awful")

local interval = 10

awful.widget.watch("cat /proc/meminfo", interval, function(_, stdout)
    local memory

    mem_total = tonumber(stdout:match("MemTotal: *(%d*) kB"))
    shmem = tonumber(stdout:match("Shmem: *(%d*) kB"))
    mem_free = tonumber(stdout:match("MemFree: *(%d*) kB"))
    buffers = tonumber(stdout:match("Buffers: *(%d*) kB"))
    cached = tonumber(stdout:match("Cached: *(%d*) kB"))
    sreclaimable = tonumber(stdout:match("SReclaimable: *(%d*) kB"))

    memory = (mem_total + shmem - mem_free - buffers - cached - sreclaimable) / 1024

    awesome.emit_signal("status::memory", math.floor(memory))
end)
