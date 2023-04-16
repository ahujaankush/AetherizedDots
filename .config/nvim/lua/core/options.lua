local opt = vim.opt
local g = vim.g
local config = require("core.utils").load_config()

g.nvchad_theme = config.ui.theme
g.base46_cache = vim.fn.stdpath "cache" .. "/nvchad/base46/"
g.toggle_theme_icon = "   "
g.transparency = config.ui.transparency
g.lsp_signs = {
  -- icons / text used for a diagnostic
  error = "",
  warning = "",
  hint = "ﯧ",
  information = "",
  other = "﫠",
}

opt.laststatus = 3 -- global statusline
opt.showmode = false

-- suggestions height
opt.pumheight = 10

opt.relativenumber = true

opt.clipboard = "unnamedplus"
opt.cursorline = true
-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " "

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
