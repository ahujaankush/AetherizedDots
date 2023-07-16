-- Lsp server
local lsp = {
  -- "emmet_ls",
  "html",
  "cssls",
  -- "tsserver", -- replaced with typescript.nvim
  -- "clangd", -- replaced with clangd_extensions
  "eslint",
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
  "taplo",
  "marksman"
}

-- null ls (for manual installation -> provide function)
local null = {}

local ts = {
  "comment",
  "regex",
  "toml",
  "bash",
  "vim",
  "lua",
  "html",
  "css",
  "json",
  "javascript",
  "typescript",
  "tsx",
  "python",
  "java",
  "c",
  "cpp",
  "c_sharp",
  "go",
  "markdown",
  "markdown_inline",
  "norg",
  "vue",
  "julia",
  "arduino",
  "http",
  "json",
  "query",
}

return {
  ["lsp"] = lsp,
  ["null"] = null,
  ["ts"] = ts,
}
