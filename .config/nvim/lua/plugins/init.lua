-- All plugins have lazy=true by default,to load a plugin on startup just lazy=falseplugins/init
-- List of all default plugins & their definitions
local plugins = {
  "nvim-lua/plenary.nvim",
  {
    "jghauser/mkdir.nvim",
    lazy = false,
  },
  {
    "tpope/vim-repeat",
    event = "BufRead",
  },
}

local spec_tab = {
  "plugins.definition.interface",
  "plugins.definition.lsp",
  "plugins.definition.code",
  "plugins.definition.notes",
  "plugins.definition.telescope",
  "plugins.definition.treesitter",
}

for _, x in pairs(spec_tab) do
  vim.list_extend(plugins, require(x))
end

local config = require("core.utils").load_config()

if #config.plugins > 0 then
  table.insert(plugins, { import = config.plugins })
end

vim.loader.enable()
require("lazy").setup(plugins, config.lazy_nvim)
