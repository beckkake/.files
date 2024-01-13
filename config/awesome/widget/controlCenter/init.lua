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
            left = dpi(8),
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

-- greeting stuff
local function get_greeting()
    local current_hour = tonumber(os.date("%H"))

    if current_hour >= 5 and current_hour < 12 then
        return "Good morning"
    elseif current_hour >= 12 and current_hour < 18 then
        return "Good afternoon"
    else
        return "Good evening"
    end
end

local function show_greeting()
    local greeting = get_greeting()
    wibox.widget({
        widget = wibox.widget.textbox,
        text = greeting .. ", " .. user.name .. "!"
    })
end

-- it gotta be updated
gears.timer {
    timeout = 60,
    autostart = true,
    callback = function() show_greeting() end
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
                            {
                                -- icons
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
                            -- background
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
                            {userTextbox, layout = wibox.layout.fixed.vertical},
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
                                icons.settings,
                                icons.notifications,
                                toggleButton,
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
end)

click_to_hide.popup(controlCenterPopup, nil, true)
