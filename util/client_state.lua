local M = {}

function M.change(state)
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

return M
