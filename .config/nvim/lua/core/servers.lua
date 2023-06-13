-- Lsp server
local lsp = {
  "emmet_ls",
  "cssls",
  -- "tsserver", -- replaced with typescript.nvim
  "denols",
  -- "clangd", -- replaced with clangd_extensions
  "pyright",
  "asm_lsp",
  "gopls",
  "omnisharp",
  "jsonls",
  "yamlls",
  "volar",
  "r_language_server",
  "arduino_language_server", -- further cfg significant , see lspconfig server configs doc
  "angularls",
  "lua_ls",
  "cmake",
}


-- null ls (for manual installation -> provide function)
local null = {
}

return {
  ["lsp"] = lsp,
  ["null"] = null
}
