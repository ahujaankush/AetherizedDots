dofile(vim.g.base46_cache .. "syntax")

local options = {
  ensure_installed = require("core.servers").ts,

  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        ["<leader>tabo"] = "@block.outer",
        ["<leader>tabi"] = "@block.inner",
        ["<leader>taco"] = "@class.outer",
        ["<leader>taci"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["<leader>tals"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "<c-v>", -- blockwise
      },
      include_surrounding_whitespace = true,
    },
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },

  rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    disable = {},
    -- Which query to use for finding delimiters
    query = "rainbow-parens",
    -- Highlight the entire buffer all at once
    strategy = require("ts-rainbow").strategy.global,
  },
}
require("nvim-treesitter.configs").setup(options)
