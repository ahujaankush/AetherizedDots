local M = {}
M.ui = {
  ------------------------------- base46 -------------------------------------
  hl_add = {
    -- LSPSAGA
    -- general
    SagaBorder = {
      fg = "purple",
    },
    SagaBeacon = {
      bg = "grey",
    },
    -- code action
    ActionPreviewBorder = {
      link = "vibrant_green",
    },
    CodeActionBorder = {
      link = "SagaBorder",
    },
    --finder spinner
    FinderBorder = {
      link = "SagaBorder",
    },
    FinderPreviewBorder = {
      link = "SagaBorder",
    },
    -- definition
    DefinitionBorder = {
      fg = "cyan",
    },
    -- hover
    HoverBorder = {
      fg = "green",
    },
    -- rename
    RenameBorder = {
      fg = "orange",
    },
    -- diagnostic
    DiagnosticBorder = {
      fg = "red",
    },
    -- Call Hierachry
    CallHierarchyBorder = {
      link = "SagaBorder",
    },
    OutlineIndent = { link = "DefinitionBorder" },
    OutlinePreviewBorder = { fg = "red" },
    OutlinePreviewNormal = { fg = "white" },
  },
  hl_override = {
    TelescopePromptPrefix = {
      fg = "purple",
    },
    TelescopePromptTitle = {
      bg = "purple",
    },
    CursorLine = {
      bg = "black2",
    },
    Comment = {
      italic = true,
    },

    NvDashAscii = {
      fg = "red",
      bg = "bg",
    },
    St_pos_sep = {
      fg = "purple",
    },

    St_pos_icon = {
      bg = "purple",
    },

    St_pos_text = {
      fg = "purple",
    },
  },
  changed_themes = {},
  theme_toggle = { "aether", "one_light" },
  theme = "aether", -- default theme
  transparency = false,

  -- cmp themeing
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },

  ------------------------------- nvchad_ui modules -----------------------------
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    overriden_modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    lazyload = true,
    overriden_modules = nil,
  },

  -- nvdash (dashboard)
  nvdash = {
    load_on_startup = true,

    header = {
      "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
      "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
      "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
      "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
      "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
      "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
      "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
      " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
      " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
      "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
      "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    },

    buttons = {
      { "󰘔  Projects", "Spc f p", "Telescope projects" },
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc b m", "Telescope marks" },
      { "  Themes", "Spc t f", "Telescope themes" },
    },
  },

  cheatsheet = {
    theme = "grid", -- simple/grid
  },
}

M.plugins = "" -- path i.e "custom.plugins" -> custom/plugins.lua only and not custom/plugins/init.lua!!!!

M.lazy_nvim = {} -- config for lazy.nvim startup options

-- these are default mappings, check core.mappings for table structure
M.mappings = require "core.mappings"

return M
