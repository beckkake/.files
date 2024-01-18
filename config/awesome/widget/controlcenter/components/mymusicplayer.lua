local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local playerctl = require("modules.bling").signal.playerctl.lib()
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local user = require("user")

local album_art = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.placeholder,
    forced_width = dpi(85),
    forced_width = dpi(85),
    halign = "center",
    valign = "center"

}

local song_artist = wibox.widget {
    widget = wibox.widget.textbox,
    markup = helpers.colorizeText("Unknown", beautiful.fg_normal)
}

local song_name = wibox.widget {
    widget = wibox.widget.textbox,
    markup = helpers.colorizeText("None", beautiful.fg_normal)
}

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

mymusicplayer = wibox.widget {
    {
        {
            song_name,
            song_artist,
            widget = wibox.container.margin,
            margins = {
                top = dpi(0),
                bottom = dpi(0),
                left = dpi(50),
                right = dpi(0)
            }
        },
        layout = wibox.layout.fixed.vertical
    },
    {
        {

            {
                album_art,
                widget = wibox.container.margin,
                margins = {
                    top = dpi(4),
                    bottom = dpi(4),
                    left = dpi(4),
                    right = dpi(4)
                }
            },
            widget = wibox.container.background,
            bg = beautiful.bg_normal,
            shape_border_color = beautiful.fg_normal,
            shape_border_width = user.border
        },
        widget = wibox.container.margin,
        margins = {
            top = dpi(8),
            bottom = dpi(8),
            left = dpi(220),
            right = dpi(8)
        }
    },

    layout = wibox.layout.fixed.horizontal
}

