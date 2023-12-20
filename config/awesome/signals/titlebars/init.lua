local awful = require("awful")
local gmath = require("gears.math")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")

client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    --[[ local buttons = {
        awful.button({}, 1, function()
            c:activate{context = "titlebar", action = "mouse_move"}
        end), awful.button({}, 3, function()
            c:activate{context = "titlebar", action = "mouse_resize"}
        end)
    }]]

    local function move_to_previous_tag()
        local c = client.focus
        if not c then return end
        local t = c.screen.selected_tag
        local tags = c.screen.tags
        local idx = t.index
        local newtag = tags[gmath.cycle(#tags, idx - 1)]
        c:move_to_tag(newtag)
        -- awful.tag.viewprev()
    end

    local function move_to_next_tag()
        local c = client.focus
        if not c then return end
        local t = c.screen.selected_tag
        local tags = c.screen.tags
        local idx = t.index
        local newtag = tags[gmath.cycle(#tags, idx + 1)]
        c:move_to_tag(newtag)
        -- awful.tag.viewnext()
    end

    local toptitlebar = awful.titlebar(c, {size = 45})
    local bottomtitlebar = awful.titlebar(c, {position = "bottom", size = 45})

    local resize = {
        {
            {
                {widget = wibox.widget.imagebox, image = beautiful.resize},
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
        margins = {
            top = dpi(10),
            bottom = dpi(10),
            left = dpi(12),
            right = dpi(0)
        },
        buttons = {
            awful.button({}, 1, function()
                c:activate{context = "mouse_click", action = "mouse_resize"}
            end)

        }

    }

    local move = {
        {
            {
                {widget = wibox.widget.imagebox, image = beautiful.move},
                widget = wibox.container.margin,
                margins = {
                    top = dpi(3),
                    bottom = dpi(3),
                    left = dpi(3),
                    right = dpi(3)
                }
            },
            widget = wibox.container.background,
            shape_border_width = user.border,
            shape_border_color = beautiful.fg_normal
        },
        widget = wibox.container.margin,
        margins = {
            top = dpi(10),
            bottom = dpi(10),
            left = dpi(8),
            right = dpi(0)
        },
        buttons = {
            awful.button({}, 1, function()
                c:activate{context = "mouse_click", action = "mouse_move"}
            end)

        }

    }

    bottomtitlebar:setup{
        layout = wibox.layout.align.horizontal,
        {resize, move, layout = wibox.layout.fixed.horizontal},
        nil,
        {
            {
                {
                    {

                        {
                            widget = wibox.widget.imagebox,
                            image = beautiful.previous
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
                margins = {
                    top = dpi(10),
                    bottom = dpi(10),
                    left = dpi(0),
                    right = dpi(0)
                },
                buttons = awful.button({}, 1,
                                       function(c)
                    move_to_previous_tag()
                end)
            },
            layout = wibox.layout.fixed.horizontal(),
            spacing = 8,
            {
                {
                    {
                        {widget = wibox.widget.imagebox, image = beautiful.next},
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
                margins = {
                    top = dpi(10),
                    bottom = dpi(10),
                    left = dpi(0),
                    right = dpi(12)
                },
                buttons = awful.button({}, 1,
                                       function(c)
                    move_to_previous_tag()
                end)
            }
            --[[{
                {
                    {
                        {
                            awful.titlebar.widget.closebutton(c),
                            halign = "right",
                            valign = "center",
                            layout = wibox.layout.fixed.horizontal()
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
                    left = dpi(0),
                    right = dpi(12)
                }
            },
            layout = wibox.layout.fixed.horizontal()]]
        },
        layout = wibox.layout.align.horizontal
    }
    -- end of the bottom

    -- initialize the top titlebar
    toptitlebar:setup{
        nil,
        {
            {
                awful.titlebar.widget.titlewidget(c),
                halign = "center",
                valign = "center",
                buttons = buttons,
                layout = wibox.layout.align.horizontal
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(0),
                bottom = dpi(0),
                left = dpi(10),
                right = dpi(0)
            }
        },
        {

            {
                {
                    {

                        {
                            awful.titlebar.widget.minimizebutton(c),
                            halign = "right",
                            valign = "center",
                            layout = wibox.layout.fixed.horizontal()
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
                margins = {
                    top = dpi(10),
                    bottom = dpi(10),
                    left = dpi(0),
                    right = dpi(0)
                }
            },
            layout = wibox.layout.fixed.horizontal(),
            spacing = 8,
            {
                {
                    {
                        {
                            awful.titlebar.widget.maximizedbutton(c),
                            halign = "right",
                            valign = "center",
                            layout = wibox.layout.fixed.horizontal()
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
                margins = {
                    top = dpi(10),
                    bottom = dpi(10),
                    left = dpi(0),
                    right = dpi(0)
                }
            },
            {
                {
                    {
                        {
                            awful.titlebar.widget.closebutton(c),
                            halign = "right",
                            valign = "center",
                            layout = wibox.layout.fixed.horizontal()
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
                margins = {
                    top = dpi(10),
                    bottom = dpi(10),
                    left = dpi(0),
                    right = dpi(12)
                }
            },
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }

end)

