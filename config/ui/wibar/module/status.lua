local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')

local dpi = beautiful.xresources.apply_dpi
local helpers = require('helpers')
local user = require('config.user')

return function(s)
    local function status_widget(button)
        local status = wibox.widget {
            {
                {
                    id = 'image_role',
                    align = 'center',
                    widget = wibox.widget.imagebox
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place
            },
            forced_width = dpi(20),
            widget = wibox.container.place,
            buttons = {awful.button({}, 1, button)},
            set_image = function(self, content)
                self:get_children_by_id('image_role')[1].image = content
            end
        }
        return status
    end

    bar_btn_blue = status_widget(function()
        awesome.emit_signal('bluetooth::toggle')
    end)

    helpers.hoverCursor(bar_btn_blue)

    local buttons = wibox.widget {
        {
            {
                nil,
                {
                    bar_btn_blue,
                    widget = wibox.widget,
                    layout = user.bar_type == 'vertical' and
                        wibox.layout.fixed.vertical or
                        wibox.layout.fixed.horizontal,
                    visible = user.bluetooth_enabled
                },
                spacing = dpi(user.spacing / 2),
                margins = dpi(10),
                layout = user.bar_type == 'vertical' and
                    wibox.layout.fixed.vertical or wibox.layout.fixed.horizontal
            },
            left = dpi(12),
            right = dpi(9),
            top = user.bar_type == 'vertical' and dpi(9) or dpi(0),
            bottom = user.bar_type == 'vertical' and dpi(9) or dpi(0),
            widget = wibox.container.margin
        },
        bg = beautiful.mg,
        shape = helpers.rrect(50),
        widget = wibox.container.background
    }

    awesome.connect_signal('signal::bluetooth', function(is_enabled)
        if is_enabled then
            bar_btn_blue.image = beautiful.bluetooth_on
        else
            bar_btn_blue.image = beautiful.bluetooth_off
        end
    end)

    return buttons

end
