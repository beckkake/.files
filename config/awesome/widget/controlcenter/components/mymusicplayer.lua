local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local playerctl = require("modules.bling").signal.playerctl.lib()
local dpi = beautiful.xresources.apply_dpi
local helpers = require("base.helpers.extras")
local user = require("user")

local icons = require("widget.controlcenter.components.myicons")

local album_art = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.placeholder,
    forced_width = dpi(85),
    forced_height = dpi(85),
    halign = "center",
    valign = "center"
}

local song_artist = wibox.widget {
    widget = wibox.widget.textbox,
    markup = helpers.colorizeText("Unknown", beautiful.mid_light)
}

local song_name = wibox.widget {
    widget = wibox.widget.textbox,
    markup = helpers.colorizeText("None", beautiful.fg_normal)
}

local toggle_button = wibox.widget {
    widget = wibox.widget.imagebox,
    scaling_quality = 'nearest',
    image = beautiful.pause,
    forced_width = dpi(13),
    align = "center",
    valign = "center"
}

local next_button = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.next,
    scaling_quality = 'nearest',
    forced_width = dpi(12),
    align = "center",
    valign = "center"
}

local prev_button = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.prev,
    scaling_quality = 'nearest',
    forced_width = dpi(12),
    align = "center",
    valign = "center"
}

local song_length = wibox.widget {
    max_value = nil,
    value = nil,
    forced_height = dpi(25),
    forced_width = dpi(260),
    align = "center",
    valign = "center",
    paddings = dpi(2),
    color = beautiful.accent,
    background_color = beautiful.bg_normal,
    border_color = beautiful.fg_normal,
    border_width = user.border,
    widget = wibox.widget.progressbar
}

local minutes = wibox.widget {
    widget = wibox.widget.textbox,
    markup = helpers.colorizeText(" ", beautiful.mid_normal),
    align = "center",
    valign = "center"
}

local seconds = wibox.widget {
    widget = wibox.widget.textbox,
    markup = helpers.colorizeText(" ", beautiful.mid_normal),
    align = "center",
    valign = "center"
}

local toggle_command = function() playerctl:play_pause() end
local prev_command = function() playerctl:previous() end
local next_command = function() playerctl:next() end

toggle_button:buttons(gears.table.join(awful.button({}, 1, function()
    toggle_command()
end)))

next_button:buttons(gears.table.join(awful.button({}, 1,
                                                  function() next_command() end)))

prev_button:buttons(gears.table.join(awful.button({}, 1,
                                                  function() prev_command() end)))
playerctl:connect_signal("metadata",
                         function(_, title, artist, album_path, __, ___, ____)
    if title == "" then title = "None" end
    if artist == "" then artist = "Unknown" end
    if album_path == "" then album_path = beautiful.placeholder end

    album_art:set_image(gears.surface.load_uncached(album_path))
    song_name:set_markup_silently(helpers.colorizeText(title,
                                                       beautiful.fg_normal))
    song_artist:set_markup_silently(helpers.colorizeText(artist,
                                                         beautiful.mid_light))

end)

playerctl:connect_signal("playback_status",
                         function(_, playing, __, interval_sec)
    if playing then
        toggle_button.image = beautiful.pause
        song_length.value = interval_sec
    else
        toggle_button.image = beautiful.play
        song_length.value = nil
    end
end)

playerctl:connect_signal("position", function(_, interval_sec, length_sec)
    song_length.max_value = length_sec or 100
    song_length.value = interval_sec or 0
    minutes.markup = helpers.colorizeText(math.floor(interval_sec / 60) .. ":",
                                          beautiful.mid_normal)

    local seconds_value = math.floor(interval_sec % 60)
    local seconds_format = string.format("%02d", seconds_value)
    seconds.markup = helpers.colorizeText(seconds_format, beautiful.mid_normal)
end)

local minutes_seconds = wibox.widget {
    minutes,
    seconds,
    layout = wibox.layout.fixed.horizontal,
    widget = wibox.container.background
}

mymusicplayer = wibox.widget {
    {
        {
            {
                {
                    {
                        album_art,
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(3),
                            bottom = dpi(3),
                            left = dpi(3),
                            right = dpi(3)
                        }
                    },
                    widget = wibox.container.background,
                    bg = beautiful.bg_dark,
                    shape_border_color = beautiful.fg_normal,
                    shape_border_width = user.border
                },
                widget = wibox.container.margin,
                margins = {
                    top = dpi(14),
                    bottom = dpi(14),
                    left = dpi(12),
                    right = dpi(0)
                }
            },
            layout = wibox.layout.fixed.horizontal
        },
        {
            {
                {
                    song_length,
                    layout = wibox.layout.fixed.horizontal,
                    direction = 'east',
                    widget = wibox.container.rotate
                },
                widget = wibox.container.place,
                halign = "left",
                valign = "bottom"
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(0),
                bottom = dpi(12),
                left = dpi(12),
                right = dpi(0)
            }
        },
        layout = wibox.layout.fixed.vertical
    },
    {
        {

            {
                song_name,
                step_function = wibox.container.scroll.step_functions
                    .waiting_nonlinear_back_and_forth,
                widget = wibox.container.scroll.horizontal,
                speed = 30,
                forced_width = dpi(285)
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(16),
                bottom = dpi(0),
                left = dpi(-155),
                right = dpi(12)
            }
        },
        {
            {

                song_artist,
                step_function = wibox.container.scroll.step_functions
                    .waiting_nonlinear_back_and_forth,
                widget = wibox.container.scroll.horizontal,
                speed = 30,
                forced_width = dpi(285)
            },
            widget = wibox.container.margin,
            margins = {
                top = dpi(4),
                bottom = dpi(0),
                left = dpi(-155),
                right = dpi(12)
            }
        },
        {
            minutes_seconds,
            widget = wibox.container.margin,
            margins = {
                top = dpi(4),
                bottom = dpi(0),
                left = dpi(-155),
                right = dpi(12)
            }
        },

        layout = wibox.layout.fixed.vertical
    },
    {
        {
            {
                {
                    {
                        prev_button,
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(0),
                            bottom = dpi(0),
                            left = dpi(10),
                            right = dpi(0)
                        }
                    },
                    {
                        toggle_button,
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(0),
                            bottom = dpi(0),
                            left = dpi(10),
                            right = dpi(10)
                        }
                    },
                    {
                        next_button,
                        widget = wibox.container.margin,
                        margins = {
                            top = dpi(0),
                            bottom = dpi(0),
                            left = dpi(0),
                            right = dpi(8)
                        }
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                widget = wibox.container.background,
                bg = beautiful.bg_dark,
                shape_border_color = beautiful.fg_normal,
                shape_border_width = user.border
            },
            widget = wibox.container.place,
            halign = "center",
            valign = "center"
        },
        widget = wibox.container.margin,
        margins = {
            top = dpi(118),
            bottom = dpi(12),
            left = dpi(-106),
            right = dpi(0)
        }
    },
    layout = wibox.layout.fixed.horizontal
}
