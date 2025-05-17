local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local widgets = require("ui.widgets")

--- Mic Widget
--- ~~~~~~~~~~~~~~~~~

local function button(icon)
    return widgets.button.text.state({
        forced_width = dpi(60),
        forced_height = dpi(60),
        normal_bg = beautiful.one_bg3,
        normal_shape = gears.shape.circle,
        on_normal_bg = beautiful.accent,
        text_normal_bg = beautiful.accent,
        text_on_normal_bg = beautiful.one_bg3,
        font = beautiful.icon_font .. "Round ",
        size = 17,
        text = icon,
    })
end

local mic_on = "󰍬"
local mic_off = "󰍭"

local widget = button(mic_on)

awesome.connect_signal("widget::microphone", function(value, muted)
    if muted then
        widget:turn_off()
        widget:set_text(mic_off)
    else
        widget:set_text(mic_on)
        widget:turn_on()
    end
end)
--- buttons
widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
    awful.spawn("pamixer -t --default-source", false)
end)))

return widget
