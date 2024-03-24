-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
-- Standard awesome library
local gears = require("gears")
local gfs = require("gears.filesystem")

-- Themes define colors, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/init.lua")

local themes_path = gfs.get_themes_dir()
local config_path = gfs.get_configuration_dir()

local config = require("config.user")
local color = require("theme.colorscheme")

local _T = {}

_T.client_border_radius = dpi(45)
_T.base_border_width = dpi(45)

_T.skip_rounding_for_crazy_borders = true

_T.font = config.font .. config.fontsize
_T.font_mono = config.font_mono

_T.bg_dark = color.bg_dark
_T.bg_dim = color.bg_dim
_T.bg_normal = color.bg_normal
_T.bg_light = color.bg_light
_T.mid_dark = color.mid_dark
_T.mid_normal = color.mid_normal
_T.mid_light = color.mid_light
_T.fg_normal = color.fg_normal
_T.transparent = color.transparent

-- AWM values
_T.useless_gap = dpi(5)
_T.border_color_active = config.accent
_T.bg_systray = color.bg_light
_T.systray_max_rows = "1"
_T.systray_icon_spacing = "4"

-- taglist
_T.taglist_font = _T.font
_T.taglist_bg_focus = color.bg_dark
_T.taglist_bg_occupied = color.bg_dark
_T.taglist_bg_empty = color.bg_dark
_T.taglist_bg_urgent = color.bg_dark

-- tasklist
_T.tasklist_bg_focus = color.fg_normal
_T.tasklist_bg_normal = color.fg_normal
_T.tasklist_fg_focus = color.fg_normal
_T.tasklist_fg_normal = color.fg_normal

-- titlebar
_T.titlebar_bg_normal = color.transparent
_T.titlebar_bg_focus = color.transparent
_T.titlebar_bg_urgent = color.transparent
_T.titlebar_fg_normal = color.fg_normal
_T.titlebar_fg_focus = color.fg_normal

-- notifications 
_T.notification_bg = color.transparent
_T.notification_border_width = dpi(3)
_T.notification_border_color = color.transparent
_T.notification_shape = gears.shape.rounded_rect

-- default awm icon variables
_T.menu_submenu_icon = themes_path .. "default/submenu.png"
_T.menu_height = dpi(15)
_T.menu_width = dpi(100)

-- default awm images
_T.titlebar_close_button_normal = (gears.color.recolor_image(config_path ..
                                                                 "assets/pawLeft.svg",
                                                             color.fg_normal))
_T.titlebar_close_button_focus = _T.titlebar_close_button_normal
_T.titlebar_minimize_button_normal = _T.titlebar_close_button_normal
_T.titlebar_minimize_button_focus = _T.titlebar_close_button_normal
_T.titlebar_ontop_button_normal_inactive = themes_path ..
                                               "default/titlebar/ontop_normal_inactive.png"
_T.titlebar_ontop_button_focus_inactive = themes_path ..
                                              "default/titlebar/ontop_focus_inactive.png"
_T.titlebar_ontop_button_normal_active = themes_path ..
                                             "default/titlebar/ontop_normal_active.png"
_T.titlebar_ontop_button_focus_active = themes_path ..
                                            "default/titlebar/ontop_focus_active.png"

_T.titlebar_sticky_button_normal_inactive = themes_path ..
                                                "default/titlebar/sticky_normal_inactive.png"
_T.titlebar_sticky_button_focus_inactive = themes_path ..
                                               "default/titlebar/sticky_focus_inactive.png"
_T.titlebar_sticky_button_normal_active = themes_path ..
                                              "default/titlebar/sticky_normal_active.png"
_T.titlebar_sticky_button_focus_active = themes_path ..
                                             "default/titlebar/sticky_focus_active.png"

_T.titlebar_floating_button_normal_inactive = themes_path ..
                                                  "default/titlebar/floating_normal_inactive.png"
_T.titlebar_floating_button_focus_inactive = themes_path ..
                                                 "default/titlebar/floating_focus_inactive.png"
_T.titlebar_floating_button_normal_active = themes_path ..
                                                "default/titlebar/floating_normal_active.png"
_T.titlebar_floating_button_focus_active = themes_path ..
                                               "default/titlebar/floating_focus_active.png"

_T.titlebar_maximized_button_normal_inactive = _T.titlebar_close_button_normal
_T.titlebar_maximized_button_focus_inactive = _T.titlebar_close_button_normal
_T.titlebar_maximized_button_normal_active = _T.titlebar_close_button_normal
_T.titlebar_maximized_button_focus_active = _T.titlebar_close_button_normal

-- you can use your own layout icons like this
_T.layout_fairh = gears.color.recolor_image(themes_path ..
                                                "default/layouts/fairhw.png",
                                            color.fg_normal)
_T.layout_fairv = gears.color.recolor_image(themes_path ..
                                                "default/layouts/fairvw.png",
                                            color.fg_normal)
_T.layout_floating = gears.color.recolor_image(themes_path ..
                                                   "default/layouts/floatingw.png",
                                               color.fg_normal)
_T.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
_T.layout_max = gears.color.recolor_image(themes_path ..
                                              "default/layouts/maxw.png",
                                          color.fg_normal)
_T.layout_fullscreen = gears.color.recolor_image(themes_path ..
                                                     "default/layouts/fullscreenw.png",
                                                 color.fg_normal)
_T.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
_T.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
_T.layout_tile = gears.color.recolor_image(themes_path ..
                                               "default/layouts/tilew.png",
                                           color.fg_normal)
_T.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
_T.layout_spiral = themes_path .. "default/layouts/spiralw.png"
_T.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
_T.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
_T.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
_T.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
_T.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- add custom assets here
_T.cat = gears.surface.load(config_path .. "assets/cat.svg")
_T.paws = gears.surface.load(config_path .. "assets/paws.svg")
_T.x = gears.surface.load(config_path .. "assets/x.svg")
_T.settings = gears.surface.load(config_path .. "assets/settings.svg")
_T.calendar = gears.surface.load(config_path .. "assets/calendar.svg")
_T.notification = gears.surface.load(config_path .. "assets/notification.svg")
_T.arrow = gears.surface.load(config_path .. "assets/arrow.svg")
_T.catEarsLeft = gears.surface.load(config_path .. "assets/catEarsLeft.svg")
_T.catEarsRight = gears.surface.load(config_path .. "assets/catEarsRight.svg")
_T.pawsLeft = gears.surface.load(config_path .. "assets/pawsLeft.svg")
_T.pawsRight = gears.surface.load(config_path .. "assets/pawsRight.svg")
_T.separator = gears.surface.load(config_path .. "assets/separator.svg")
_T.catHead = gears.surface.load(config_path .. "assets/catHead.svg")
_T.pawsOutline = gears.surface.load(config_path .. "assets/pawsOutline.svg")
_T.bell = gears.surface.load(config_path .. "assets/bell.svg")

_T.icon_theme = nil

return _T
