require("widget.bar")
require("widget.launcher")
require("widget.controlcenter")

local user = require("user")
if user.dock_enabled == true then require("widget.dock") end
return
