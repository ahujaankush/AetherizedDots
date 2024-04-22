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
  -- "typos_lsp"
}

local ts = {
  "comment",
  "luadoc",
  "printf",
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
  ["ts"] = ts,
  ["mason"] = mason,
}
