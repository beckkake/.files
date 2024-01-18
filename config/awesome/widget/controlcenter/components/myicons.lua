local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")
local helpers = require("base.helpers.extras")

local icons = {}

-- make a widget template
function iconWidget(image, margin, left, right, left2, right2)
    return wibox.widget {
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
    }
end

-- make a hover template
--[[function hoverColors(widget, hoverBg, hoverBorder, normalBg, normalBorder)
    local oldbg, oldwidget
    widget:connect_signal("mouse::enter", function()
        local wb = widget
        if wb == nil then return end
        oldbg, oldwidget = wb.bg.bg, wb
        wb.bg.bg = beautiful.bg_normal
        widget.bg.bg = hoverBg
        widget.bg.shape_border_color = hoverBorder
    end)
    widget:connect_signal("mouse::leave", function()
        if oldwidget then
            oldwidget.bg.bg = oldbg
            oldwidget = nil
            widget.bg.bg = normalBg
            widget.bg.shape_border_color = normalBorder
        end
    end)
end

function hoverImage(widget, hoverIcon, normalIcon)
    widget:connect_signal("mouse::enter", function()
        widget:get_children_by_id("icon")[1].image = hoverIcon
    end)
    widget:connect_signal("mouse::leave", function()
        widget:get_children_by_id("icon")[1].image = normalIcon
    end)
end]]

-- initialize icons
icons.main = iconWidget(beautiful.main, dpi(5), dpi(5), dpi(5), dpi(8), dpi(0))
helpers.hoverCursor(icons.main)

icons.settings = iconWidget(beautiful.settings, dpi(5), dpi(5), dpi(5), dpi(8),
                            dpi(0))
helpers.hoverCursor(icons.settings)

icons.logout = iconWidget(beautiful.logout, dpi(5), dpi(5), dpi(5), dpi(8),
                          dpi(0))
helpers.hoverCursor(icons.logout)

icons.arrow = iconWidget(beautiful.previous, dpi(5), dpi(5), dpi(5), dpi(0),
                         dpi(8))
icons.arrowRight = iconWidget(beautiful.next, dpi(5), dpi(5), dpi(5), dpi(0),
                              dpi(8))

icons.notifications = iconWidget(beautiful.notifications, dpi(5), dpi(7),
                                 dpi(5), dpi(8), dpi(0))
helpers.hoverCursor(icons.notifications)

return icons
