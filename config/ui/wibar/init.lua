local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local config = require("config.user")

local module = require(... .. ".module")

-- stole a lot of this from drainpixie (i think?)
-- https://github.com/drainpixie/petal/blob/main/.config/awesome/helpers.lua

return function(s)

    local margin = {top = dpi(-5), bottom = dpi(-5)}

    -- Define height/width.
    local h = config.toppanel_height
    local w = s.geometry.width - 10

    local systray = wibox.widget { -- Create a systray.
        {
            {
                {
                    {widget = wibox.widget.systray, base_size = 24},
                    align = "center",
                    widget = wibox.container.place
                },
                bg = beautiful.bg_light,
                shape = helpers.shape(10),
                forced_height = 50,
                widget = wibox.container.background
            },
            margins = dpi(12),
            widget = wibox.container.margin
        },
        bg = beautiful.bg_dark,
        visible = false,
        widget = wibox.container.background
    }

    local systrayButton = wibox.widget {
        {
            {

                color = beautiful.bg_light,
                forced_height = 6,
                forced_width = 8,
                shape = helpers.shape(30),
                widget = wibox.widget.separator
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(20),
                bottom = dpi(20),
                left = dpi(14),
                right = dpi(14)
            }
        },
        bg = beautiful.bg_dark,
        widget = wibox.container.background,
        buttons = {
            awful.button({}, 1,
                         function()
                systray.visible = not systray.visible
            end)
        }
    }

    local mylayoutbox = wibox.widget {
        {
            {
                {

                    module.layoutbox(s),
                    margins = dpi(12),
                    widget = wibox.container.margin
                },
                bg = beautiful.bg_light,
                shape = helpers.shape(10),
                widget = wibox.container.background
            },
            margins = {
                top = dpi(6),
                bottom = dpi(12),
                left = dpi(12),
                right = dpi(12)
            },
            widget = wibox.container.margin
        },
        bg = beautiful.bg_dark,
        widget = wibox.container.background
    }

    -- Create a wibox.
    local box = wibox {height = h, width = w}

    -- Create the paws of the wibox.
    local paws = wibox.widget {
        {
            image = gears.color.recolor_image(beautiful.paws, beautiful.bg_dark),
            resize = true,
            widget = wibox.widget.imagebox
        },
        bg = beautiful.transparent,
        widget = wibox.container.background
    }

    -- Create the cat head.
    local cat = wibox.widget {
        {
            image = gears.color.recolor_image(beautiful.cat, beautiful.bg_dark),
            resize = true,
            widget = wibox.widget.imagebox
        },
        bg = beautiful.transparent,
        widget = wibox.container.background
    }

    -- Create a (useless) progress bar.
    local progressbar = wibox.widget {
        background_color = beautiful.bg_dark,
        widget = wibox.widget.progressbar
    }

    -- Create the wibar.
    local wb = awful.wibar {
        position = "left",
        ontop = false,
        height = 1060,
        width = config.toppanel_height + 20,
        margins = {left = 12, right = 5},
        bg = beautiful.transparent
    }

    -- Give it some room to breathe.
    wb:struts({top = dpi(5), bottom = dpi(5), left = dpi(108), right = dpi(8)})

    -- Set up the widgets on the wibar.
    wb:setup{
        layout = wibox.layout.align.vertical,
        {
            layout = wibox.layout.align.vertical,
            {widget = wibox.container.rotate, direction = "east", cat},
            {
                widget = wibox.container.margin,
                margins = margin,
                module.taglist(s)
            },
            {
                {
                    {

                        color = beautiful.bg_light,
                        forced_height = 6,
                        forced_width = 8,
                        shape = helpers.shape(30),
                        widget = wibox.widget.separator
                    },
                    widget = wibox.container.margin,
                    margins = {
                        top = dpi(20),
                        bottom = dpi(20),
                        left = dpi(14),
                        right = dpi(14)
                    }
                },
                bg = beautiful.bg_dark,
                widget = wibox.container.background
            },
            {
                widget = wibox.container.margin,
                margins = margin,
                module.tasklist(s)
            },
            layout = wibox.layout.fixed.vertical
        },
        {widget = wibox.container.margin, margins = margin, progressbar},
        {
            layout = wibox.layout.fixed.horizontal,
            {
                layout = wibox.layout.fixed.vertical,
                {widget = wibox.container.margin, margins = margin, systray},
                {
                    widget = wibox.container.margin,
                    margins = margin,
                    systrayButton
                },
                {
                    widget = wibox.container.margin,
                    margins = {top = dpi(-2), bottom = dpi(-2)},
                    mylayoutbox
                },
                {
                    widget = wibox.container.margin,
                    margins = margin,
                    module.textclock()
                },
                {
                    widget = wibox.container.margin,
                    margins = {top = dpi(-2), bottom = dpi(-2)},
                    module.settings()
                },
                {
                    widget = wibox.container.margin,
                    margins = margin,
                    module.icon()
                },
                {direction = "east", widget = wibox.container.rotate, paws}
            },
            layout = wibox.layout.fixed.vertical()
        },
        layout = wibox.layout.align.vertical
    }

    return wb
end

