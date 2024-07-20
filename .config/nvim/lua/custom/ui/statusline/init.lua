vim.opt.statusline = "%!v:lua.require('custom.ui.statusline.minimal').run()"

vim.api.nvim_create_autocmd("User", {
  pattern = "LspProgressUpdate",
  callback = function()
    vim.cmd "redrawstatus"
  end,
})
