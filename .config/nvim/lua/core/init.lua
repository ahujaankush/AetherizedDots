local opt = vim.opt
local g = vim.g
local config = require("core.utils").load_config()

-------------------------------------- globals -----------------------------------------
g.nvchad_theme = config.ui.theme
g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
g.toggle_theme_icon = "   "
g.transparency = config.ui.transparency

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.wrap = false
opt.linebreak = true
opt.conceallevel = 2
opt.splitkeep = "screen"
vim.g.markdown_fenced_languages = {
    "ts=typescript",
}

opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.relativenumber = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.mousemoveevent = true

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = true

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
g.maplocalelader = "\\"

-- Neovide

vim.api.nvim_command "set guifont=JetBrainsMono\\ Nerd\\ Font,Cooper\\ Hewitt:h13"

g.neovide_refresh_rate = 144
g.neovide_transparency = 0.8
g.neovide_scale_factor = 1

g.neovide_no_idle = true
g.neovide_profiler = false
g.neovide_touch_deadzone = 1.0
g.neovide_input_use_logo = true
g.neovide_remember_window_size = true
g.neovide_touch_drag_timeout = 0.17

g.neovide_cursor_animation_length = 0.1
g.neovide_cursor_trail_length = 1
g.neovide_cursor_antialiasing = true
g.neovide_cursor_unfocused_outline_width = 0.125

g.neovide_cursor_vfx_mode = "railgun"
g.neovide_cursor_vfx_opacity = 85.0
g.neovide_cursor_vfx_particle_lifetime = 1
g.neovide_cursor_vfx_particle_density = 50.0
g.neovide_cursor_vfx_particle_speed = 5.0
g.neovide_cursor_vfx_particle_phase = 1.5
g.neovide_cursor_vfx_particle_curl = 1.0

g.neovide_padding_top = 20
g.neovide_padding_left = 20
g.neovide_padding_right = 20
g.neovide_padding_bottom = 20

g.instant_username = "aahuja"

-- lazygit
g.lazygit_floating_window_winblend = 0 -- transparency of floating window
g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

-- Use icons instead of letters in signcolumn
local signs = { Error = " ", Warn = " ", Info = "󰋼 ", Hint = "󰛩 " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config {
    virtual_text = {
        prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
}

-- g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
-- g.lazygit_config_file_path = "" -- custom config file path

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
local path_seperator = (is_windows and ";" or ":")
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. path_seperator .. vim.env.PATH
package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?.lua;"
-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- reload some chadrc options on-save
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = vim.tbl_map(
        vim.fs.normalize,
        vim.fn.glob(vim.fn.stdpath "config" .. "/lua/custom/**/*.lua", true, true, true)
    ),
    group = vim.api.nvim_create_augroup("ReloadNvChad", {}),

    callback = function(opts)
        local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
        local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
        local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")

        require("plenary.reload").reload_module "base46"
        require("plenary.reload").reload_module(module)
        require("plenary.reload").reload_module "custom.chadrc"

        config = require("core.utils").load_config()

        vim.g.nvchad_theme = config.ui.theme
        vim.g.transparency = config.ui.transparency

        -- statusline
        require("plenary.reload").reload_module("custom.ui.statusline." .. config.ui.statusline.theme)
        vim.opt.statusline = "%!v:lua.require('custom.ui.statusline." .. config.ui.statusline.theme .. "').run()"

        require("plenary.reload").reload_module "custom.ui.tabufline.modules"
        vim.opt.tabline = "%!v:lua.require('custom.ui.tabufline.modules').run()"

        require("base46").load_all_highlights()
    end,
})
