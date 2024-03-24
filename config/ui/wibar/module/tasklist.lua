local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

return function(s)
    -- Create a tasklist widget
    return awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            -- Left-clicking a client indicator minimizes it if it"s unminimized, or unminimizes
            -- it if it"s minimized.
            awful.button(nil, 1, function(c)
                c:activate(
                    {context = "tasklist", action = "toggle_minimization"})
            end),
            -- Right-clicking a client indicator shows the list of all open clients in all visible 
            -- tags.
            awful.button(nil, 3, function()
                awful.menu.client_list({theme = {width = 250}})
            end), -- Mousewheel scrolling cycles through clients.
            awful.button(nil, 4, function()
                awful.client.focus.byidx(-1)
            end),
            awful.button(nil, 5, function()
                awful.client.focus.byidx(1)
            end)
        },
        layout = {spacing = dpi(-10), layout = wibox.layout.fixed.vertical},
        wibox.layout.fixed.vertical,
        widget_template = {
            {
                {
                    {
                        {id = 'icon_role', widget = wibox.widget.imagebox},
                        margins = 8,
                        color = beautiful.bg_light,
                        widget = wibox.container.margin
                    },
                    shape_border_width = dpi(4),
                    shape_border_color = beautiful.bg_light,
                    shape = helpers.shape(10),
                    bg = beautiful.bg_light,
                    widget = wibox.container.background
                },
                margins = {
                    top = dpi(12),
                    bottom = dpi(12),
                    left = dpi(12),
                    right = dpi(12)
                },
                color = beautiful.bg_dark,
                widget = wibox.container.margin
            },
            bg = beautiful.bg_dark,
            widget = wibox.container.background
        }

    })
end
