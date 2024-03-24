local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

return function()
    return wibox.widget {
        {
            {

                {
                    widget = wibox.widget.textclock(),
                    font = "Balsamiq Sans 26",
                    format = "%I\n%M",
                    align = "center"
                },
                bg = beautiful.bg_light,
                shape = helpers.shape(10),
                forced_height = 90,
                widget = wibox.container.background
            },
            margins = {
                top = dpi(12),
                bottom = dpi(12),
                left = dpi(12),
                right = dpi(12)
            },
            widget = wibox.container.margin
        },
        bg = beautiful.bg_dark,
        widget = wibox.container.background
    }
end
