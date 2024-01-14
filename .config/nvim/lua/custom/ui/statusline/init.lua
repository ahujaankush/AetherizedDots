local config = require("core.utils").load_config().ui
vim.opt.statusline = "%!v:lua.require('custom.ui.statusline." .. config.statusline.theme .. "').run()"

vim.api.nvim_create_autocmd("User", {
  pattern = "LspProgressUpdate",
  callback = function()
    vim.cmd "redrawstatus"
  end,
})
