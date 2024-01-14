local M = {}

M.base_30 = {
  white = "#dddddd",
  darker_black = "#0b0d12",
  black = "#0e1319", --  nvim bg
  black2 = "#171b21",
  one_bg = "#2d373e", -- real bg of onedark
  one_bg2 = "#333d4b",
  one_bg3 = "#3c404c",
  grey = "#42474c",
  grey_fg = "#4d5155",
  grey_fg2 = "#515459",
  light_grey = "#5e6266",
  red = "#f7467b",
  baby_pink = "#ff62c1",
  pink = "#ff67f9",
  line = "#31353d", -- for lines like vertsplit
  green = "#00ffb1",
  vibrant_green = "#1addb0",
  nord_blue = "#53befc",
  blue = "#2798e4",
  yellow = "#ffc857",
  sun = "#f99e44",
  purple = "#B467F9",
  dark_purple = "#9554ff",
  teal = "#2BCAFC",
  orange = "#ff8a30",
  cyan = "#2bfcfc",
  statusline_bg = "#15191e",
  lightbg = "#24282d",
  pmenu_bg = "#61afef",
  folder_bg = "#61afef",
}

M.base_16 = {
  base00 = M.base_30.black, --  nvim bg
  base01 = M.base_30.black2,
  base02 = M.base_30.one_bg,
  base03 = M.base_30.one_bg2,
  base04 = M.base_30.one_bg3,
  base05 = "#abb2bf",
  base06 = "#b6bdca",
  base07 = M.base_30.light_grey,
  base08 = M.base_30.nord_blue,
  base09 = M.base_30.orange,
  base0A = M.base_30.green,
  base0B = M.base_30.yellow,
  base0C = M.base_30.cyan,
  base0D = M.base_30.purple,
  base0E = M.base_30.red,
  base0F = M.base_30.pink,
}

M.type = "dark"

M = require("base46").override_theme(M, "aether2")

return M
