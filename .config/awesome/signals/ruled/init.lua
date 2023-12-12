local ruled = require("ruled")
local awful = require("awful")

ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule {
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            size_hints_honor = false,
            placement = awful.placement.no_overlap +
                awful.placement.no_offscreen
        }
    }

    ruled.client.append_rule {
        id = "floating",
        rule_any = {
            instance = {"copyq", "pinentry"},
            class = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            name = {"Event Tester"},
            role = {"AlarmWindow", "ConfigManager", "pop-up"}
        },
        properties = {floating = true}
    }

    ruled.client.append_rule {
        id = "titlebars",
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = true}
    }

end)

