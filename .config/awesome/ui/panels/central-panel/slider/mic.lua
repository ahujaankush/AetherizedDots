local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- Set colors
local active_color = beautiful.color5
local background_color = beautiful.color8

local mic_bar = wibox.widget {
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
    "amixer sget Capture | awk -F'[][]' '/Right:|Mono:/ && NF > 1 {sub(/%/, \"\"); printf \"%0.0f\", $2}'",
    function(stdout)
      local value = string.gsub(stdout, "^%s(.-)%s$", "%1")
      mic_bar.value = tonumber(value)
    end
  )
end

-- Update on startup
update_slider()

return mic_bar
