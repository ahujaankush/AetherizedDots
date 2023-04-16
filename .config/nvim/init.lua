-------------------------------------------------------------------------
--   ╭─────────────────────────────────────────────────────────────────╮
--   │ AetherVim - A NeoVim Config I _mainly_ use for Python and C(PP) │
--   ╰─────────────────────────────────────────────────────────────────╯
-------------------------------------------------------------------------
--   ╭─────────────────────╮
--   │ @version 2023-03-17 │
--   ╰─────────────────────╯
require "core"
require "core.options"

if vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1] then
  dofile(vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1])
end
require("core.utils").load_mappings()
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").lazy(lazypath)
end
vim.opt.rtp:prepend(lazypath)
require "plugins"
dofile(vim.g.base46_cache .. "defaults")
