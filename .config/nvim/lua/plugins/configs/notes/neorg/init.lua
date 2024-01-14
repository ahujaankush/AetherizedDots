local neorg = require "neorg"
local options = {
  load = {
    ["core.defaults"] = require "plugins.configs.notes.neorg.modules.defaults",
    ["core.dirman"] = require "plugins.configs.notes.neorg.modules.dirman",
    ["core.completion"] = require "plugins.configs.notes.neorg.modules.completion",
    ["core.highlights"] = require "plugins.configs.notes.neorg.modules.highlights",
    ["core.concealer"] = require "plugins.configs.notes.neorg.modules.concealer",
    ["core.export"] = require "plugins.configs.notes.neorg.modules.export",
    ["core.presenter"] = require "plugins.configs.notes.neorg.modules.presenter",
    ["core.summary"] = require "plugins.configs.notes.neorg.modules.summary",
    ["core.ui.calendar"] = {},
    ["core.integrations.telescope"] = {},
  },
}
neorg.setup(options)
