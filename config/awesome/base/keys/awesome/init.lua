local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local modkey = require("base.helpers.modkey")
local naughty = require("naughty")
require("awful.hotkeys_popup.keys")
require("scripts.screenshot")
require("widget.bar.components.mycolorpicker")

local user = require("user")
local launcher = require("widget.launcher")
local bling = require("modules.bling")

awful.keyboard.append_global_keybindings({
    -- defaults
    awful.key({modkey}, "s", hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}),
    awful.key({modkey, "Control"}, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({modkey, "Shift"}, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({modkey}, "Return", function() awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({modkey}, "r", function()
        local app_launcher = bling.widget.app_launcher(launcher)
        app_launcher:toggle()
    end, {description = "run launcher", group = "launcher"}), -- volume
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%")
    end, {description = "raise volume", group = "audio"}),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%")
    end, {description = "lower volume", group = "audio"}),
    awful.key({}, "XF86AudioMute", function()
        awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    end, {description = "mute volume", group = "audio"}),
    awful.key({}, "XF86AudioMicMute", function()
        awful.spawn.with_shell("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    end, {description = "lower volume", group = "audio"}), -- screenshots
    awful.key({}, "Print",
              function() awesome.emit_signal("screenshot::full") end,
              {description = "screenshot whole screen", group = "screenshot"}),
    awful.key({modkey}, "Print",
              function() awesome.emit_signal("screenshot::part") end,
              {description = "screenshot selection", group = "screenshot"}),
    -- brightness
    awful.key({}, "XF86MonBrightnessUp",
              function() awful.spawn.with_shell("brightnessctl set +10%") end,
              {description = "raise brightness", group = "awesome"}),
    awful.key({}, "XF86MonBrightnessDown",
              function() awful.spawn.with_shell("brightnessctl set 10%-") end,
              {description = "raise brightness", group = "awesome"}),

    -- toggles
    awful.key({modkey}, "b", function()
        for s in screen do s.mywibox.visible = not s.mywibox.visible end
    end, {description = "toggle wibox", group = "awesome"}), -- extras 
    awful.key({modkey, "Shift"}, "t", function()
        naughty.notification({title = "Notification", text = "Hi, Reddit!"})
    end, {description = "send a test notification", group = "awesome"}),
    awful.key({modkey, "Shift"}, "g", function()
        awful.spawn.easy_async("gpick -s -o", function(out)
            awful.spawn.with_shell("xclip -r -sel c << EOF\n" .. out .. "EOF")
            naughty.notification {
                title = "Picked a color!",
                message = "Your color is " .. out:gsub("\n", ""),
                icon = os.getenv("HOME") .. "/.config/awesome/assets/pick.svg"
            }
            local function replaceVariableWithColor(color)
                local file_content = io.open(
                                         "/home/beck/.config/awesome/theme/init.lua",
                                         "r")

                local content = file_content:read("*all")
                file_content:close()

                local updated_content = content:gsub("theme.accent" ..
                                                         " = \"#%x+\"",
                                                     "theme.accent" .. " = \"" ..
                                                         color .. "\"")
                local file_write = io.open(
                                       "/home/beck/.config/awesome/theme/init.lua",
                                       "w")
                file_write:write(updated_content)
                file_write:close()
            end
            replaceVariableWithColor(out:match("#%x%x%x%x%x%x"))
        end)
    end), {description = "pick a color from the screen", group = "awesome"},
    awful.key({modkey, "Shift"}, "w", function()
        awful.spawn.easy_async_with_shell(
            "cat ~/.config/awesome/scripts/cycleWallpapers.lua | awesome-client")
    end, {description = "cycle wallpapers", group = "awesome"})

})
