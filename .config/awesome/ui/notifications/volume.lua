local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

local width = dpi(50)
local height = dpi(300)

local active_color_1 = {
  type = "linear",
  from = { 0, 0 },
  to = { height },
  stops = { { 0, beautiful.color6 }, { 0.50, beautiful.color13 } },
}

local volume_icon = wibox.widget({
  {
    widget = wibox.widget.textbox,
    -- markup = helpers.ui.colorize_text("", beautiful.color6),
    font = "JetBrainsMono Nerd Font 22",
    valign = "center",
    align = "center",
  },
  margins = dpi(5),
  widget = wibox.container.margin,
})

local volume_adjust = awful.popup({
  type = "notification",
  maximum_width = width,
  maximum_height = height,
  visible = false,
  ontop = true,
  widget = wibox.container.background,
  bg = beautiful.background,
  placement = function(c)
    awful.placement.right(c, { margins = { right = dpi(10) } })
  end,
  -- shape = helpers.ui.rrect(beautiful.border_radius),
})

local volume_bar = wibox.widget({
  bar_shape = gears.shape.rounded_rect,
  shape = gears.shape.rounded_rect,
  background_color = beautiful.notification_osd_indicator_bg,
  color = active_color_1,
  max_value = 100,
  value = 0,
  widget = wibox.widget.progressbar,
})

local volume_ratio = wibox.widget({
  layout = wibox.layout.ratio.vertical,
  {
    { volume_bar, direction = "east", widget = wibox.container.rotate },
    top = dpi(20),
    left = dpi(20),
    right = dpi(20),
    widget = wibox.container.margin,
  },
  volume_icon,
  nil,
})

volume_ratio:adjust_ratio(2, 0.72, 0.28, 0)

volume_adjust.widget = wibox.widget({
  volume_ratio,
  border_width = beautiful.border_width * 0,
  border_color = beautiful.border_color,
  bg = beautiful.notification_osd_bg,
  opacity = beautiful.notification_osd_opacity,
  widget = wibox.container.background,
})

local hide_volume_adjust = gears.timer({
  timeout = 3,
  autostart = true,
  callback = function()
    volume_adjust.visible = false
  end,
})

awesome.connect_signal("widget::volume", function(value, muted)
  if muted == true then
    volume_bar.color = beautiful.color8
  else
    volume_bar.color = active_color_1
  end
  volume_bar.value = value

  if volume_adjust.visible then
    hide_volume_adjust:again()
  else
    volume_adjust.visible = true
    hide_volume_adjust:start()
  end
end)
