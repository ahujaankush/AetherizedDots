local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local brightness = require(... .. "./brightness")
local volume = require(... .. "./volume")
local mic = require(... .. "./mic")

-- Helper function that changes the appearance of progress bars and their icons
local function format_progress_bar(bar)
  -- Since we will rotate the bars 90 degrees, width and height are reversed
  bar.forced_height = dpi(14)
  bar.shape = gears.shape.rounded_bar
  bar.bar_shape = gears.shape.rectangle
  return bar
end

return wibox.widget({
  {
    {
      {
        format_progress_bar(brightness),
        format_progress_bar(volume),
        format_progress_bar(mic),
        -- volume,
        -- mic,
        spacing = dpi(14),
        layout = wibox.layout.flex.vertical,
      },
      margins = dpi(15),
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
    forced_width = 0,
    bg = beautiful.widget_bg,
    shape = helpers.ui.rrect(beautiful.border_radius),
  },
  margins = dpi(10),
  widget = wibox.container.margin,
})
