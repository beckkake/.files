local awful = require("awful")
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")
local delayed_call = require("gears.timer").delayed_call
local cairo = require("lgi").cairo

local function apply_shape(draw, shape, outer_shape_args, inner_shape_args)
    local geo = draw:geometry()

    local border = 0
    local titlebar_height = border

    local img = cairo.ImageSurface(cairo.Format.A1, geo.width, geo.height)
    local cr = cairo.Context(img)

    cr:set_operator(cairo.Operator.CLEAR)
    cr:set_source_rgba(0, 0, 0, 1)
    cr:paint()
    cr:set_operator(cairo.Operator.SOURCE)
    cr:set_source_rgba(1, 1, 1, 1)

    shape(cr, geo.width, geo.height, outer_shape_args)
    cr:fill()
    draw.shape_bounding = img._native

    cr:set_operator(cairo.Operator.CLEAR)
    cr:set_source_rgba(0, 0, 0, 1)
    cr:paint()
    cr:set_operator(cairo.Operator.SOURCE)
    cr:set_source_rgba(1, 1, 1, 1)

    gears.shape.transform(shape):translate(border, titlebar_height)(cr,
                                                                    geo.width -
                                                                        border *
                                                                        2,
                                                                    geo.height -
                                                                        titlebar_height -
                                                                        border,
                                                                    inner_shape_args)
    cr:fill()
    draw.shape_clip = img._native

    img:finish()
end

local pending_shapes = {}
local function round_up_client_corners(c, force, reference)
    if not force and (( -- @TODO: figure it out and uncomment
    not beautiful.client_border_radius or beautiful.client_border_radius == 0) or
        (not c.valid) or (c.fullscreen) or (pending_shapes[c]) or
        (#c:tags() < 1)) or beautiful.skip_rounding_for_crazy_borders then
        -- clog('R1 F='..(force or 'nil').. ', R='..(reference or '')..', C='.. (c and c.name or '<no name>'), c)
        return
    end
    -- clog({"Geometry", c:tags()}, c)
    pending_shapes[c] = true
    delayed_call(function()
        local client_tag = choose_tag(c)
        if not client_tag then
            nlog('no client tag')
            return
        end
        local num_tiled = get_num_tiled(client_tag)
        -- clog({"Shape", num_tiled, client_tag.master_fill_policy, c.name}, c)
        -- if not force and (c.maximized or (
        if (c.maximized or c.fullscreen or
            ((num_tiled <= 1 and client_tag.master_fill_policy == 'expand') and
                not c.floating and client_tag.layout.name ~= "floating")) then
            pending_shapes[c] = nil
            -- nlog('R2 F='..(force and force or 'nil').. ', R='..reference..', C='.. c.name)
            return
        end
        -- Draw outer shape only if floating layout or useless gaps
        local outer_shape_args = 0
        if client_tag.layout.name == "floating" or client_tag:get_gap() ~= 0 then
            outer_shape_args = beautiful.client_border_radius
        end
        local inner_shape_args = beautiful.client_border_radius * 1.0
        -- local inner_shape_args = beautiful.client_border_radius - beautiful.base_border_width
        -- if inner_shape_args < 0 then inner_shape_args = 0 end
        apply_shape(c, gears.shape.rounded_rect, outer_shape_args,
                    inner_shape_args)
        -- clog("apply_shape "..(reference or 'no_ref'), c)
        pending_shapes[c] = nil
        -- nlog('OK F='..(force and "true" or 'nil').. ', R='..reference..', C='.. c.name)
    end)
end

client.connect_signal("request::manage",
                      function(c) round_up_client_corners(c, false, "MF") end)

-- Add a titlebar if titlebars_enabled is set to true for the client in `config/rules.lua`.
client.connect_signal("request::titlebars", function(c)
    -- While this isn't actually in the example configuration, it's the most sane thing to do.
    -- If a client expressly says not to draw titlebars on it, just don't.
    if c.requests_no_titlebars then return end
    require("ui.titlebar").normal(c)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate({context = "mouse_enter", raise = false})
end)

