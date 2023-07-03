local M = {}

M.base_30 = {
  white = "#ffffff",
  darker_black = "#0a0d11",
  black = "#0E1115", --  nvim bg
  black2 = "#171C21",
  one_bg = "#212428", -- real bg of onedark
  one_bg2 = "#2d3139",
  one_bg3 = "#33363a",
  grey = "#3e4145",
  grey_fg = "#45484c",
  grey_fg2 = "#4a4d51",
  light_grey = "#525559",
  red = "#f7467b",
  baby_pink = "#ff62a4",
  pink = "#ff75a0",
  line = "#31353d", -- for lines like vertsplit
  green = "#00ffb1",
  vibrant_green = "#1addb0",
  nord_blue = "#53befc",
  blue = "#2798e4",
  yellow = "#FFC457",
  sun = "#FFA246",
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
  base00 = "#0E1115",
  base01 = "#171C21",
  base02 = "#23262a",
  base03 = "#2d3139",
  base04 = "#323539",
  base05 = "#abb2bf",
  base06 = "#b6bdca",
  base07 = "#c8ccd4",
  base08 = "#f7467b",
  base09 = "#ff8a30",
  base0A = "#FFC457",
  base0B = "#00ffb1",
  base0C = "#2bfcfc",
  base0D = "#9554ff",
  base0E = "#2798e4",
  base0F = "#ff62a4",
}

M.type = "dark"

M = require("base46").override_theme(M, "aether2")

return M
