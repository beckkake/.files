local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")

local widgets = require("ui")

--- Attach tags and widgets to all screens.
screen.connect_signal("request::desktop_decoration", function(s)
    -- Create all tags and attach the layouts to each of them.
    awful.tag(require("config.user").tags, s, awful.layout.layouts[1])
    -- Attach a wibar to each screen.
    widgets.wibar(s)
end)

--- Wallpaper.
-- NOTE: `awful.wallpaper` is ideal for creating a wallpaper IF YOU
-- BENEFIT FROM IT BEING A WIDGET and not just the root window 
-- background. IF YOU JUST WISH TO SET THE ROOT WINDOW BACKGROUND, you 
-- may want to use the deprecated `gears.wallpaper` instead. This is 
-- the most common case of just wanting to set an image as wallpaper.
screen.connect_signal("request::wallpaper", function(s)
    gears.wallpaper.maximized(nil, s, false, nil)
    awful.wallpaper {
        screen = s,
        honor_workarea = false,
        bg = gears.wallpaper.set(beautiful.bg_light),
        widget = {widget = wibox.container.background, bg = beautiful.bg_light}
    }

end)
-- An example of what"s mentioned above. For more information, see:
-- https://awesomewm.org/apidoc/utility_libraries/gears.wallpaper.html
-- gears.wallpaper.maximized(beautiful.wallpaper)
