local awful = require("awful")
require("awful.autofocus")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local bling = require("modules.bling")

client.connect_signal("request::manage", function(c)
    --- Add missing icon to client
    if not c.icon then
        local icon = gears.surface(beautiful.theme_assets.awesome_icon(24, beautiful.color8, beautiful.black))
        c.icon = icon._native
        icon:finish()
    end

    --- Set the windows at the slave,
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        --- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

--- Hide all windows when a splash is shown
awesome.connect_signal("widgets::splash::visibility", function(vis)
    local t = screen.primary.selected_tag
    if vis then
        for idx, c in ipairs(t:clients()) do
            c.hidden = true
        end
    else
        for idx, c in ipairs(t:clients()) do
            c.hidden = false
        end
    end
end)

--- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

--- Wallpapers
--- ~~~~~~~~~-
awful.screen.connect_for_each_screen(function(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper

        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end

        gears.wallpaper.maximized(wallpaper, s, false, nil)
    end
end)

--- Tag preview
--- ~~~~~~~~~~~
bling.widget.tag_preview.enable({
    show_client_content = true,
    scale = 0.3,
    honor_workarea = true,
    honor_padding = true,
    placement_fn = function(c)
        awful.placement.bottom_left(c, {
            margins = {
                bottom = beautiful.wibar_height + beautiful.useless_gap * 2,
                left = beautiful.useless_gap * 2,
            }
        })
    end,
    background_widget = wibox.widget({
        image = beautiful.wallpaper,
        horizontal_fit_policy = "fit",
        vertical_fit_policy = "fit",
        widget = wibox.widget.imagebox,
    }),
})

--- Task preview
--- ~~~~~~~~~~~

bling.widget.task_preview.enable({
    placement_fn = function(c)
        awful.placement.bottom(c, {
            margins = {
                bottom = beautiful.wibar_height + beautiful.useless_gap * 2,
            }
        })
    end,
    height = dpi(300),
    width = dpi(500),
    widget_structure = {
        {
            {
                {
                    id = 'icon_role',
                    widget = awful.widget.clienticon,
                },
                {
                    id = 'name_role',
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.flex.horizontal
            },
            widget = wibox.container.margin,
            margins = dpi(5)
        },
        {
            id = 'image_role', -- The client preview
            resize = true,
            valign = 'center',
            halign = 'center',
            widget = wibox.widget.imagebox,
        },
        layout = wibox.layout.fixed.vertical
    }
})
