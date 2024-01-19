-- initialize indirect elements
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- initialize direct elements
local user = require("user")

-- initialize components
local icons = require("widget.controlcenter.components.myicons")
local logout = require("widget.bar.components.mypowermenu")
require("widget.bar.components.mycolorpicker")

-- make the subtext
local subtext = wibox.widget {widget = wibox.widget.textbox, text = ""}

awful.spawn.easy_async_with_shell("whoami && printf '@' && uname -n",
                                  function(stdout, stderr, reason, exit_code)
    subtext.text = stdout:gsub("\n", "")

end)

-- make the header text
function get_greeting()
    local current_hour = tonumber(os.date("%H"))

    if current_hour >= 5 and current_hour < 12 then
        return "Good morning, " .. user.name .. "!"
    elseif current_hour >= 12 and current_hour < 18 then
        return "Good afternoon, " .. user.name .. "!"
    else
        return "Good evening, " .. user.name .. "!"
    end
end

headertext = wibox.widget {
    {
        {
            {widget = wibox.widget.textbox, text = get_greeting()},
            widget = wibox.container.place,
            halign = "left",
            valign = "center"
        },
        widget = wibox.container.margin,
        margins = {
            top = dpi(0),
            bottom = dpi(0),
            left = dpi(12),
            right = dpi(0)
        }
    },
    {
        {
            {
                subtext,
                widget = wibox.container.background,
                fg = beautiful.mid_light
            },
            widget = wibox.container.place,
            halign = "left",
            valign = "center"
        },
        widget = wibox.container.margin,
        margins = {
            top = dpi(0),
            bottom = dpi(0),
            left = dpi(12),
            right = dpi(0)
        }
    },
    layout = wibox.layout.fixed.vertical
}

