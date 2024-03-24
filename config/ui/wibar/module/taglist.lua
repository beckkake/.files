local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local gfs = require("gears.filesystem")
local helpers = require("helpers")
local wibox = require("wibox")
local tags = require("config.user")

return function(s)
    local update_tags =
        function(self, c3) -- Change the tag color/direction depending on clients.
            local tagicon = self:get_children_by_id('icon_role')[1]
            if c3.selected then
                tagicon.image = gears.color.recolor_image(
                                    "/home/beck/.config/awesome/assets/pawRight.svg",
                                    beautiful.mid_light)
            elseif #c3:clients() == 0 then
                tagicon.image = gears.color.recolor_image(
                                    "/home/beck/.config/awesome/assets/pawLeft.svg",
                                    beautiful.bg_light)
            else
                tagicon.image = gears.color.recolor_image(
                                    "/home/beck/.config/awesome/assets/pawLeft.svg",
                                    beautiful.bg_light)
            end
        end

    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = -1,
            spacing_widget = {color = beautiful.transparent},
            layout = wibox.layout.fixed.vertical
        },
        widget_template = {
            {
                {
                    {
                        bg = beautiful.transparent,
                        widget = wibox.container.background
                    },
                    {
                        {id = 'icon_role', widget = wibox.widget.imagebox},
                        margins = -4,
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                top = 12,
                bottom = 12,
                left = 20,
                right = 20,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end,

            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end
        },
        buttons = awful.button({}, 1, function(t) t:view_only() end),
        awful.button({}, 3, function(t) awful.tag.viewtoggle(t) end),
        awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
        awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end)
    }
end
