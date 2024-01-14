local move = require "mini.move"

local options = {
  mappings = {
    -- Visual
    left = "<A-h>",
    right = "<A-l>",
    down = "<A-j>",
    up = "<A-k>",
    -- Normal
    line_left = "<A-h>",
    line_right = "<A-l>",
    line_down = "<A-j>",
    line_up = "<A-k>",
  },

  -- Options which control moving behavior
  options = {
    -- Automatically reindent selection during linewise vertical move
    reindent_linewise = true,
  },
}

move.setup(options)
