local awful = require('awful')
local naughty = require('naughty')

local mod = require('binds.mod')
local modkey = mod.modkey

local apps = require('config.apps')
local widgets = require('ui')

local bling = require('modules.bling')

--- Global key bindings
awful.keyboard.append_global_keybindings({
    -- General Awesome keys.
    awful.key({modkey}, "s", require("awful.hotkeys_popup").show_help,
              {description = "show help", group = "awesome"}),
    awful.key({modkey, mod.ctrl}, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({modkey, mod.shift}, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({modkey}, "j", function() awful.client.focus.byidx(1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({modkey}, "r", function()
        local app_launcher = bling.widget.app_launcher(args)
        app_launcher:toggle()
    end, {description = "show app launcher", group = "launcher"}),
    awful.key({modkey}, "Return", function() awful.spawn(apps.terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({modkey, mod.shift}, "t", function()
        naughty.notification({title = 'Notification', text = 'Hi!'})
    end, {description = 'send a test notification', group = "awesome"}),
    -- Tags related keybindings.
    awful.key({modkey}, "Left", awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({modkey}, "Right", awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({modkey}, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    -- Focus related keybindings.
    awful.key({modkey}, "j", function() awful.client.focus.byidx(1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({modkey}, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end, {description = "go back", group = "client"}),
    awful.key({modkey, mod.ctrl}, "j",
              function() awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({modkey, mod.ctrl}, "k",
              function() awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({modkey, mod.ctrl}, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then c:activate{raise = true, context = "key.unminimize"} end
    end, {description = "restore minimized", group = "client"}),

    -- Layout related keybindings.
    awful.key({modkey, mod.shift}, "j",
              function() awful.client.swap.byidx(1) end, {
        description = "swap with next client by index",
        group = "client"
    }),
    awful.key({modkey, mod.shift}, "k",
              function() awful.client.swap.byidx(-1) end, {
        description = "swap with previous client by index",
        group = "client"
    }), awful.key({modkey}, "u", awful.client.urgent.jumpto,
                  {description = "jump to urgent client", group = "client"}),
    awful.key({modkey}, "l", function() awful.tag.incmwfact(0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({modkey}, "h", function() awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({modkey, mod.shift}, "h",
              function() awful.tag.incnmaster(1, nil, true) end, {
        description = "increase the number of master clients",
        group = "layout"
    }), awful.key({modkey, mod.shift}, "l",
                  function() awful.tag.incnmaster(-1, nil, true) end, {
        description = "decrease the number of master clients",
        group = "layout"
    }), awful.key({modkey, mod.ctrl}, "h",
                  function() awful.tag.incncol(1, nil, true) end, {
        description = "increase the number of columns",
        group = "layout"
    }), awful.key({modkey, mod.ctrl}, "l",
                  function() awful.tag.incncol(-1, nil, true) end, {
        description = "decrease the number of columns",
        group = "layout"
    }), awful.key({modkey}, "space", function() awful.layout.inc(1) end,
                  {description = "select next", group = "layout"}),
    awful.key({modkey, mod.shift}, "space", function() awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}), awful.key({
        modifiers = {modkey},
        keygroup = "numrow",
        description = "only view tag",
        group = "tag",
        on_press = function(index)
            local tag = awful.screen.focused().tags[index]
            if tag then tag:view_only() end
        end
    }), awful.key({
        modifiers = {modkey, mod.ctrl},
        keygroup = "numrow",
        description = "toggle tag",
        group = "tag",
        on_press = function(index)
            local tag = awful.screen.focused().tags[index]
            if tag then awful.tag.viewtoggle(tag) end
        end
    }), awful.key({
        modifiers = {modkey, mod.shift},
        keygroup = "numrow",
        description = "move focused client to tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:move_to_tag(tag) end
            end
        end
    }), awful.key({
        modifiers = {modkey, mod.ctrl, mod.shift},
        keygroup = "numrow",
        description = "toggle focused client on tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:toggle_tag(tag) end
            end
        end
    }), awful.key({
        modifiers = {modkey},
        keygroup = "numpad",
        description = "select layout directly",
        group = "layout",
        on_press = function(index)
            local t = awful.screen.focused().selected_tag
            if t then t.layout = t.layouts[index] or t.layout end
        end
    }), -- Screenshot control.
    awful.key({modkey}, "Print",
              function() awesome.emit_signal("screenshot::full") end,
              {description = "screenshot whole screen", group = "screenshots"}),
    awful.key({}, "Print",
              function() awesome.emit_signal("screenshot::part") end,
              {description = "screenshot selection", group = "screenshots"}), -- Volume control.
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn("amixer -D pulse set Master 5%+", false)
        awesome.emit_signal("volume_change")
    end, {description = "volume up", group = "volume"}),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn("amixer -D pulse set Master 5%-", false)
        awesome.emit_signal("volume_change")
    end, {description = "volume down", group = "volume"}),
    awful.key({}, "XF86AudioMute", function()
        awful.spawn("amixer -D pulse set Master 1+ toggle", false)
        awesome.emit_signal("volume_change")
    end, {description = "toggle mute", group = "volume"}), -- Media control.
    awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl next") end,
              {description = "skip song forward", group = "media"}),
    awful.key({}, "XF86AudioPrev",
              function() awful.spawn("playerctl previous") end,
              {description = "skip song backward", group = "media"})
})
