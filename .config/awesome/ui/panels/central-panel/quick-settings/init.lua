local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")

--- Quick Settings
--- ~~~~~~~~~~~~~~

local quick_settings_text = wibox.widget({
  font = beautiful.font_name .. "Medium 10",
  markup = helpers.ui.colorize_text("Quick Settings", "#666c79"),
  valign = "center",
  widget = wibox.widget.textbox,
})

--- Widgets
local airplane_mode = require(... .. ".airplane-mode")
local blue_light = require(... .. ".blue-light")
local dnd = require(... .. ".dnd")
local floating_mode = require(... .. ".floating-mode")

--- 4x4 grid of button
local buttons = wibox.widget({
  airplane_mode,
  blue_light,
  dnd,
  floating_mode,
  spacing = dpi(16),
  forced_num_cols = 2,
  forced_num_rows = 2,
  layout = wibox.layout.grid,
})

local widget = wibox.widget({
  {
    {
      buttons,
      margins = dpi(20),
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
    bg = beautiful.widget_bg,
    shape = helpers.ui.rrect(beautiful.border_radius),
  },
  margins = dpi(10),
  widget = wibox.container.margin,
})

return widget
