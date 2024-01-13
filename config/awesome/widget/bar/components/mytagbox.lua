local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")

local helpers = require("base.helpers.extras")
local click_to_hide = require("base.helpers.click_to_hide")

local taglist_buttons = gears.table.join(
                            awful.button({}, 1, function(t) t:view_only() end),
                            awful.button({modkey}, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end), awful.button({}, 3, awful.tag.viewtoggle),
                            awful.button({modkey}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end), awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
                            awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end))

awful.screen.connect_for_each_screen(function(s)
    mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        base_layout = wibox.widget {
            spacing = -1,
            forced_num_cols = 3,
            layout = wibox.layout.grid.vertical
        },
        widget_template = {
            {

                {
                    id = "index_role",
                    forced_height = 24,
                    forced_width = 24,
                    widget = wibox.widget.textbox
                },

                id = "background_role",
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        buttons = taglist_buttons
    }
end)

local popup = awful.popup {
    widget = {
        layout = wibox.layout.align.vertical,
        spacing = -1,
        {
            {
                mytaglist,
                widget = wibox.container.place,
                halign = "center",
                valign = "center"
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(10),
                bottom = dpi(10),
                left = dpi(10),
                right = dpi(10)
            }
        },
        layout = wibox.layout.fixed.vertical
    },
    bg = beautiful.bg_normal,
    visible = false,
    border_width = user.border,
    border_color = beautiful.fg_normal,
    placement = function(w)
        awful.placement.top_left(w, {
            honor_workarea = true,
            offset = {y = 0, x = 0}
        })
    end,
    ontop = true
}

-- creating the taglist widget
mytagbox = wibox.widget {
    {

        {

            {

                image = beautiful.tag,
                widget = wibox.widget.imagebox,
                halign = "center"
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(5),
                right = dpi(5)
            }
        },
        widget = wibox.container.background,
        shape_border_width = user.border,
        shape_border_color = beautiful.fg_normal
    },
    widget = wibox.container.margin,
    margins = {top = dpi(10), bottom = dpi(10), left = dpi(0), right = dpi(0)}
}

mytagbox:buttons(awful.util.table.join(awful.button({}, 1, function()
    if popup.visible then
        popup.visible = not popup.visible
    else
        popup:move_next_to(mouse.current_widget_geometry)
    end
end)))

click_to_hide.popup(popup, nil, true)

helpers.hoverCursor(mytagbox)
