local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")

local icons = {}

-- make a widget template
function iconWidget(image, margin, left, right, left2, right2)
    return hovercursor(wibox.widget {
        {
            {
                {

                    {

                        widget = wibox.widget.imagebox,
                        id = "icon",
                        resize = true,
                        forced_height = dpi(20),
                        forced_width = dpi(20),
                        image = image
                    },
                    widget = wibox.container.place,
                    halign = "center",
                    valign = "center"
                },
                widget = wibox.container.margin,
                margins = {
                    top = margin,
                    bottom = margin,
                    left = left,
                    right = right
                }
            },
            widget = wibox.container.background,
            id = "bg",
            shape_border_width = user.border,
            shape_border_color = beautiful.fg_normal
        },
        widget = wibox.container.margin,
        margins = {
            top = dpi(10),
            bottom = dpi(10),
            left = left2,
            right = right2
        }
    })
end

-- initialize icons
icons.main = iconWidget(beautiful.main, dpi(5), dpi(5), dpi(5), dpi(8), dpi(0))
icons.main:buttons{
    awful.button({}, 1, function()
        if controlcenter.visible then
            controlcenter.visible = true
            settings.visible = false
            notificationcenter.visible = false
        else
            controlcenter.visible = true
            settings.visible = false
            notificationcenter.visible = false
        end
    end)
}

icons.settings = iconWidget(beautiful.settings, dpi(5), dpi(5), dpi(5), dpi(8),
                            dpi(0))
icons.settings:buttons{
    awful.button({}, 1, function()
        if controlcenter.visible then
            settings.visible = true
            notificationcenter.visible = false
            controlcenter.visible = false
        end
    end)
}

icons.music =
    iconWidget(beautiful.music, dpi(5), dpi(5), dpi(5), dpi(8), dpi(0))

icons.logout = iconWidget(beautiful.logout, dpi(5), dpi(5), dpi(5), dpi(8),
                          dpi(0))

icons.arrow = iconWidget(beautiful.previous, dpi(5), dpi(5), dpi(5), dpi(0),
                         dpi(8))
icons.arrowRight = iconWidget(beautiful.next, dpi(5), dpi(5), dpi(5), dpi(0),
                              dpi(8))

icons.notifications = iconWidget(beautiful.notifications, dpi(5), dpi(7),
                                 dpi(5), dpi(8), dpi(0))
icons.notifications:buttons{
    awful.button({}, 1, function()
        if controlcenter.visible then
            notificationcenter.visible = true
            settings.visible = false
            controlcenter.visible = false
        end
    end)
}

return icons
