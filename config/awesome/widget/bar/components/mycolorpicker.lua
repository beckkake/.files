-- Standard Modules
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")
local user = require("user")
local helpers = require("base.helpers.extras")
local click_to_hide = require("base.helpers.click_to_hide")

local blankbox = wibox.widget.textbox("    ")
blankbox.forced_height = dpi(60)
blankbox.forced_width = dpi(85)

local header_text = wibox.widget {
    text = "Color Picker",
    widget = wibox.widget.textbox,
    halign = "left"
}

local clear_colors = wibox.widget {
    {
        {
            {
                image = beautiful.trash,
                widget = wibox.widget.imagebox,
                halign = "left"
            },
            widget = wibox.container.margin,
            margins = dpi(5)
        },
        widget = wibox.container.background,
        shape_border_width = user.border,
        shape_border_color = beautiful.fg_normal
    },
    widget = wibox.container.margin,
    margins = dpi(5)
}

local header = wibox.widget {
    {
        {header_text, nil, clear_colors, layout = wibox.layout.align.horizontal},
        forced_height = dpi(50),
        forced_width = dpi(400),
        widget = wibox.container.margin,
        margins = dpi(6)
    },
    widget = wibox.container.background,
    bg = beautiful.bg_normal
}

clear_colors:connect_signal("button::release", function(_, _, _, button)
    if button == 1 then awesome.emit_signal("clear::colors") end
end)

local empty_box = wibox.widget {
    {
        {
            {
                text = "Colors will be shown here",
                widget = wibox.widget.textbox,
                halign = "center"
            },
            layout = wibox.layout.fixed.vertical
        },
        widget = wibox.container.place
    },
    widget = wibox.container.margin,
    margins = dpi(3),
    forced_height = dpi(295),
    forced_width = dpi(400)
}

local colorlist = wibox.widget {
    layout = wibox.layout.grid,
    forced_num_cols = 4,
    forced_num_rows = 3,
    homogenous = true,
    spacing = dpi(20),
    forced_height = dpi(295),
    forced_width = dpi(400)
}

local color_table = {}

local add_to_table = function(box)
    table.insert(color_table, box)
    for i = #color_table, 1, -1 do colorlist:add(color_table[i]) end
end

local create_colorbox = function(pickedcolor)
    local colorbox = wibox.widget {
        {
            {blankbox, widget = wibox.container.background, bg = pickedcolor},
            {
                {
                    {
                        widget = wibox.widget.textbox,
                        text = pickedcolor,
                        forced_height = dpi(25),
                        halign = "center"
                    },
                    widget = wibox.container.margin,
                    margins = dpi(8)
                },
                widget = wibox.container.background,

                bg = "#00000080"
            },

            layout = wibox.layout.fixed.vertical
        },
        widget = wibox.container.background,
        bg = pickedcolor
    }

    colorbox:connect_signal("button::release", function(_, _, _, button)
        if button == 1 then
            awful.spawn.with_shell("xclip -r -sel c << EOF\n" .. pickedcolor)
        end
    end)

    return colorbox
end

local window = awful.popup {
    screen = s,
    widget = wibox.container.background,
    ontop = true,
    bg = "#00000000",
    visible = false,
    placement = function(w)
        awful.placement.centered(w, {
            honor_workarea = true,
            offset = {y = 0, x = -1}
        })
    end,
    opacity = 1
}

window:setup({
    {
        header,
        {
            {empty_box, colorlist, layout = wibox.layout.stack},
            widget = wibox.container.margin,
            margins = dpi(20),
            ontop = true
        },
        layout = wibox.layout.fixed.vertical
    },
    widget = wibox.container.background,
    bg = beautiful.bg_normal,
    shape_border_width = user.border,
    shape_border_color = beautiful.fg_normal

})

mycolorpicker = wibox.widget {
    {
        {
            {

                {

                    widget = wibox.widget.imagebox,
                    resize = true,
                    forced_height = 20,
                    forced_width = 20,
                    image = beautiful.fill
                },
                widget = wibox.container.place,
                halign = "center",
                valign = "center"
            },
            widget = wibox.container.margin,
            margins = dpi(5)
        },
        widget = wibox.container.background,
        shape_border_width = user.border,
        shape_border_color = beautiful.fg_normal
    },
    widget = wibox.container.margin,
    margins = {top = dpi(10), bottom = dpi(10), left = dpi(8), right = dpi(0)}
}

mycolorpicker:connect_signal("button::release", function(_, _, _, button)
    if button == 1 then
        window.visible = not window.visible
    elseif button == 3 then
        awful.spawn.easy_async("gpick -s -o", function(out)
            if out:len() > 0 then
                awful.spawn.with_shell("xclip -r -sel c << EOF\n" .. out ..
                                           "EOF")
                naughty.notification {
                    title = "Picked a color!",
                    message = "Your color is " .. out:gsub("\n", ""),
                    icon = beautiful.fill
                }

                -- replacing the theme variable
                local function replaceVariableWithColor(color)
                    local file_content = io.open(
                                             "/home/beck/.config/awesome/theme/init.lua",
                                             "r")

                    local content = file_content:read("*all")
                    file_content:close()

                    local updated_content =
                        content:gsub("theme.accent" .. " = \"#%x+\"",
                                     "theme.accent" .. " = \"" .. color .. "\"")

                    local file_write = io.open(
                                           "/home/beck/.config/awesome/theme/init.lua",
                                           "w")

                    file_write:write(updated_content)
                    file_write:close()

                end

                replaceVariableWithColor(out:match("#%x%x%x%x%x%x"))

                local hex_color = out:match("#%x%x%x%x%x%x")

                if hex_color then
                    local colornew = create_colorbox(hex_color)
                    empty_box.visible = false
                    colorlist:reset()
                    add_to_table(colornew)
                else
                    naughty.notify({
                        title = "Uh oh!",
                        text = "Invalid color code received " .. out
                    })
                end
            else
                naughty.notification {
                    title = "Cancelled!",
                    message = "The action was cancelled."
                }
            end
        end)
    end
end)

-- clear all colors
awesome.connect_signal("clear::colors", function()
    colorlist:reset()
    for k in pairs(color_table) do color_table[k] = nil end
    empty_box.visible = true
end)

helpers.hoverCursor(mycolorpicker)
click_to_hide.popup(window, nil, true)

return toggleButton
