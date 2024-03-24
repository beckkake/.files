-- Return a table containing all bar modules, with a name attached
-- to each.
return {
    launcher = require(... .. ".launcher"),
    taglist = require(... .. ".taglist"),
    tasklist = require(... .. ".tasklist"),
    layoutbox = require(... .. ".layoutbox"),
    -- calendar = require(... .. ".calendar"),
    textclock = require(... .. ".textclock"),
    settings = require(... .. ".settings"),
    icon = require(... .. ".icon")

}
