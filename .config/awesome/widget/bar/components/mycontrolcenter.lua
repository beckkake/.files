-- initiliaze indirect elements
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local user = require("user")

-- initiliaze direct elements
local helpers = require("base.helpers.extras")
local click_to_hide = require("base.helpers.click_to_hide")
require("widget.controlCenter")

-- create the actual widget
mycontrolcenter = wibox.widget {
    {
        {
            {image = beautiful.home, widget = wibox.widget.imagebox},
            widget = wibox.container.margin,
            margins = dpi(5)
        },
        widget = wibox.container.background,
        shape_border_width = user.border,
        shape_border_color = beautiful.fg_normal
    },
    widget = wibox.container.margin,
    margins = {top = dpi(10), bottom = dpi(10), left = dpi(0), right = dpi(0)},
    buttons = {
        awful.button({}, 1, function()
            controlCenterPopup.visible = not controlCenterPopup.visible
        end)
    }
}

helpers.hoverCursor(mycontrolcenter)

