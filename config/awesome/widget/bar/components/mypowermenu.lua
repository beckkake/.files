-- initialize indirect elements
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local gfs = require("gears.filesystem")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi
local icons = require("widget.controlcenter.components.myicons")

-- initiliaze direct elements
local click_to_hide = require("base.helpers.click_to_hide")
local home = os.getenv("HOME") .. "/"
local config_path = gfs.get_configuration_dir()

-- create the popup
local popup = awful.popup {
    ontop = true,
    visible = false,
    border_width = 1,
    border_color = beautiful.fg_normal,
    maximum_width = 500,
    placement = awful.placement.centered,
    widget = {}

}

local function worker(user_args)
    local rows = {layout = wibox.layout.fixed.vertical}

    local args = user_args or {}

    local font = beautiful.font

    local onlogout = args.onlogout or function() awesome.quit() end
    local onreboot = args.onreboot or
                         function() awful.spawn.with_shell("reboot") end

    local menu_items = {
        {name = "Log out", icon_name = "assets/logout.svg", command = onlogout},
        {name = "Reboot", icon_name = "assets/reboot.svg", command = onreboot}
    }

    for _, item in ipairs(menu_items) do

        local msg = {
            {text = item.name, font = font, widget = wibox.widget.textbox},
            margins = {
                top = dpi(12),
                bottom = dpi(12),
                left = dpi(12),
                right = dpi(12)
            },
            widget = wibox.container.margin
        }

        local icon = {
            {
                {
                    {
                        image = gears.color.recolor_image(config_path ..
                                                              item.icon_name,
                                                          beautiful.fg_normal),
                        widget = wibox.widget.imagebox,
                        resize = true,
                        forced_height = 20,
                        forced_width = 20
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
                shape_border_width = dpi(1),
                shape_border_color = beautiful.fg_normal
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(10),
                bottom = dpi(10),
                left = dpi(10),
                right = dpi(10)
            }
        }
        local row = wibox.widget {
            layout = wibox.layout.align.horizontal,
            msg,
            widget = wibox.container.place,
            halign = "center",
            {icon, widget = wibox.container.place, halign = "right"},
            bg = beautiful.bg_normal,
            widget = wibox.container.background
        }

        local old_cursor, old_wibox
        row:connect_signal("mouse::enter", function()
            local wb = mouse.current_wibox
            old_cursor, old_wibox = wb.cursor, wb
            wb.cursor = "hand2"
        end)
        row:connect_signal("mouse::leave", function()
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end)

        row:buttons(awful.util.table.join(
                        awful.button({}, 1, function()
                popup.visible = not popup.visible
                item.command()
            end)))

        table.insert(rows, row)
    end
    popup:setup(rows)

    icons.logout:buttons(awful.util.table.join(
                             awful.button({}, 1, function()
            if popup.visible then
                popup.visible = not popup.visible
            else
                popup:move_next_to(mouse.current_widget_geometry)
            end
        end)))

    click_to_hide.popup(popup, nil, true)

    return icons.logout

end

return worker
