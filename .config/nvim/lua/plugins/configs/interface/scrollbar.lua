local scrollbar = require "scrollbar"

local options = {
  set_highlights = false,
  excluded_filetypes = {
    "prompt",
    "TelescopePrompt",
    "noice",
    "neo-tree",
    "neo-tree-popup",
  },
}

scrollbar.setup(options)
