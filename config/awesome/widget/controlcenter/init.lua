-- initialize indirect elements
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- initialize direct elements
local user = require("user")
local logout = require("widget.bar.components.mypowermenu")
local helpers = require("base.helpers.extras")
local click_to_hide = require("base.helpers.click_to_hide")

-- initialize components
local icons = require("widget.controlcenter.components.myicons")
require("widget.bar.components.mycolorpicker")
require("widget.controlcenter.components.mymusicplayer")
require("widget.controlcenter.components.myprofilepicture")
require("widget.controlcenter.components.mylayouts")
require("widget.controlcenter.components.mytext")
require("widget.controlcenter.components.myspacer")

screen.connect_signal("request::desktop_decoration", function(s)

    controlcenter = wibox {
        width = dpi(400),
        height = dpi(450),
        bg = beautiful.bg_normal,
        border_color = beautiful.fg_normal,
        border_width = user.border,
        ontop = true,
        visible = false
    }

    awful.placement.top_right(controlcenter, {
        margins = {
            top = dpi(60),
            bottom = dpi(10),
            left = dpi(10),
            right = dpi(10)
        }
    })

    click_to_hide.popup(controlcenter, nil, true)

    settings = wibox {
        width = dpi(400),
        height = dpi(450),
        bg = beautiful.bg_normal,
        border_color = beautiful.fg_normal,
        border_width = user.border,
        ontop = true,
        visible = false
    }

    awful.placement.top_right(settings, {
        margins = {
            top = dpi(60),
            bottom = dpi(10),
            left = dpi(10),
            right = dpi(10)
        }
    })

    click_to_hide.popup(settings, nil, true)

    notificationcenter = wibox {
        width = dpi(400),
        height = dpi(450),
        bg = beautiful.bg_normal,
        border_color = beautiful.fg_normal,
        border_width = user.border,
        ontop = true,
        visible = false
    }

    awful.placement.top_right(notificationcenter, {
        margins = {
            top = dpi(60),
            bottom = dpi(10),
            left = dpi(10),
            right = dpi(10)
        }
    })

    click_to_hide.popup(notificationcenter, nil, true)

    local myheader = wibox.widget {
        {
            {
                {
                    headertext,
                    widget = wibox.container.margin,
                    margins = {
                        top = dpi(16),
                        bottom = dpi(12),
                        left = dpi(0),
                        right = dpi(12)
                    }
                },
                nil,
                {
                    myprofilepicture,
                    widget = wibox.container.margin,
                    margins = {right = dpi(12)}
                },

                layout = wibox.layout.align.horizontal
            },
            myspacer,
            forced_width = dpi(400),
            layout = wibox.layout.fixed.vertical
        },
        widget = wibox.container.background,
        bg = beautiful.bg_dark,
        forced_height = dpi(120)
    }

    local myfooter = wibox.widget {
        myspacer,
        forced_width = dpi(400),
        layout = wibox.layout.fixed.vertical,
        {
            icons.main,
            icons.settings,
            icons.notifications,
            mylayouts,
            mycolorpicker,
            logout(),
            layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.background,
        bg = beautiful.bg_dark
    }

    controlcenter:setup{
        {
            {
                myheader,
                {
                    {
                        mymusicplayer,
                        widget = wibox.container.background,
                        bg = beautiful.bg_dark,
                        shape_border_width = user.border,
                        shape_border_color = beautiful.fg_normal
                    },
                    widget = wibox.container.margin,
                    margins = dpi(12)
                },
                myspacer,
                layout = wibox.layout.align.vertical
            },
            {
                {widget = wibox.container.background, bg = beautiful.bg_dark},
                widget = wibox.container.margin,
                margins = dpi(12)
            },
            {
                {
                    myfooter,
                    widget = wibox.container.background,
                    bg = beautiful.bg_dark
                },
                margins = {top = dpi(98)},
                widget = wibox.container.margin
            },
            layout = wibox.layout.align.vertical
        },
        valign = "top",
        layout = wibox.container.place
    }

    settings:setup{
        nil,
        nil,
        {myfooter, widget = wibox.container.background, bg = beautiful.bg_dark},
        layout = wibox.layout.align.vertical
    }

    notificationcenter:setup{
        nil,
        nil,
        {myfooter, widget = wibox.container.background, bg = beautiful.bg_dark},
        layout = wibox.layout.align.vertical
    }

end)
