-- Lsp server
local lsp = {
  -- Web
  "volar",
  "angularls",
  "html",
  "emmet_ls",
  "cssls",
  "denols",
  "eslint",
  -- Low Level
  "asm_lsp",
  "clangd",
  "lua_ls",
  "cmake",
  -- Python
  "pyright",
  -- Go/C#
  "gopls",
  "omnisharp",
  -- Utils
  "jsonls",
  "yamlls",
  "taplo",
  "marksman",
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
  "org",
}

local mason = {}

return {
  ["lsp"] = lsp,
  ["null"] = null,
  ["ts"] = ts,
  ["mason"] = mason,
}
