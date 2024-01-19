pcall(require, "luarocks.loader")

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- allow error messages
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    }
end)

-- fix blurry icons
awesome.set_preferred_icon_size(64)

-- require the theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/init.lua")

-- autostart compfy
awful.spawn.once(
    'compfy --config ' .. gears.filesystem.get_configuration_dir() ..
        'base/compfy.conf')

-- initialize main components
require("base")
require("signals")
require("widget")
