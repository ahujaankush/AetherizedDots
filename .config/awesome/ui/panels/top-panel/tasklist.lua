local awful = require("awful")
local helpers = require("helpers")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi



local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end),
    awful.button({}, 3, function(c)
        c:kill()
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

return function(s)
    return (
        awful.widget.tasklist({
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons,
            style = {
                font = beautiful.font,
                bg_focus = beautiful.widget_bg,
                bg_normal = beautiful.transparent,
                bg_minimize = beautiful.transparent,
                shape = helpers.ui.rrect(beautiful.border_radius),
            },
            layout = {
                layout = wibox.layout.fixed.horizontal,
            },
            widget_template = {
                {
                    {
                        {
                            {
                                awful.widget.clienticon,
                                halign = "center",
                                valign = "center",
                                widget = wibox.container.place,
                            },
                            margins = dpi(5),
                            widget = wibox.container.margin,
                        },
                        {
                            nil,
                            nil,
                            {
                                {
                                    nil,
                                    {
                                        widget = wibox.container.background,
                                        id = "pointer",
                                        bg = beautiful.accent,
                                        shape = gears.shape.rounded_bar,
                                        forced_height = dpi(2),
                                    },
                                    layout = wibox.layout.align.horizontal
                                },
                                margins = {
                                    left = beautiful.border_radius,
                                    right = beautiful.border_radius,
                                },
                                widget = wibox.container.margin,
                            },
                            layout = wibox.layout.align.vertical
                        },
                        layout = wibox.layout.stack,
                    },
                    id = "background_role",
                    widget = wibox.container.background,
                },
                margins = {
                    top = dpi(5),
                    bottom = dpi(5),
                    right = dpi(5)
                },
                widget = wibox.container.margin,

                update_callback = function(self, c, _, __)
                    collectgarbage("collect")
                    if c.active then
                        self:get_children_by_id("pointer")[1].bg = beautiful.accent
                    elseif c.minimized then
                        self:get_children_by_id("pointer")[1].bg = beautiful.accent .. "00"
                    else
                        self:get_children_by_id("pointer")[1].bg = beautiful.accent .. "44"
                    end
                end,
                create_callback = function(self, c, index, objects) --luacheck: no unused args
                    -- BLING: Toggle the popup on hover and disable it off hover
                    local timed_show = gears.timer {
                        timeout   = 1,
                        call_now  = false,
                        autostart = false,
                        callback  = function()
                            awesome.emit_signal("bling::task_preview::visibility", s, true, c)
                        end
                    }
                    self:connect_signal('mouse::enter', function()
                        timed_show:start()
                    end)
                    self:connect_signal('mouse::leave', function()
                        timed_show:stop()
                        awesome.emit_signal("bling::task_preview::visibility", s, false, c)
                    end)
                end,
            },
        }))
end
