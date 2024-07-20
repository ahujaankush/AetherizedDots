local autotag = require "nvim-ts-autotag"

local options = {
  opts = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
  },
}

autotag.setup(options)
