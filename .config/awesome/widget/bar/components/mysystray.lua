local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")
local helpers = require("base.helpers.extras")

systray = wibox.widget {
    {
        {widget = wibox.widget.systray, base_size = 28},
        widget = wibox.container.margin,
        margins = {top = dpi(2), bottom = dpi(2), left = dpi(0), right = dpi(0)}
    },
    widget = wibox.container.margin,
    margins = {top = dpi(12), bottom = dpi(12), left = dpi(6), right = dpi(6)},
    visible = false
}

systrayButton = wibox.widget {
    {
        {
            {image = beautiful.arrow, widget = wibox.widget.imagebox},
            widget = wibox.container.margin,
            margins = {
                top = dpi(8),
                bottom = dpi(8),
                left = dpi(8),
                right = dpi(8)
            }

        },
        widget = wibox.container.background,
        shape_border_width = user.border,
        shape_border_color = beautiful.fg_normal
    },
    widget = wibox.container.margin,
    margins = {top = dpi(10), bottom = dpi(10), left = dpi(0), right = dpi(0)},
    buttons = {
        awful.button({}, 1, function()
            systray.visible = not systray.visible
        end)
    }

}

helpers.hoverCursor(systrayButton)
