local neorg = require "neorg"
local options = {
  load = {
    ["core.defaults"] = require "plugins.configs.notes.neorg.modules.defaults",
    ["core.dirman"] = require "plugins.configs.notes.neorg.modules.dirman",
  },
}
neorg.setup(options)
