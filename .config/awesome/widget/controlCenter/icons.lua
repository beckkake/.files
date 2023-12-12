local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")
local helpers = require("base.helpers.extras")

local icons = {}

-- make a widget template
function imageWidget(image, margin)
    return wibox.widget {
        {
            {
                {

                    {

                        widget = wibox.widget.imagebox,
                        id = "icon",
                        resize = true,
                        forced_height = 20,
                        forced_width = 20,
                        image = image
                    },
                    widget = wibox.container.place,
                    halign = "center",
                    valign = "center"
                },
                widget = wibox.container.margin,
                margins = margin
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
            left = dpi(0),
            right = dpi(0)
        }
    }
end

-- make a hover template
function hoverColors(widget, hoverBg, hoverBorder, normalBg, normalBorder)
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
end

-- initialize widgets
icons.main = imageWidget(beautiful.main, dpi(5))
helpers.hoverCursor(icons.main)

icons.settings = imageWidget(beautiful.settings, dpi(5))
helpers.hoverCursor(icons.settings)

icons.logout = imageWidget(beautiful.logout, dpi(5))
helpers.hoverCursor(icons.logout)

icons.notifications = imageWidget(beautiful.notifications, {
    top = dpi(5),
    bottom = dpi(5),
    left = dpi(7),
    right = dpi(5)
})
helpers.hoverCursor(icons.notifications)

-- volume bar
volume = {
    {
        layout = wibox.layout.align.horizontal,
        {
            {
                widget = wibox.widget.imagebox,
                resize = true,
                forced_height = 20,
                forced_width = 20,
                image = beautiful.volume
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(0),
                bottom = dpi(0),
                left = dpi(0),
                right = dpi(8)
            }
        },
        widget = wibox.container.place,
        halign = "center",
        valign = "center"
    },
    layout = wibox.layout.align.horizontal,
    {

        widget = wibox.widget.progressbar,
        max_value = 1,
        value = 1,
        forced_height = 20,
        forced_width = 350,
        paddings = 4,
        border_width = user.border,
        color = beautiful.accent,
        background_color = beautiful.bg_normal,
        border_color = beautiful.fg_normal
    },
    widget = wibox.container.place,
    halign = "center",
    valign = "center"
}

-- brightness bar
icons.brightness = {
    {
        layout = wibox.layout.align.horizontal,
        {
            {
                widget = wibox.widget.imagebox,
                resize = true,
                forced_height = 20,
                forced_width = 20,
                image = beautiful.brightness
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(0),
                bottom = dpi(0),
                left = dpi(0),
                right = dpi(8)
            }
        },
        widget = wibox.container.place,
        halign = "center",
        valign = "center"
    },
    layout = wibox.layout.align.horizontal,
    {

        widget = wibox.widget.progressbar,
        max_value = 1,
        value = 1,
        forced_height = 20,
        forced_width = 350,
        paddings = 4,
        border_width = user.border,
        color = beautiful.accent,
        background_color = beautiful.bg_normal,
        border_color = beautiful.fg_normal
    },
    widget = wibox.container.place,
    halign = "center",
    valign = "center"
}
-- end brightness icon

return icons
