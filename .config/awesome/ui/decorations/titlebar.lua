local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local decorations = require("ui.decorations")
local animation = require("modules.animation")
local color = require("modules.color")

--- MacOS like window decorations
--- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--- Disable this if using `picom` to round your corners
--- decorations.enable_rounding()

--- Tabbed
local bling = require("modules.bling")
local tabbed_misc = bling.widget.tabbed_misc

--- Add a titlebar if titlebars_enabled is set to true in the rules.

local createButton = function(c, coln, colh, fn)
  local btn = wibox.widget({
    forced_height = dpi(10),
    bg = coln,
    shape = helpers.ui.rrect(10),
    buttons = {
      awful.button({}, 1, function()
        fn(c)
      end),
    },
    widget = wibox.container.background,
  })
  local resize_anim = animation:new({
    duration = 0.12,
    easing = animation.easing.linear,
    update = function(self, pos)
      btn.forced_height = pos
    end,
  })
  local transition = color.transition(color.color({ hex = coln }), color.color({ hex = colh }), color.transition.HSLA)
  local transition_anim = animation:new({
    duration = 0.25,
    easing = animation.easing.inOutQuad,
    update = function(self, pos)
      btn:set_bg(transition(pos).hex)
    end,
  })

  btn:connect_signal("mouse::enter", function(_)
    resize_anim:set(36)
    transition_anim:set(1)
  end)

  btn:connect_signal("mouse::leave", function(_)
    resize_anim:set(10)
    transition_anim:set(0)
  end)

  return btn
end

-- Add a titlebar
client.connect_signal("request::titlebars", function(c)
  if c.requests_no_titlebar then
    return
  end

  -- buttons for the titlebar
  local close = createButton(c, beautiful.color9, beautiful.color1, function(c1)
    c1:kill()
  end)

  local maximize = createButton(c, beautiful.color11, beautiful.color3, function(c1)
    c1.maximized = not c1.maximized
  end)

  local minimize = createButton(c, beautiful.color10, beautiful.color2, function(c1)
    gears.timer.delayed_call(function()
      c1.minimized = not c1.minimized
    end)
  end)

  local top = {
    {
      {
        {
          close,
          minimize,
          maximize,
          spacing = dpi(8),
          layout = wibox.layout.fixed.vertical,
        },
        margins = dpi(8),
        widget = wibox.container.margin,
      },
      shape = helpers.ui.rrect(beautiful.border_radius),
      bg = beautiful.lighter_black,
      widget = wibox.container.background
    },
    margins = dpi(5),
    widget = wibox.container.margin,
  }

  local center = {
    tabbed_misc.titlebar_indicator(c, {
      icon_size = dpi(16),
      icon_margin = dpi(6),
      layout_spacing = dpi(0),
      bg_color_focus = beautiful.lighter_black,
      bg_color = beautiful.lighter_black,
      icon_shape = gears.shape.rectangle,
    }),
    top = dpi(2),
    bottom = dpi(2),
    left = dpi(8),
    right = dpi(8),
    widget = wibox.container.margin,
  }

  local bottom = {
    {
      {
        awful.titlebar.widget.iconwidget(c),
        margins = dpi(4),
        widget = wibox.container.margin,
      },
      bg = beautiful.lighter_black,
      shape = helpers.ui.rrect(beautiful.border_radius),
      widget = wibox.container.background,
    },
    margins = dpi(5),
    widget = wibox.container.margin,
  }


  awful
      .titlebar(c,
        { position = "left", size = dpi(35), font = beautiful.font_name .. "Medium 10", bg = beautiful.transparent })
      :setup({
        {
          layout = wibox.layout.align.vertical,
          top,
          center,
          bottom,
        },
        bg = beautiful.titlebar_bg,
        shape = helpers.ui.prrect(beautiful.window_rounded and beautiful.border_radius or 0, true, false, false, true),
        widget = wibox.container.background,
      })
end)
