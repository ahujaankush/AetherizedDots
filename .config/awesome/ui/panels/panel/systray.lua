local awful           = require("awful")
local wibox           = require("wibox")
local beautiful       = require("beautiful")
local xresources      = require("beautiful.xresources")
local dpi             = xresources.apply_dpi
local wbutton         = require("ui.widgets.button")

--- Modern Top Panel
--- ~~~~~~~~~~~~~~~~~~~

--- Systray
--- Outside of panel function cuz of multi monitor support
--- ~~~~~~~

local tray_widget     = wibox.widget.systray()
tray_widget.base_size = beautiful.systray_icon_size

return function(s)
  local widget = wibox.widget({
    widget = wibox.container.margin,
    margins = {
      top = dpi(5),
      bottom = dpi(5)
    },
    wbutton.elevated.normal({
      child = wibox.widget({
        nil,
        tray_widget,
        expand = "outside",
        layout = wibox.layout.align.vertical,
      }),
      normal_bg = beautiful.widget_bg,
      hover_bg = beautiful.widget_bg,
      paddings = dpi(3),
      margins = {
        top = 0,
        left = 0,
        right = 0,
        bottom = 0
      },
      on_hover = function(self)
        tray_widget:set_screen(s)
      end,
    })
  })

  return widget
end
