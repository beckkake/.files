local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")

return {
    reset_on_hide = false,
    save_history = true,
    wrap_page_scrolling = true, -- leave this in true because it fucking floods me with errors otherwise
    wrap_app_scrolling = true,

    border_width = user.border,

    prompt_show_icon = false,
    prompt_icon = "",
    prompt_text_halign = "left",
    placement = function(w)
        awful.placement.top_left(w, {
            honor_workarea = true,
            offset = {y = 0, x = -1}
        })
    end,

    prompt_height = dpi(40),
    prompt_margins = dpi(10),
    prompt_paddings = dpi(5),

    apps_per_row = 10,
    apps_per_column = 1,
    apps_spacing = dpi(0),

    apps_margin = dpi(7),
    app_width = dpi(400),
    app_height = dpi(50),

    app_name_halign = "left",
    app_name_valign = "center",

    app_show_icon = false,

    app_content_padding = dpi(10),
    app_content_spacing = dpi(0),

    prompt_icon_font = beautiful.font,
    app_name_font = beautiful.font,

    border_color = beautiful.fg_normal,

    background = beautiful.bg_normal,
    prompt_color = beautiful.bg_normal,
    prompt_border_color = beautiful.bg_normal,
    prompt_icon_color = beautiful.bg_normal,
    prompt_text_color = beautiful.mid_normal,
    prompt_cursor_color = beautiful.mid_normal,
    app_normal_color = beautiful.bg_normal,
    app_normal_hover_color = beautiful.bg_dark,
    app_selected_color = beautiful.accent,
    app_selected_hover_color = beautiful.accent,
    app_name_normal_color = beautiful.fg_normal,
    app_name_selected_color = beautiful.bg_normal
}
