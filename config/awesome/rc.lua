pcall(require, "luarocks.loader")

local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    }
end)

awesome.set_preferred_icon_size(64)

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/init.lua")

require("base")
require("signals")
require("widget")

--[[local workspace_grid = require("modules.awesome-workspace-grid")
grid = workspace_grid({position = "bottom_right", rows = 3, columns = 3})]]
