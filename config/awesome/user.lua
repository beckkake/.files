local awful = require("awful")
local home = os.getenv("HOME") .. "/"
local wallpapers = home .. "Pictures/Wallpapers/"
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local user = {}

user.colorscheme = "adwaita"
user.wallpaper = wallpapers .. "inuyasha.png"
user.screenshots = home .. "Pictures/Screenshots"
user.icon_theme = home .. ".icons/Pixelitos" -- https://github.com/ItzSelenux/pixelitos-icon-theme
user.border = dpi(1)
user.name = "Beck"
user.dock_enabled = true

return user
