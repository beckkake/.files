local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

--- The titlebar to be used on normal clients.
return function(c)
    -- Buttons for the titlebar.
    local buttons = {
        awful.button(nil, 1, function()
            c:activate({context = "titlebar", action = "mouse_move"})
        end), awful.button(nil, 3, function()
            c:activate({context = "titlebar", action = "mouse_resize"})
        end)
    }

    require("ui.titlebar.components")

    -- Draws the client titlebar at the default position (top) and size.
    awful.titlebar(c, {size = 44, position = "top"}):setup{
        {catEarsLeft, buttons = buttons, layout = wibox.layout.fixed.horizontal},

        {

            {
                {
                    {
                        {
                            {
                                {
                                    {
                                        widget = awful.titlebar.widget
                                            .titlewidget(c)
                                    },
                                    widget = wibox.container.margin,
                                    margins = {
                                        top = dpi(4),
                                        bottom = dpi(4),
                                        left = dpi(8),
                                        right = dpi(8)
                                    }
                                },
                                widget = wibox.container.background,
                                shape = helpers.shape(10),
                                shape_border_width = dpi(3),
                                shape_border_color = beautiful.bg_dark,
                                bg = beautiful.bg_dim
                            },
                            widget = wibox.container.place,
                            halign = "left"
                        },
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(-24),
                            bottom = dpi(8),
                            left = dpi(0),
                            right = dpi(0)
                        }
                    },
                    widget = wibox.container.background,
                    bg = beautiful.bg_dark
                },
                widget = wibox.container.margin,
                margins = {
                    top = dpi(31),
                    bottom = dpi(0),
                    left = dpi(-1),
                    right = dpi(-1)
                }
            },
            {
                {
                    align = "center",
                    background_color = beautiful.bg_dark,
                    shape = gears.shape.rectangle,
                    widget = wibox.widget.progressbar
                },
                widget = wibox.container.margin,
                margins = {
                    top = dpi(31),
                    bottom = dpi(0),
                    left = dpi(-1),
                    right = dpi(-1)
                }
            },
            {
                {
                    {
                        {
                            {
                                {
                                    {
                                        {

                                            awful.titlebar.widget
                                                .minimizebutton(c),
                                            awful.titlebar.widget
                                                .maximizedbutton(c),
                                            awful.titlebar.widget.closebutton(c),
                                            spacing = 4,
                                            layout = wibox.layout.fixed
                                                .horizontal()
                                        },
                                        widget = wibox.container.margin,
                                        margins = {
                                            top = dpi(8),
                                            bottom = dpi(8),
                                            left = dpi(8),
                                            right = dpi(8)
                                        }
                                    },
                                    widget = wibox.container.place,
                                    halign = "right"
                                },
                                widget = wibox.container.background,
                                shape = helpers.shape(10),
                                forced_width = 125,
                                shape_border_width = dpi(3),
                                shape_border_color = beautiful.bg_dark,
                                bg = beautiful.bg_dim
                            },

                            widget = wibox.container.place,
                            halign = "right"
                        },
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(-24),
                            bottom = dpi(8),
                            left = dpi(0),
                            right = dpi(0)
                        }
                    },
                    widget = wibox.container.background,
                    bg = beautiful.bg_dark
                },
                widget = wibox.container.margin,
                margins = {
                    top = dpi(31),
                    bottom = dpi(0),
                    left = dpi(-1),
                    right = dpi(-1)
                }
            },

            layout = wibox.layout.flex.horizontal
        },
        {catEarsRight, layout = wibox.layout.fixed.horizontal()},
        layout = wibox.layout.align.horizontal
    }

    awful.titlebar(c, {size = 40, position = "bottom"}):setup{
        {pawsLeft, buttons = buttons, layout = wibox.layout.fixed.horizontal},
        {
            {
                {
                    align = "center",
                    background_color = beautiful.bg_dark,
                    shape = gears.shape.rectangle,
                    widget = wibox.widget.progressbar
                },
                widget = wibox.container.margin,
                margins = {
                    top = dpi(0),
                    bottom = dpi(20),
                    left = dpi(-1),
                    right = dpi(-1)
                }
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        {pawsRight, layout = wibox.layout.fixed.horizontal()},
        layout = wibox.layout.align.horizontal
    }

    awful.titlebar(c, {size = 12, position = "left"}):setup{
        {nil, layout = wibox.layout.fixed.horizontal},
        {
            {
                {
                    align = "center",
                    background_color = beautiful.bg_dark,
                    shape = gears.shape.rectangle,
                    widget = wibox.widget.progressbar
                },
                widget = wibox.container.margin,
                margins = {
                    top = dpi(0),
                    bottom = dpi(0),
                    left = dpi(0),
                    right = dpi(0)
                }
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        {nil, layout = wibox.layout.fixed.horizontal()},
        layout = wibox.layout.align.horizontal
    }

    rightTitlebar = awful.titlebar(c, {size = 12, position = "right"}):setup{
        {nil, layout = wibox.layout.fixed.horizontal},
        {
            {
                {
                    align = "center",
                    background_color = beautiful.bg_dark,
                    shape = gears.shape.rectangle,

                    widget = wibox.widget.progressbar
                },
                widget = wibox.container.margin,
                margins = {
                    top = dpi(0),
                    bottom = dpi(0),
                    left = dpi(0),
                    right = dpi(0)
                }
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        {nil, layout = wibox.layout.fixed.horizontal()},
        layout = wibox.layout.align.horizontal
    }

end
