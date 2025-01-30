local awful   = require("awful")
local wibox   = require("wibox")
local gears   = require("gears")
local cairo   = require("lgi").cairo
local gshape  = require("gears.shape")
local gmatrix = require("gears.matrix")
local ipairs  = ipairs
local table   = table
local capi    = { mouse = mouse }

local _ui     = {}

function _ui.colorize_text(text, color)
  return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

function _ui.add_hover_cursor(w, hover_cursor)
  local original_cursor = "left_ptr"

  w:connect_signal("mouse::enter", function()
    local widget = capi.mouse.current_wibox
    if widget then
      widget.cursor = hover_cursor
    end
  end)

  w:connect_signal("mouse::leave", function()
    local widget = capi.mouse.current_wibox
    if widget then
      widget.cursor = original_cursor
    end
  end)
end

function _ui.vertical_pad(height)
  return wibox.widget({
    forced_height = height,
    layout = wibox.layout.fixed.vertical,
  })
end

function _ui.horizontal_pad(width)
  return wibox.widget({
    forced_width = width,
    layout = wibox.layout.fixed.horizontal,
  })
end

function _ui.rrect(radius)
  return function(cr, width, height)
    gshape.rounded_rect(cr, width, height, radius)
  end
end

function _ui.pie(width, height, start_angle, end_angle, radius)
  return function(cr)
    gshape.pie(cr, width, height, start_angle, end_angle, radius)
  end
end

function _ui.prgram(height, base)
  return function(cr, width)
    gshape.parallelogram(cr, width, height, base)
  end
end

function _ui.prrect(radius, tl, tr, br, bl)
  return function(cr, width, height)
    gshape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
  end
end

function _ui.custom_shape(cr, width, height)
  cr:move_to(0, height / 25)
  cr:line_to(height / 25, 0)
  cr:line_to(width, 0)
  cr:line_to(width, height - height / 25)
  cr:line_to(width - height / 25, height)
  cr:line_to(0, height)
  cr:close_path()
end

local function _get_widget_geometry(_hierarchy, widget)
  local width, height = _hierarchy:get_size()
  if _hierarchy:get_widget() == widget then
    -- Get the extents of this widget in the device space
    local x, y, w, h = gmatrix.transform_rectangle(_hierarchy:get_matrix_to_device(), 0, 0, width, height)
    return { x = x, y = y, width = w, height = h, hierarchy = _hierarchy }
  end

  for _, child in ipairs(_hierarchy:get_children()) do
    local ret = _get_widget_geometry(child, widget)
    if ret then
      return ret
    end
  end
end

function _ui.get_widget_geometry(wibox, widget)
  return _get_widget_geometry(wibox._drawable._widget_hierarchy, widget)
end

function _ui.screen_mask(s, bg)
  local mask = wibox({
    visible = false,
    ontop = true,
    type = "splash",
    screen = s,
  })
  awful.placement.maximize(mask)
  mask.bg = bg
  return mask
end

_ui.crop_surface = function(ratio, surf)
  local old_w, old_h = gears.surface.get_size(surf)
  local old_ratio = old_w / old_h
  if old_ratio == ratio then return surf end

  local new_h = old_h
  local new_w = old_w
  local offset_h, offset_w = 0, 0
  -- quick mafs
  if (old_ratio < ratio) then
    new_h = math.ceil(old_w * (1 / ratio))
    offset_h = math.ceil((old_h - new_h) / 2)
  else
    new_w = math.ceil(old_h * ratio)
    offset_w = math.ceil((old_w - new_w) / 2)
  end

  local out_surf = cairo.ImageSurface(cairo.Format.ARGB32, new_w, new_h)
  local cr = cairo.Context(out_surf)
  cr:set_source_surface(surf, -offset_w, -offset_h)
  cr.operator = cairo.Operator.SOURCE
  cr:paint()

  return out_surf
end

return _ui
