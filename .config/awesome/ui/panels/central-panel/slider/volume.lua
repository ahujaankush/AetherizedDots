local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

-- Set colors
local active_color = beautiful.color4
local background_color = beautiful.color8

local volume_bar = wibox.widget {
  max_value        = 100,
  value            = 50,
  shape            = gears.shape.rounded_bar,
  bar_shape        = gears.shape.rounded_bar,
  color            = active_color,
  background_color = background_color,
  border_width     = 0,
  border_color     = beautiful.border_color,
  widget           = wibox.widget.progressbar,
}

local update_slider = function()
  awful.spawn.easy_async_with_shell(
    "amixer sget Master | awk -F'[][]' '/Right:|Mono:/ && NF > 1 {sub(/%/, \"\"); printf \"%0.0f\", $2}'",
    function(stdout)
      local value = string.gsub(stdout, "^%s*(.-)%s*$", "%1")
      volume_bar.value = tonumber(value)
    end
  )
end

-- Update on startup
update_slider()

-- The emit will come from the global keybind
awesome.connect_signal("widget::volume", function()
  update_slider()
end)

-- The emit will come from the OSD
awesome.connect_signal("widget::volume:update", function(value)
  volume_bar.value = tonumber(value)
end)

return volume_bar
