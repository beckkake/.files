local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")

-- creating the clock widget
mytextclock = wibox.widget {
    {

        {
            {

                format = '%I:%M',
                widget = wibox.widget.textclock,
                halign = "center",
                forced_width = dpi(80)

            },
            widget = wibox.container.margin, -- the center was off for some reason
            margins = {
                top = dpi(0),
                bottom = dpi(-2),
                left = dpi(-2),
                right = dpi(0)
            }
        },
        widget = wibox.container.background,
        shape_border_width = user.border,
        shape_border_color = beautiful.fg_normal
    },
    widget = wibox.container.margin,
    margins = {top = dpi(10), bottom = dpi(10), left = dpi(0), right = dpi(0)}
}
