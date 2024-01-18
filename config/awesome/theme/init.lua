local awful = require("awful")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local wibox = require("wibox")
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local assets_path = gfs.get_configuration_dir() .. "assets/"
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

theme.accent = "#D3E58F"

theme.bg_dark = color.bg_dark
theme.bg_dim = color.bg_dim
theme.bg_normal = color.bg_normal
theme.bg_light = color.bg_light
theme.mid_dark = color.mid_dark
theme.mid_normal = color.mid_normal
theme.mid_light = color.mid_light
theme.fg_normal = color.fg_normal

theme.transparent = "#00000000"

-- taglist
local taglist_square_size = dpi(8)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
                                taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
                                  taglist_square_size, theme.fg_normal)
theme.taglist_shape = gears.shape.rectangle
theme.taglist_shape_border_width = dpi(1)
theme.taglist_shape_border_color = color.fg_normal
theme.taglist_bg_focus = color.fg_normal

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

-- titlebar 
theme.titlebar_close_button_normal = assets_path .. "close.svg"
theme.titlebar_close_button_focus = assets_path .. "close.svg"
theme.titlebar_minimize_button_normal = assets_path .. "minus.svg"
theme.titlebar_minimize_button_focus = assets_path .. "minus.svg"
theme.titlebar_maximized_button_normal_inactive = assets_path .. "plus.svg"
theme.titlebar_maximized_button_focus_inactive = assets_path .. "plus.svg"
theme.titlebar_maximized_button_normal_active = assets_path .. "plus.svg"
theme.titlebar_maximized_button_focus_active = assets_path .. "plus.svg"

-- layouts 
theme.layout_tile = assets_path .. "tile.svg"
theme.layout_floating = assets_path .. "floating.svg"

-- custom icons
theme.left = assets_path .. "left.svg"
theme.right = assets_path .. "right.svg"
theme.arrowLeft = assets_path .. "arrowLeft.svg"
theme.arrowRight = assets_path .. "arrowRight.svg"
theme.music = assets_path .. "music.svg"
theme.pause = assets_path .. "pause.svg"
theme.play = assets_path .. "play.svg"
theme.prev = assets_path .. "prev.svg"
theme.next = assets_path .. "next.svg"
theme.placeholder = theme.music
theme.home = assets_path .. "home.svg"
theme.tag = assets_path .. "tag.svg"
theme.logout = assets_path .. "logout.svg"
theme.search = assets_path .. "search.svg"
theme.resize = assets_path .. "resize.svg"
theme.move = assets_path .. "move.svg"
theme.notifications = assets_path .. "notification.svg"
theme.main = assets_path .. "main.svg"
theme.settings = assets_path .. "settings.svg"
theme.volume = assets_path .. "volume.svg"
theme.brightness = assets_path .. "brightness.svg"
theme.charging = assets_path .. "charging.svg"
theme.trash = assets_path .. "trash.svg"
theme.fill = assets_path .. "fill.svg"

theme.wallpaper = user.wallpaper

return theme
