local ruled = require("ruled")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local user = require("user")
local theme = require("theme")
local color = require("theme.colorscheme")

naughty.config.defaults.position = "bottom_right"

ruled.notification.append_rule {
    rule = {urgency = 'critical'},
    properties = {bg = beautiful.bg_dark, fg = color.red, timeout = 10}
}
ruled.notification.append_rule {
    rule = {urgency = 'normal'},
    properties = {
        bg = beautiful.bg_dark,
        fg = beautiful.fg_normal,
        timeout = 10

    }
}
ruled.notification.append_rule {
    rule = {urgency = 'low'},
    properties = {
        bg = beautiful.bg_dark,
        fg = beautiful.fg_normal,
        timeout = 10

    }
}

-- make a widget template
local notificationIcon = {
    {
        {
            {

                {
                    widget = wibox.widget.imagebox,
                    resize = true,
                    forced_height = 20,
                    forced_width = 20,
                    image = beautiful.notifications
                },
                widget = wibox.container.place,
                halign = "center",
                valign = "center"
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(7),
                right = dpi(5)
            }
        },
        widget = wibox.container.background,
        shape_border_width = user.border,
        shape_border_color = beautiful.fg_normal
    },
    widget = wibox.container.margin,
    margins = {top = dpi(10), bottom = dpi(10), left = dpi(-14), right = dpi(0)}
}

local spacer = {
    {
        widget = wibox.widget.separator,
        forced_height = dpi(1),
        forced_width = dpi(20),
        thickness = dpi(1),
        color = beautiful.fg_normal,
        position = "vertical"
    },
    widget = wibox.container.margin,
    margins = {
        top = dpi(-10),
        bottom = dpi(10),
        left = dpi(-10),
        right = dpi(-10)
    }
}

local message = {
    {
        {
            naughty.widget.message,
            widget = wibox.container.margin,
            margins = {
                top = dpi(0),
                bottom = dpi(12),
                left = dpi(0),
                right = dpi(0)
            }
        },
        layout = wibox.layout.align.horizontal
    },
    widget = wibox.container.place,
    halign = "center",
    valign = "center"
}

local title = {
    {
        naughty.widget.title,
        widget = wibox.container.margin,
        margins = {
            top = dpi(0),
            bottom = dpi(0),
            left = dpi(8),
            right = dpi(-12)
        }
    },
    layout = wibox.layout.align.horizontal
}

naughty.connect_signal("request::display", function(n)
    naughty.layout.box {
        notification = n,
        bg = beautiful.bg_normal,
        widget_template = {
            {
                {
                    {
                        {
                            {
                                {
                                    notificationIcon,
                                    title,
                                    layout = wibox.layout.align.horizontal
                                },
                                widget = wibox.container.margin,
                                margins = {
                                    top = dpi(2),
                                    bottom = dpi(12),
                                    left = dpi(12),
                                    right = dpi(12)
                                }
                            },
                            spacer,
                            message,
                            layout = wibox.layout.fixed.vertical
                        },
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(0),
                            bottom = dpi(0),
                            left = dpi(12),
                            right = dpi(12)
                        }
                    },
                    strategy = "min",
                    height = dpi(60),
                    widget = wibox.container.constraint
                },
                strategy = "max",
                width = dpi(400),
                widget = wibox.container.constraint
            },
            widget = wibox.container.background,
            shape_border_color = beautiful.fg_normal,
            shape_border_width = user.border
        }
    }
end)
