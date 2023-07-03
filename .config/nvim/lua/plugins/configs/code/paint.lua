local paint = require "paint"
local options = {
  ---@type PaintHighlight[]
  highlights = {
    {
      -- filter can be a table of buffer options that should match,
      -- or a function called with buf as param that should return true.
      -- The example below will paint @something in comments with Constant
      filter = function(buf)
        return true
      end,
      pattern = "(@%w+)",
      hl = "DocKeyword",
    },
  },
}

paint.setup(options)
