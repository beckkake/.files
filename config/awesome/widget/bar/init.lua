local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")
local helpers = require("helpers")

require("widget.bar.components.mysearchbox")
require("widget.bar.components.mycontrolcenter")
require("widget.bar.components.mytagbox")
require("widget.bar.components.mytasklist")
require("widget.bar.components.mytextclock")
require("widget.bar.components.mysystray")

--[[local tag_title_widget = wibox.widget {widget = wibox.widget.textbox}

tag.connect_signal("property::selected", function()
    local t = awful.screen.focused().selected_tag
    if not t then return end
    tag_title_widget.markup = t.index
end)]]

screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s,
              awful.layout.layouts[1])

    -- Create the wibox
    s.mywibox = wibox {
        ontop = false,
        screen = s,
        stretch = false,
        y = "-" .. user.border,
        x = "-" .. user.border,
        height = dpi(50),
        width = s.geometry.width,
        bg = beautiful.bg_dark,
        border_color = beautiful.fg_normal,
        border_width = user.border,
        struts = {top = dpi(50)}
    }

    s.mywibox:struts({
        top = dpi(60),
        bottom = dpi(10),
        left = dpi(10),
        right = dpi(10)
    })

    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 8,
            mysearchbox,
            mytagbox

        },
        {nil, widget = wibox.container.place, halign = "center"},
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 8,
            {
                layout = wibox.layout.fixed.horizontal,
                expand = "outside",
                systray,
                systrayButton
            },
            wibox.widget.textbox(),
            mytextclock,
            mycontrolcenter,
            layout = wibox.layout.fixed.horizontal,
            spacing = 8
        }
    }

    s.mywibox.visible = true
end)

