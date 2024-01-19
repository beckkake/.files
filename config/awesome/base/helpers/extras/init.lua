local awful = require("awful")
local gears = require("gears")
local helpers = {}

function hovercursor(widget)
    local oldcursor, oldwibox
    widget:connect_signal("mouse::enter", function()
        local wb = mouse.current_wibox
        if wb == nil then return end
        oldcursor, oldwibox = wb.cursor, wb
        wb.cursor = "hand2"
    end)
    widget:connect_signal("mouse::leave", function()
        if oldwibox then
            oldwibox.cursor = oldcursor
            oldwibox = nil
        end
    end)
    return widget
end

-- i forgot what this does
helpers.inTable = function(t, v)
    for _, value in ipairs(t) do if value == v then return true end end
end

-- colorize text
helpers.colorizeText = function(txt, fg)
    if fg == "" then fg = "#ffffff" end

    return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

return helpers
