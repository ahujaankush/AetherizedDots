local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local awful = require("awful")
local wbutton = require("ui.widgets.button")

--- Microphone Widget
--- ~~~~~~~~~~~~~~

return function()
    local active_color = beautiful.color6
    local mute_color = active_color .. "66"
    local bg_color = active_color .. "44"

    local mic = wibox.widget({
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

    local mic_percentage_text = wibox.widget({
        id = "percent_text",
        text = "50%",
        font = beautiful.font_name .. "Medium 12",
        align = "center",
        valign = "center",
        visible = locked,
        widget = wibox.widget.textbox,
    })

    local mic_layout = wibox.widget({
        layout = wibox.layout.fixed.horizontal,
        spacing = locked and dpi(5) or 0,
        mic,
        mic_percentage_text,
    })

    local widget = wbutton.elevated.normal({
        child = mic_layout,
        normal_bg = beautiful.widget_bg,
        hover_bg = beautiful.one_bg,
        paddings = dpi(7),
        margins = {
            top = dpi(5),
            bottom = dpi(5)
        },
        on_hover = function(self)
            mic_percentage_text.visible = true
            mic_layout.spacing = dpi(5)
        end,
        on_leave = function(self)
            mic_percentage_text.visible = locked or false
            mic_layout.spacing = locked and dpi(5) or 0
        end,
        on_release = function(self)
            locked = not locked
        end,
        on_scroll_up = function()
            awful.spawn("pamixer --default-source -i 5", false)
        end,
        on_scroll_down = function()
            awful.spawn("pamixer --default-source -d 5", false)
        end

    })

    -- The emits will come from the global keybind
    awesome.connect_signal("widget::microphone", function(value, muted)
        mic:set_value(value)
        mic_percentage_text:set_text(math.floor(value) .. "%")
        mic.colors = { muted and mute_color or active_color }
    end)

    return widget
end
