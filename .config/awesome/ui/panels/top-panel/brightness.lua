local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local dpi = require("beautiful").xresources.apply_dpi
local wbutton = require("ui.widgets.button")

--- Volume Widget
--- ~~~~~~~~~~~~~~

return function()
    local active_color = beautiful.color3
    local bg_color = active_color .. "44"

    local brightness = wibox.widget({
        widget = wibox.container.arcchart,
        max_value = 100,
        min_value = 0,
        value = 50,
        thickness = dpi(4),
        rounded_edge = true,
        bg = bg_color,
        colors = { active_color },
        start_angle = math.pi + math.pi / 2,
    })

    local locked = true

    local brightness_percentage_text = wibox.widget({
        id = "percent_text",
        text = "50%",
        font = beautiful.font_name .. "Medium 12",
        align = "center",
        valign = "center",
        visible = locked,
        widget = wibox.widget.textbox,
    })

    local brightness_layout = wibox.widget({
        layout = wibox.layout.fixed.horizontal,
        spacing = locked and dpi(5) or 0,
        brightness,
        brightness_percentage_text,
    })

    local widget = wbutton.elevated.normal({
        child = brightness_layout,
        normal_bg = beautiful.widget_bg,
        hover_bg = beautiful.one_bg,
        paddings = dpi(5),
        margins = {
            top = dpi(5),
            bottom = dpi(5)
        },
        on_hover = function(self)
            brightness_percentage_text.visible = true
            brightness_layout.spacing = dpi(5)
        end,
        on_leave = function(self)
            brightness_percentage_text.visible = locked or false
            brightness_layout.spacing = locked and dpi(5) or 0
        end,
        on_release = function(self)
            locked = not locked
        end,
        on_scroll_up = function()
            awful.spawn.with_shell("brightnessctl set 5%+ -q", false)
        end,
        on_scroll_down = function()
            awful.spawn("brightnessctl set 5%- -q", false)
        end
    })

    -- The emits will come from the global keybind
    awesome.connect_signal("widget::brightness", function(value)
        brightness:set_value(value)
        brightness_percentage_text:set_text(math.floor(value) .. "%")
    end)

    return widget
end
