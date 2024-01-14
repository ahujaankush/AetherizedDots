return {
  -- { "NvChad/extensions", branch = "v2.0" },

  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-treesitter/nvim-treesitter",
      "dharmx/telescope-media.nvim",
      "LukasPietzschmann/telescope-tabs",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "nvim-neorg/neorg",
    },
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    config = function()
      require "plugins.configs.telescope.telescope"
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require "plugins.configs.telescope.project"
    end,
  },

  {
    "ziontee113/icon-picker.nvim",
    cmd = { "IconPickerInsert", "IconPickerNormal", "IconPickerYank" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require "plugins.configs.telescope.icons"
    end,
  },
}
