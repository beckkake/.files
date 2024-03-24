local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local config = require("config.user")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

-- args borrowed from tsukki9696
-- https://github.com/tsukki9696/tsukiyomi/blob/main/widget/launcher/init.lua
args = {

    reset_on_hide = false,
    save_history = true,
    wrap_page_scrolling = true,
    wrap_app_scrolling = true,

    prompt_show_icon = false,
    prompt_icon = "",
    prompt_text_halign = "left",
    placement = function(w)
        awful.placement.bottom_left(w, {
            honor_workarea = true,
            offset = {y = -8, x = -1}
        })
    end,

    prompt_height = dpi(25),
    prompt_margins = dpi(10),
    prompt_paddings = dpi(2),

    apps_per_row = 10,
    apps_per_column = 1,
    apps_spacing = dpi(0),

    apps_margin = dpi(7),
    app_width = dpi(420),
    app_height = dpi(60),

    app_name_halign = "left",
    app_name_valign = "center",

    app_show_icon = false,

    app_content_padding = dpi(10),
    app_content_spacing = dpi(3),

    prompt_icon_font = beautiful.font,
    app_name_font = beautiful.font,

    app_shape = helpers.shape(10),

    background = beautiful.bg_dark,
    prompt_color = beautiful.bg_dark,
    prompt_border_color = beautiful.bg_dark,
    prompt_icon_color = beautiful.bg_dark,
    prompt_text_color = beautiful.fg_normal,
    prompt_cursor_color = beautiful.bg_dark,
    app_normal_color = beautiful.bg_dark,
    app_normal_hover_color = beautiful.bg_dark,
    app_selected_color = beautiful.bg_light,
    app_selected_hover_color = beautiful.bg_light,
    app_name_normal_color = beautiful.fg_normal,
    app_name_selected_color = beautiful.fg_normal

}
