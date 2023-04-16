local options = {
  ensure_installed = {
    ---------------------------
    -- NULL LS
    ---------------------------
    "prettierd",
    "stylua",
    "selene",
    -- clazy must be installed manually
    -- cppcheck must be installed manually
    -- astyle has to be installed manually
    -- markdown-toc has to be installed manually (npm)
    "gomodifytags",
    "staticcheck",
    "black",
    "isort",
    "pylint",
    "beautysh",
    "write-good",
    "shellcheck",

    ---------------------------
    -- LSPCONFIG
    ---------------------------
    "html-lsp",
    "css-lsp",
    "typescript-language-server",
    "deno",
    "clangd",
    "pyright",
    "asm-lsp",
    "gopls",
    "omnisharp",
    "json-lsp",
    "yaml-language-server",
    "vue-language-server",
    "r-languageserver",
    "arduino-language-server",
    "angular-language-server",
    "lua-language-server",
    "cmake-language-server",
    "sqlfluff",
  },

  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

return options
