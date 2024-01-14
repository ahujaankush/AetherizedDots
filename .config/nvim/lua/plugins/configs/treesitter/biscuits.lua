local biscuits = require "nvim-biscuits"
local options = {
  default_config = {
    max_length = 50,
    min_distance = 10,
    prefix_string = "\t ",
  },
  language_config = {
  },
}

biscuits.setup(options)
