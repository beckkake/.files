local config = require("config.user")

local colorscheme = require("theme.colorscheme.chocolate")
if config.colorscheme ~= nil then
    colorscheme = require("theme.colorscheme." .. config.colorscheme)
end
return colorscheme
