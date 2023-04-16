local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
  pattern = "*.py",
  command = "set filetype=python",
})
