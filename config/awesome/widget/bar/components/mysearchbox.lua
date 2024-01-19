local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local user = require("user")

local launcher = require("widget.launcher")
local bling = require("modules.bling")

mysearchbox = hovercursor(wibox.widget {
    {
        {
            {image = beautiful.search, widget = wibox.widget.imagebox},
            widget = wibox.container.margin,
            margins = {
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(5),
                right = dpi(5)
            }
        },
        widget = wibox.container.background,
        shape_border_width = user.border,
        shape_border_color = beautiful.fg_normal
    },
    widget = wibox.container.margin,
    margins = {top = dpi(10), bottom = dpi(10), left = dpi(8), right = dpi(0)},
    buttons = {
        awful.button({}, 1, function()
            local app_launcher = bling.widget.app_launcher(launcher)
            app_launcher:toggle()
        end)
    }
})

