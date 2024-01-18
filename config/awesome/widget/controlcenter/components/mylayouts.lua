local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local user = require("user")
local helpers = require("base.helpers.extras")

-- create the layoutbox
awful.screen.connect_for_each_screen(function(s)
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                              awful.button({}, 1,
                                           function() awful.layout.inc(1) end),
                              awful.button({}, 3,
                                           function()
            awful.layout.inc(-1)
        end), awful.button({}, 4, function() awful.layout.inc(1) end),
                              awful.button({}, 5,
                                           function()
            awful.layout.inc(-1)
        end)))
end)

-- create the layoutbox icon
awful.screen.connect_for_each_screen(function(s)
    mylayouts = wibox.widget {
        {

            {
                {
                    widget = wibox.container.place,
                    halign = "center",
                    valign = "center",
                    forced_height = 20,
                    forced_width = 20,
                    s.mylayoutbox
                },
                widget = wibox.container.margin,
                margins = dpi(5)
            },
            widget = wibox.container.background,
            id = "bg",
            bg = beautiful.bg_normal,
            shape_border_width = user.border,
            shape_border_color = beautiful.fg_normal
        },
        widget = wibox.container.margin,
        margins = {
            top = dpi(10),
            bottom = dpi(10),
            left = dpi(8),
            right = dpi(0)
        }
    }
end)

helpers.hoverCursor(mylayouts)
