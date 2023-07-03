local animate = require "mini.animate"
local options = {
  -- Cursor path
  cursor = {
    -- Whether to enable this animation
    enable = false,
  },

  -- Vertical scroll
  scroll = {
    -- Whether to enable this animation
    enable = false,
  },

  -- Window resize
  resize = {
    -- Whether to enable this animation
    enable = true,
  },
  open = {
    -- Whether to enable this animation
    enable = true,
  },

  -- Window close
  close = {
    -- Whether to enable this animation
    enable = true,
  },
}

animate.setup(options)
