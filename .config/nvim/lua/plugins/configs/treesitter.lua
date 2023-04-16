local options = {
  ensure_installed = {
    "bash",
    "vim",
    "lua",
    "html",
    "css",
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
  },
  indent = {
    enable = true,
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

return options
