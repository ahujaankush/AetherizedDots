local mason_lsp = require("mason-lspconfig")

mason_lsp.setup({
  ensure_installed = require("core.servers").lsp,
  automatic_installation = true,
})
