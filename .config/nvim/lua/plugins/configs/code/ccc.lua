local ccc = require "ccc"
local colorInput = require "ccc.input"
local convert = require "ccc.utils.convert"

local rgbHslCmykInputput = setmetatable({
  name = "RGB/HSL/CMYK Picker",
  max = { 1, 1, 1, 360, 1, 1, 1, 1, 1, 1 },
  min = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
  delta = { 1 / 255, 1 / 255, 1 / 255, 1, 0.01, 0.01, 0.005, 0.005, 0.005, 0.005 },
  bar_name = { "R", "G", "B", "H", "S", "L", "C", "M", "Y", "K" },
}, { __index = colorInput })

function rgbHslCmykInputput.format(n, i)
  if i <= 3 then
    -- RGB
    n = n * 255
  elseif i == 5 or i == 6 then
    -- S or L of HSL
    n = n * 100
  elseif i >= 7 then
    -- CMYK
    return ("%5.1f%%"):format(math.floor(n * 200) / 2)
  end
  return ("%6d"):format(n)
end

function rgbHslCmykInputput.from_rgb(RGB)
  local HSL = convert.rgb2hsl(RGB)
  local CMYK = convert.rgb2cmyk(RGB)
  local R, G, B = unpack(RGB)
  local H, S, L = unpack(HSL)
  local C, M, Y, K = unpack(CMYK)
  return { R, G, B, H, S, L, C, M, Y, K }
end

function rgbHslCmykInputput.to_rgb(value)
  return { value[1], value[2], value[3] }
end

function rgbHslCmykInputput:_set_rgb(RGB)
  self.value[1] = RGB[1]
  self.value[2] = RGB[2]
  self.value[3] = RGB[3]
end

function rgbHslCmykInputput:_set_hsl(HSL)
  self.value[4] = HSL[1]
  self.value[5] = HSL[2]
  self.value[6] = HSL[3]
end

function rgbHslCmykInputput:_set_cmyk(CMYK)
  self.value[7] = CMYK[1]
  self.value[8] = CMYK[2]
  self.value[9] = CMYK[3]
  self.value[10] = CMYK[4]
end

function rgbHslCmykInputput:callback(index, new_value)
  self.value[index] = new_value
  local v = self.value
  if index <= 3 then
    local RGB = { v[1], v[2], v[3] }
    local HSL = convert.rgb2hsl(RGB)
    local CMYK = convert.rgb2cmyk(RGB)
    self:_set_hsl(HSL)
    self:_set_cmyk(CMYK)
  elseif index <= 6 then
    local HSL = { v[4], v[5], v[6] }
    local RGB = convert.hsl2rgb(HSL)
    local CMYK = convert.rgb2cmyk(RGB)
    self:_set_rgb(RGB)
    self:_set_cmyk(CMYK)
  else
    local CMYK = { v[7], v[8], v[9], v[10] }
    local RGB = convert.cmyk2rgb(CMYK)
    local HSL = convert.rgb2hsl(RGB)
    self:_set_rgb(RGB)
    self:_set_hsl(HSL)
  end
end

local options = {
  inputs = {
    rgbHslCmykInputput,
  },
  outputs = {
    ccc.output.hex,
    ccc.output.hex_short,
    ccc.output.css_rgb,
    ccc.output.css_hsl,
    ccc.output.css_hwb,
    ccc.output.css_lab,
    ccc.output.css_lch,
    ccc.output.css_oklab,
    ccc.output.css_oklch,
    ccc.output.float,
  },
  pickers = {
    ccc.picker.hex,
    ccc.picker.css_rgb,
    ccc.picker.css_hsl,
    ccc.picker.css_hwb,
    ccc.picker.css_lab,
    ccc.picker.css_lch,
    ccc.picker.css_oklab,
    ccc.picker.css_oklch,
    ccc.picker.css_name,
  },
  convert = {
    { ccc.picker.hex, ccc.output.css_rgb },
    { ccc.picker.css_rgb, ccc.output.css_hsl },
    { ccc.picker.css_hsl, ccc.output.hex },
  },
  highlighter = {
    auto_enable = false,
    lsp = false,
  },
}

ccc.setup(options)
