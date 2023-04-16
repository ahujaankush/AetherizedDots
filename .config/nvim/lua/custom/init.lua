local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Format on file save
-- autocmd("BufWritePre", {
--   pattern = "*",
--   command = "lua vim.lsp.buf.format()",
-- })
