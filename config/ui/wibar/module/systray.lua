local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')
local helpers = require('helpers')

local dpi = beautiful.xresources.apply_dpi
local user = require('config.user')

return function(s)
    local tray = wibox.widget {
        {
            {
                {
                    wibox.widget.systray(),
                    widget = wibox.container.margin,
                    margins = {
                        top = dpi(8),
                        bottom = dpi(8),
                        left = dpi(8),
                        right = dpi(8)
                    }
                },
                bg = beautiful.mg,
                shape = helpers.rrect(50),
                shape_clip = true,
                widget = wibox.container.background
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(0),
                bottom = dpi(0),
                left = dpi(0),
                right = dpi(8)
            }
        },
        align = 'center',
        visible = false,
        layout = wibox.container.place
    }

    local separator = wibox.widget {
        {
            {
                image = gears.color.recolor_image(
                    user.assets_path .. 'star_filled.png', beautiful.mg),
                align = 'center',
                widget = wibox.widget.imagebox
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(8),
                bottom = dpi(8),
                left = dpi(0),
                right = dpi(8)
            }
        },
        widget = wibox.container.place,
        align = 'center',
        visible = false
    }

    local systray = wibox.widget {
        {
            image = gears.color.recolor_image(
                user.assets_path .. 'star_filled.png', beautiful.mg),
            align = 'center',
            widget = wibox.widget.imagebox
        },
        widget = wibox.container.margin,
        margins = {top = dpi(8), bottom = dpi(8), left = dpi(0), right = dpi(0)},
        buttons = {
            awful.button({}, 1, function()
                tray.visible = not tray.visible
                separator.visible = not separator.visible
            end)
        }
    }

    return wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        expand = "outer",
        separator,
        tray,
        systray
    }

end
