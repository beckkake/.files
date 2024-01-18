local _M = {}

local awful = require("awful")
local gears = require("gears")

_M.colorizeText = function(txt, fg)
    if fg == "" then fg = "#ffffff" end

    return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

return _M
