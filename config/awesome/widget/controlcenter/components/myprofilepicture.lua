local wibox = require("wibox")
local user = require("user")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

myprofilepicture = wibox.widget {
    {
        {
            widget = wibox.widget.imagebox,
            image = user.avatar,
            forced_width = dpi(85),
            forced_height = dpi(85)
        },
        widget = wibox.container.margin,
        margins = {top = dpi(4), bottom = dpi(4), left = dpi(4), right = dpi(4)}
    },
    widget = wibox.container.background,
    shape_border_width = user.border,
    shape_border_color = beautiful.fg_normal
}

