local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi

-- Specify user preferences for Awesome"s behavior.
return {

    -- Default colorscheme.
    colorscheme = "chocolate",

    -- Default fonts.
    font = "Balsamiq Sans" .. " ",
    font_mono = "ComicShannsMono Nerd Font" .. " ",
    fontsize = "16",

    -- Default decoration.
    toppanel_height = dpi(60),
    inner_gaps = 0,
    outer_gaps = 0,
    border = 0,

    -- Notifications.
    notification_pos = "top_right",

    -- Default modkey.
    -- Usually, Mod4 is the key with a logo between Control and Alt. If you do not like 
    -- this or do not have such a key, I suggest you to remap Mod4 to another key using 
    -- xmodmap or other tools. However, you can use another modifier like Mod1, but it 
    -- may interact with others.
    -- Each screen has its own tag table. You can just define one and append it to all 
    -- screens (default behavior).

    tags = {"1", "2", "3", "4", "5"},
    -- Table of layouts to cover with awful.layout.inc, ORDER MATTERS, the first layout 
    -- in the table is your DEFAULT LAYOUT.
    layouts = {
        awful.layout.suit.tile, awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom, awful.layout.suit.tile.top,
        awful.layout.suit.floating, awful.layout.suit.fair,
        awful.layout.suit.fair.horizontal, awful.layout.suit.spiral,
        awful.layout.suit.spiral.dwindle, -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        awful.layout.suit.corner.nw
    }
}

