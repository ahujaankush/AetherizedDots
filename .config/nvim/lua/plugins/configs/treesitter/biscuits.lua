local biscuits = require('nvim-biscuits')
local options = {
  default_config = {
    max_length = 100,
    min_distance = 20,
    prefix_string = " 󰅲 "
  },
  language_config = {
  --   html = {
  --     prefix_string = " 🌐 "
  --   },
  --   javascript = {
  --     prefix_string = " ✨ ",
  --     max_length = 80
  --   },
  --   python = {
  --     disabled = true
  --   }
  }
}

biscuits.setup(options)
