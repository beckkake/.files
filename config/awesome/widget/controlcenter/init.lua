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

    local myheader = wibox.widget {
        {
            {
                {

                    myprofilepicture,
                    widget = wibox.container.margin,
                    margins = {
                        top = dpi(10),
                        bottom = dpi(10),
                        left = dpi(8),
                        right = dpi(8)
                    }
                },
                headertext,
                layout = wibox.layout.fixed.horizontal
            },
            myspacer,
            forced_width = dpi(400),
            layout = wibox.layout.fixed.vertical
        },
        widget = wibox.container.background,
        bg = beautiful.bg_dark,
        forced_height = dpi(116)
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
            myheader,
            {
                {
                    nil,
                    {
                        nil,
                        margins = {top = dpi(82)},
                        widget = wibox.container.margin

                    },
                    layout = wibox.layout.stack
                },
                margins = dpi(0),
                widget = wibox.container.margin
            },
            {
                {
                    myfooter,
                    widget = wibox.container.background,
                    bg = beautiful.bg_dark
                },
                margins = {top = dpi(200)},
                widget = wibox.container.margin
            },
            layout = wibox.layout.align.vertical
        },
        valign = "top",
        layout = wibox.container.place
    }
end)

awful.placement.top_right(controlcenter, {
    margins = {top = dpi(60), bottom = dpi(10), left = dpi(10), right = dpi(10)}
})

click_to_hide.popup(controlcenter, nil, true)

--[[controlcenterpopup = awful.popup {
        widget = {
            {
                {

                    {
                        {
                            {
                                widget = wibox.container.background,
                                bg = beautiful.bg_normal,
                                layout = wibox.layout.fixed.horizontal,
                                spacing = 0
                            },
                            widget = wibox.container.place,
                            halign = "right",
                            valign = "top"
                        },
                        bg = beautiful.bg_dark,
                        forced_width = 400,
                        widget = wibox.container.background
                    },
                    widget = wibox.container.margin,
                    margins = {bottom = dpi(9)}
                },
                spacer,
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.align.horizontal,
            {
                {

                    {

                        {
                            {
                                widget = wibox.widget.textbox,
                                text = get_greeting() .. ", " .. user.name ..
                                    "!"
                            },
                            widget = wibox.container.margin,
                            margins = {top = dpi(-24), right = dpi(12)}
                        },
                        {
                            {
                                {
                                    widget = wibox.widget.imagebox,
                                    image = user.avatar,
                                    forced_width = 100,
                                    forced_height = 100
                                },
                                widget = wibox.container.margin,
                                margins = dpi(5)
                            },
                            widget = wibox.container.background,
                            bg = beautiful.bg_normal,
                            shape_border_width = dpi(1),
                            shape_border_color = beautiful.fg_normal
                        },
                        layout = wibox.layout.align.horizontal
                    },
                    widget = wibox.container.place,
                    halign = "right",
                    valign = "top"
                },
                widget = wibox.container.margin,
                margins = {right = dpi(8), bottom = dpi(8)}
            },
            {
                {
                    {
                        {sub, layout = wibox.layout.fixed.vertical},
                        widget = wibox.container.place,
                        halign = "right",
                        valign = "top"
                    },
                    widget = wibox.container.margin,
                    margins = {top = dpi(-60), right = dpi(134)}
                },
                widget = wibox.container.background,
                fg = beautiful.mid_light
            },
            {widget = wibox.container.margin, margins = {top = dpi(12)}},
            spacer,
            layout = wibox.layout.fixed.vertical,
            {
                {
                    {
                        {

                            icons.main,
                            {
                                icons.settings,
                                widget = wibox.container.background
                            },
                            {
                                icons.notifications,
                                widget = wibox.container.background
                            },
                            mycolorpicker,
                            layouts,
                            logout(),
                            layout = wibox.layout.fixed.horizontal,
                            spacing = 0
                        },
                        widget = wibox.container.place,
                        halign = "left",
                        valign = "top"
                    },
                    widget = wibox.container.background,
                    bg = beautiful.bg_dark
                },
                widget = wibox.container.margin,
                margins = {top = dpi(-10)}
            },

            layout = wibox.layout.fixed.vertical
        },
        minimum_width = 450,
        minimum_height = 50,
        maximum_width = 500,
        bg = beautiful.bg_normal,
        visible = false,
        border_width = user.border,
        border_color = beautiful.fg_normal,
        placement = function(w)
            awful.placement.top_right(w, {
                honor_workarea = true,
                offset = {y = 0, x = -1}
            })
        end,
        ontop = true
    }
end)

click_to_hide.popup(controlcenterpopup, nil, true)]]

