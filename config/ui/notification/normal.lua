local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local naughty = require('naughty')
local ruled = require('ruled')
local wibox = require('wibox')
local helpers = require('helpers')

--- Notifications
ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule({
        rule = nil,
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5,
            widget_template = {
                {
                    {
                        naughty.widget.title,
                        forced_width = dpi(200),
                        forced_height = dpi(30),
                        widget = wibox.container.place,
                        halign = "center",
                        valign = "center"
                    },
                    widget = wibox.container.background,
                    bg = beautiful.bg_dim,
                    shape = helpers.shape(10),
                    shape_border_width = dpi(3),
                    shape_border_color = beautiful.bg_dark
                },
                layout = wibox.layout.fixed.horizontal
            }
        }
    })
end)

-- Defines the default notification layout.
naughty.connect_signal('request::display',
                       function(n) naughty.layout.box({notification = n}) end)
