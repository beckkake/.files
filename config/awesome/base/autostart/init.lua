local awful = require("awful")
local gears = require("gears")

awful.spawn.once(
    'compfy --config ' .. gears.filesystem.get_configuration_dir() ..
        'base/compfy.conf')
