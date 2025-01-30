local awful = require("awful")

local layouts = require("configuration.keyboard")

local current_layout_index = 1;

local _keyboard = {}

function _keyboard.switch_to_layout(layout)
  for i, l in pairs(layouts) do
    if l == layout then
      do
        current_layout_index = i
        awful.spawn.with_shell("setxkbmap " .. layout)
        awesome.emit_signal("widget::keyboard", layout)
        break
      end
    end
  end
end

function _keyboard.switch_to_next_layout()
  local new_index = current_layout_index < #layouts and current_layout_index + 1 or 1
  current_layout_index = new_index
  awful.spawn.with_shell("setxkbmap " .. layouts[current_layout_index])
  awesome.emit_signal("widget::keyboard", layouts[current_layout_index])
end

function _keyboard.switch_to_previous_layout()
  local new_index = current_layout_index > 1 and current_layout_index - 1 or #layouts
  current_layout_index = new_index
  awful.spawn.with_shell("setxkbmap " .. layouts[current_layout_index])
  awesome.emit_signal("widget::keyboard", layouts[current_layout_index])
end

return _keyboard
