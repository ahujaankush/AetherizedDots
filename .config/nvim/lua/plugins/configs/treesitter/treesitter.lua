dofile(vim.g.base46_cache .. "syntax")

local options = {
  ensure_installed = require("core.servers").ts,
  auto_install = true,
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

  additional_vim_regex_highlighting = { "org" },

  indent = { enable = true },
 }
require("nvim-treesitter.configs").setup(options)
