local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")

require("widget.bar.components.mysearchbox")
require("widget.bar.components.mycontrolcenter")
require("widget.bar.components.mytagbox")
require("widget.bar.components.mytasklist")
require("widget.bar.components.mytextclock")
require("widget.bar.components.mysystray")

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag(
        {"Workspace 1", " Workspace 2", " ", " ", " ", " ", " ", " ", " "}, s,
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
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 8,
            mysearchbox,
            mytagbox

        },
        {
            {

                widget = wibox.widget.textbox,
                markup = "<i>" .. awful.tag.selected(1).name .. "</i>"

            },
            widget = wibox.container.place,
            halign = "center"
        }, -- Middle widget
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 8,
            -- Right widgets
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
