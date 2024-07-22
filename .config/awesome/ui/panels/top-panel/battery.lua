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
  local charging_color = beautiful.color4

  local battery = wibox.widget({
    widget = wibox.container.arcchart,
    max_value = 100,
    min_value = 0,
    value = 50,
    thickness = dpi(4),
    rounded_edge = true,
    bg = happy_color .. "44",
    colors = { happy_color },
    start_angle = 0,
  })

  local battery_percentage_text = wibox.widget({
    id = "percent_text",
    text = "50%",
    font = beautiful.font_name .. "Medium 12",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
  })

  local battery_layout = wibox.widget({
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(5),
    battery,
    battery_percentage_text,
  })

  local widget = wbutton.elevated.normal({
    child = battery_layout,
    normal_bg = beautiful.widget_bg,
    hover_bg = beautiful.one_bg,
    paddings = 0,
    margins = 0,
    on_release = function(self)
      battery_percentage_text.visible = not battery_percentage_text.visible
      if battery_percentage_text.visible then
        battery_layout.spacing = dpi(5)
      else
        battery_layout.spacing = 0
      end
    end,
  })

  upower_daemon:connect_signal("no_devices", function(_)
    widget.visible = false
  end)

  upower_daemon:connect_signal("update", function(self, value, state)
    battery:set_value(value)

    battery_percentage_text:set_text(math.floor(value) .. "%")

    if state == 1 then
      battery.bg = charging_color .. "44"
      battery.colors = { charging_color }
    elseif value <= 15 then
      battery.bg = sad_color .. "44"
      battery.colors = { sad_color }
    elseif value <= 30 then
      battery.bg = ok_color .. "44"
      battery.colors = { ok_color }
    else
      battery.bg = happy_color .. "44"
      battery.colors = { happy_color }
    end
  end)

  return widget
end
