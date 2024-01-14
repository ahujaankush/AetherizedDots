return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("core.utils").lazy_load "nvim-treesitter"
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require "plugins.configs.treesitter.context"
        end,
      },
      "kylechui/nvim-surround",
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require "plugins.configs.treesitter.autotag"
        end,
      },
    },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter.treesitter"
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "LspAttach",
    config = function()
      require "plugins.configs.treesitter.dapvirtual"
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
