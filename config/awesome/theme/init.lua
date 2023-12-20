local awful = require("awful")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local wibox = require("wibox")
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local config_path = gfs.get_configuration_dir()
local icon_path = os.getenv("HOME") .. "/.icons/Pixelitos/128/apps/"

local user = require("user")
local color = require("theme.colorscheme")
local theme = {}

theme.font = "CozetteHiDpi 20"

-- colors
theme.red = color.red
theme.orange = color.orange
theme.yellow = color.yellow
theme.green = color.green
theme.cyan = color.cyan
theme.lightblue = color.lightblue
theme.blue = color.blue
theme.purple = color.purple
theme.magenta = color.magenta

theme.accent = "#8D6C05"

theme.bg_dark = color.bg_dark
theme.bg_dim = color.bg_dim
theme.bg_normal = color.bg_normal
theme.bg_light = color.bg_light
theme.mid_dark = color.mid_dark
theme.mid_normal = color.mid_normal
theme.mid_light = color.mid_light
theme.fg_normal = color.fg_normal

theme.transparent = "#00000000"

-- generate taglist squares
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
                                taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
                                  taglist_square_size, theme.fg_normal)

-- taglist
theme.taglist_font = theme.font
theme.taglist_bg_focus = color.bg_normal
theme.taglist_bg_occupied = color.bg_normal
theme.taglist_bg_empty = color.bg_normal
theme.taglist_bg_urgent = theme.accent

-- tasklist
theme.tasklist_bg_focus = color.bg_normal
theme.tasklist_bg_normal = color.bg_normal
theme.tasklist_disable_task_name = true

-- titlebar
theme.titlebar_bg_normal = color.bg_normal
theme.titlebar_bg_focus = color.bg_normal
theme.titlebar_bg_urgent = color.bg_normal

theme.titlebar_fg_normal = color.fg_normal
theme.titlebar_fg_focus = color.fg_normal
theme.titlebar_fg_urgent = color.red

-- systray
theme.bg_systray = color.bg_dark
theme.systray_icon_spacing = dpi(8)

-- tooltips
theme.tooltip_bg = theme.accent
theme.tooltip_fg = color.bg_normal
theme.tooltip_border_color = color.fg_normal
theme.tooltip_border_width = user.border

-- notifications
theme.notification_spacing = dpi(8)
theme.notification_margin = dpi(12)

-- other
theme.useless_gap = dpi(5)
theme.border_width = user.border
theme.border_color_normal = color.fg_normal
theme.border_color_active = color.fg_normal
theme.border_color_marked = color.fg_normal
theme.snap_border_width = user.border
theme.snap_bg = color.fg_normal
theme.snap_shape = gears.shape.rectangle

-- (awesome) icons
theme.titlebar_close_button_normal = config_path .. "assets/close.svg"
theme.titlebar_close_button_focus = config_path .. "assets/close.svg"

theme.titlebar_minimize_button_normal = config_path .. "assets/minus.svg"
theme.titlebar_minimize_button_focus = config_path .. "assets/minus.svg"

theme.titlebar_maximized_button_normal_inactive = config_path ..
                                                      "assets/plus.svg"
theme.titlebar_maximized_button_focus_inactive = config_path ..
                                                     "assets/plus.svg"
theme.titlebar_maximized_button_normal_active = config_path .. "assets/plus.svg"
theme.titlebar_maximized_button_focus_active = config_path .. "assets/plus.svg"

theme.layout_tile = config_path .. "assets/tile.svg"
theme.layout_floating = config_path .. "assets/floating.svg"
-- custom icons
theme.arrow = config_path .. "assets/arrow.svg"
theme.arrowRight = config_path .. "assets/arrowRight.svg"
theme.previous = config_path .. "assets/previous.svg"
theme.next = config_path .. "assets/next.svg"
theme.home = config_path .. "assets/home.svg"
theme.tag = config_path .. "assets/tag.svg"
theme.logout = config_path .. "assets/logout.svg"
theme.search = config_path .. "assets/search.svg"
theme.resize = config_path .. "assets/resize.svg"
theme.move = config_path .. "assets/move.svg"
theme.notifications = config_path .. "assets/notification.svg"
theme.main = config_path .. "assets/main.svg"
theme.settings = config_path .. "assets/settings.svg"
theme.volume = config_path .. "assets/volume.svg"
theme.brightness = config_path .. "assets/brightness.svg"
theme.charging = config_path .. "assets/charging.svg"
theme.trash = config_path .. "assets/trash.svg"
theme.fill = config_path .. "assets/fill.svg"

theme.wallpaper = user.wallpaper

return theme
