local awful = require("awful")
local filesystem = require("gears.filesystem")

awful.spawn.once("picom --config " .. filesystem.get_configuration_dir() ..
                     "picom.conf")

awful.spawn.with_shell(
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
