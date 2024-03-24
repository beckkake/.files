-- stolen from tsukki9696, who stole it from chadcat
-- this rounds the corners on things
local helpers = {}
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi

helpers.shape = function(radius)
    radius = radius or dpi(4)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

return helpers
