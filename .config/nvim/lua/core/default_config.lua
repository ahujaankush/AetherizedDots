local M = {}

M.ui = {
  ------------------------------- base46 -------------------------------------
  -- hl = highlights
  hl_add = vim.tbl_deep_extend(
    "keep",
    require "custom.hl.alpha",
    require "custom.hl.devicons",
    require "custom.hl.lspsaga",
    require "custom.hl.neotest",
    require "custom.hl.neotree",
    require "custom.hl.nui",
    require "custom.hl.scrollbar",
    {
      Directory = {
        fg = "nord_blue",
      },
      -- cursorword
      MiniCursorword = { link = "CursorLine" },

      TreesitterContext = { bg = "black" },
      -- paint.nvim
      DocKeyword = {
        fg = "nord_blue",
      },

      ColorHLBlack = { bg = "black", fg = "white" },
      ColorHLGrey = { bg = "grey", fg = "white" },
      ColorHLOrange = { fg = "orange" },
      ColorHLRed = { fg = "red" },
      ColorHLPink = { fg = "pink" },
      ColorHLPurple = { fg = "purple" },
      ColorHLBlue = { fg = "nord_blue" },
      ColorHLCyan = { fg = "cyan" },
      ColorHLGreen = { fg = "green" },
      ColorHLYellow = { fg = "yellow" },
      ColorHLWhite = { fg = "white" },
      BufferLineBackground = { bg = "black2" },
    }
  ),
  hl_override = vim.tbl_deep_extend("keep", require "custom.hl.telescope", {
    FloatBorder = {
      fg = "green",
    },

    CursorLine = {
      bg = "one_bg",
    },
    Comment = {
      fg = "light_grey",
      italic = true,
    },

    ["@text.emphasis"] = { italic = true, bold = false, fg = "white" },
    ["@text.strong"] = { italic = false, bold = true, fg = "white" },
    ["NonText"] = { fg = "pink" },
  }),
  changed_themes = {},
  theme_toggle = { "onedark", "one_light" },
  theme = "onedark", -- default theme
  transparency = false,
  lsp_semantic_tokens = true, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens

  -- https://github.com/NvChad/base46/tree/v2.0/lua/base46/extended_integrations
  extended_integrations = { "notify", "alpha", "trouble", "dap", "rainbow_delimiters" }, -- these aren't compiled by default, ex: "alpha", "notify"

  -- cmp themeing
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },

  telescope = { style = "borderless" }, -- borderless / bordered

  ------------------------------- nvchad_ui modules -----------------------------
  statusline = {
    theme = "minimal", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "block",
  },
  icons = {
    lspkind = require "custom.icons.lspkind",
    devicons = require "custom.icons.devicons",
  },
}

M.plugins = ""

M.lazy_nvim = require "plugins.configs.lazy_nvim" -- config for lazy.nvim startup options

M.mappings = {}

return M
