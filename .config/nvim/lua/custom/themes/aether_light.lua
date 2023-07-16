-- credits to original theme for existing https://github.com/primer/github-vscode-theme
-- This is a modified version of it

local M = {}

M.base_30 = {
  white = "#24292e",
  darker_black = "#f3f5f7",
  black = "#ffffff", --  nvim bg
  black2 = "#edeff1",
  one_bg = "#eaecee",
  one_bg2 = "#e1e3e5", -- StatusBar (filename)
  one_bg3 = "#d7d9db",
  grey = "#c7c9cb", -- Line numbers )
  grey_fg = "#bcbec0",
  grey_fg2 = "#b1b3b5",
  light_grey = "#a6a8aa",
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
  statusline_bg = "#edeff1",
  lightbg = "#e1e3e5",
  pmenu_bg = "#61afef",
  folder_bg = "#61afef",
}

M.base_16 = {
  base00 = "#ffffff", -- Default bg
  base01 = "#edeff1", -- Lighter bg (status bar, line number, folding mks)
  base02 = "#e1e3e5", -- Selection bg
  base03 = "#d7d9db", -- Comments, invisibles, line hl
  base04 = "#c7c9cb", -- Dark fg (status bars)
  base05 = "#383d42", -- Default fg (caret, delimiters, Operators)
  base06 = "#2e3338", -- Light fg (not often used)
  base07 = "#24292e", -- Light bg (not often used)
  base08 = "#f7467b",
  base09 = "#ff8a30",
  base0A = "#FFC457",
  base0B = "#00ffb1",
  base0C = "#2bfcfc",
  base0D = "#9554ff",
  base0E = "#2798e4",
  base0F = "#ff62a4",
}

M.type = "light"

M.polish_hl = {
  ["@punctuation.bracket"] = {
    fg = M.base_30.blue,
  },

  ["@field.key"] = {
    fg = M.base_30.white,
  },

  Constant = {
    fg = M.base_16.base07,
  },

  ["@constructor"] = {
    fg = M.base_30.vibrant_green,
  },

  Tag = {
    fg = M.base_30.vibrant_green,
  },

  ["@operator"] = {
    fg = M.base_30.orange,
  },
}

M = require("base46").override_theme(M, "aether_light")

return M
