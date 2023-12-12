local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local user = require("user")

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {

            horizontal_fit_policy = "fit",
            vertical_fit_policy = "fit",
            image = beautiful.wallpaper,
            widget = wibox.widget.imagebox
        }

    }

end)
