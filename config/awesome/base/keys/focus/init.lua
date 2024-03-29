local awful = require("awful")
local modkey = require("base.helpers.modkey")

awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "j", function() awful.client.focus.byidx(1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({modkey}, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end, {description = "go back", group = "client"}),
    awful.key({modkey, "Control"}, "j",
              function() awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({modkey, "Control"}, "k",
              function() awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"})
})

