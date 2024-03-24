local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

catEarsLeft = wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = gears.color.recolor_image(beautiful.catEarsLeft,
                                          beautiful.bg_dark)
    },
    widget = wibox.container.margin,
    margins = {top = dpi(1), bottom = dpi(-2)}
}

catEarsRight = wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = gears.color.recolor_image(beautiful.catEarsRight,
                                          beautiful.bg_dark)
    },
    widget = wibox.container.margin,
    margins = {top = dpi(1), bottom = dpi(-2)}
}

separator = wibox.widget {
    {
        background_color = beautiful.bg_dark,
        shape = gears.shape.rectangle,
        widget = wibox.widget.progressbar
    },
    widget = wibox.container.margin,
    margins = {top = dpi(31), bottom = dpi(0), left = dpi(-1), right = dpi(-1)}
}

pawsLeft = wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = gears.color.recolor_image(beautiful.pawsLeft, beautiful.bg_dark)
    },
    widget = wibox.container.margin,
    margins = {top = dpi(0), bottom = dpi(1)}
}

pawsRight = wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = gears.color
            .recolor_image(beautiful.pawsRight, beautiful.bg_dark)
    },
    widget = wibox.container.margin,
    margins = {top = dpi(0), bottom = dpi(1)}
}
