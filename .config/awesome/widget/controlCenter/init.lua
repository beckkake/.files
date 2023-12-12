-- initialize indirect elements
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")

-- initialize direct elements
local helpers = require("base.helpers.extras")
local click_to_hide = require("base.helpers.click_to_hide")
local toggleButton = require("widget.bar.components.mycolorpicker")
local logout = require("widget.bar.components.mypowermenu")
local icons = require("widget.controlCenter.icons")

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

-- initialize layouts icon here, because problems
awful.screen.connect_for_each_screen(function(s)
    layouts = wibox.widget {
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
            left = dpi(0),
            right = dpi(0)
        }
    }
end)

helpers.hoverCursor(layouts)

local userTextbox = wibox.widget {widget = wibox.widget.textbox}

awful.spawn.easy_async_with_shell("whoami && printf '@' && uname -n",
                                  function(stdout, stderr, reason, exit_code)
    userTextbox.text = stdout:gsub("\n", "")

end)

local tag = {
    {
        {
            {

                {
                    widget = wibox.widget.imagebox,
                    resize = true,
                    forced_height = 20,
                    forced_width = 20,
                    image = beautiful.tag
                },
                widget = wibox.container.place,
                halign = "center",
                valign = "center"
            },
            widget = wibox.container.margin,
            margins = dpi(5)
        },
        widget = wibox.container.background,
        shape_border_width = user.border,
        shape_border_color = beautiful.fg_normal
    },
    widget = wibox.container.margin,
    margins = {top = dpi(10), bottom = dpi(10), left = dpi(0), right = dpi(0)}
}

-- do this for some reason 
screen.connect_signal("request::desktop_decoration", function(s)

    -- create the popup for all screens
    awful.screen.connect_for_each_screen(function(s)
        controlCenterPopup = awful.popup {
            widget = {
                {
                    {
                        {
                            icons.main,
                            icons.settings,
                            icons.notifications,
                            layout = wibox.layout.fixed.horizontal,
                            spacing = 8
                        },
                        widget = wibox.container.place,
                        halign = "left",
                        valign = "top"
                    },
                    widget = wibox.container.margin,
                    margins = {
                        top = dpi(0),
                        bottom = dpi(0),
                        left = dpi(8),
                        right = dpi(8)
                    }
                },
                {
                    {
                        {
                            {
                                layouts,
                                toggleButton,
                                logout(),
                                layout = wibox.layout.fixed.horizontal,
                                spacing = 8

                            },
                            widget = wibox.container.place,
                            halign = "left",
                            valign = "top"

                        },
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(-12),
                            bottom = dpi(-12),
                            left = dpi(8),
                            right = dpi(8)
                        }
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                {
                    {
                        {
                            {

                                wibox.widget.textbox(
                                    "Hello, " .. user.name .. "!"),
                                layout = wibox.layout.fixed.horizontal
                            },
                            widget = wibox.container.place,
                            halign = "right",
                            valign = "top"
                        },
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(-64),
                            bottom = dpi(0),
                            left = dpi(274),
                            right = dpi(8)
                        }
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                {
                    {
                        {

                            userTextbox,
                            widget = wibox.container.place,
                            halign = "right",
                            valign = "top"
                        },
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(-34),
                            bottom = dpi(8),
                            left = dpi(0),
                            right = dpi(12)
                        }

                    },
                    widget = wibox.container.background,
                    fg = beautiful.mid_light
                },
                {
                    {
                        volume,
                        icons.brightness,
                        layout = wibox.layout.fixed.vertical,
                        spacing = 12,
                        widget = wibox.container.place,
                        halign = "center",
                        valign = "bottom"
                    },
                    widget = wibox.container.margin,
                    margins = {
                        top = dpi(275),
                        bottom = dpi(12),
                        left = dpi(8),
                        right = dpi(8)
                    }
                },
                layout = wibox.layout.fixed.vertical
            },
            minimum_width = 400,
            minimum_height = 400,
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
end)

click_to_hide.popup(controlCenterPopup, nil, true)

