local paint = require "paint"
local options = {
  highlights = {
    {
      filter = function(buf)
        return true
      end,
      pattern = "(@%w+)",
      hl = "DocKeyword",
    },
  },
}

paint.setup(options)
