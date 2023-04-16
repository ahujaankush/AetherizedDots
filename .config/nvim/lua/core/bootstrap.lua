local M = {}

M.lazy = function(install_path)
  print "Bootstrapping lazy.nvim .."

  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    install_path,
  }

  vim.opt.rtp:prepend(install_path)

  -- install plugins + compile their configs
  require "plugins"
  require("lazy").load { plugins = { "nvim-treesitter" } }

  -- install binaries from mason.nvim & tsparsers on LazySync
  vim.schedule(function()
    vim.cmd "silent! MasonInstallAll"
    -- print success message
  end, 0)
end

return M
