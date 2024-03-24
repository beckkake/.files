local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local theme = require("theme")
local gears = require("gears")
local bling = require("modules.bling")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi
require("theme.bling")

return function()
    return wibox.widget {

        {

            {
                image = gears.color.recolor_image(theme.x, beautiful.bg_light),
                widget = wibox.widget.imagebox
            },
            margins = {
                left = dpi(32),
                right = dpi(32),
                top = dpi(12),
                bottom = dpi(12)
            },
            widget = wibox.container.margin
        },
        bg = beautiful.bg_dark,
        widget = wibox.container.background,
        buttons = {
            awful.button({}, 1, function()
                local app_launcher = bling.widget.app_launcher(args)
                app_launcher:toggle()
            end)
        }
    }
end
