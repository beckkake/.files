local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- create a spacer
myspacer = {
    widget = wibox.widget.separator,
    forced_height = dpi(1),
    forced_width = dpi(1),
    thickness = dpi(1),
    color = beautiful.fg_normal,
    position = "vertical"
}
