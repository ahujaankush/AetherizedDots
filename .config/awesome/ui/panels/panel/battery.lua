local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local upower_daemon = require("signal.battery")
local gears = require("gears")
local apps = require("configuration.apps")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")

--- Battery Widget
--- ~~~~~~~~~~~~~~

return function()
    local happy_color = beautiful.color2
    local sad_color = beautiful.color1
    local ok_color = beautiful.color3

    local status_icon = wibox.widget({
        markup = helpers.ui.colorize_text("", beautiful.black),
        font = beautiful.icon_font .. "Round 14",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    })

    local battery_bar = wibox.widget {
        max_value = 100,
        value = 69,
        forced_width = dpi(90),
        forced_height = dpi(30),
        color = ok_color,
        background_color = ok_color .. '55',
        shape = helpers.ui.rrect(beautiful.border_radius),
        widget = wibox.widget.progressbar,
    }

    local battery = wibox.widget({
        battery_bar,
        status_icon,
        layout = wibox.layout.stack,
    })

    local battery_percentage_text = wibox.widget({
        id = "percent_text",
        text = "50%",
        font = beautiful.font_name .. "Medium 12",
        align = "center",
        valign = "center",
        visible = false,
        widget = wibox.widget.textbox,
    })

    local battery_layout = wibox.widget({
        layout = wibox.layout.fixed.horizontal,
        spacing = 0,
        {
            battery,
            top = dpi(1),
            bottom = dpi(1),
            widget = wibox.container.margin,
        },
        battery_percentage_text,
    })

    local locked = false

    local widget = wbutton.elevated.state({
        child = battery_layout,
        normal_bg = beautiful.widget_bg,
        hover_bg = beautiful.one_bg,
        paddings = dpi(5),
        margins = {
            top = dpi(5),
            bottom = dpi(5)
        },
        on_hover = function(self)
            battery_percentage_text.visible = true
            battery_layout.spacing = dpi(5)
        end,
        on_leave = function(self)
            battery_percentage_text.visible = locked or false
            battery_layout.spacing = locked and dpi(5) or 0
        end,
        on_release = function(self)
            locked = not locked
        end,
    })

    upower_daemon:connect_signal("no_devices", function(_)
        widget.visible = false
    end)

    upower_daemon:connect_signal("update", function(self, value, state)
        battery_bar.value = value
        status_icon:set_markup(helpers.ui.colorize_text(state == 1 and "" or "󰯉", beautiful.black))
        battery_percentage_text:set_text(math.floor(value) .. "%")

        if value <= 15 then
            battery_bar.color = sad_color
        elseif value <= 30 then
            battery_bar.color = ok_color
        else
            battery_bar.color = happy_color
        end

        battery_bar.background_color = battery_bar.color .. '55'
    end)

    return widget
end
