local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  require "typescript.extensions.null-ls.code-actions",
  b.formatting.prettier,
  b.diagnostics.tidy,

  -- Lua
  b.formatting.stylua,
  b.diagnostics.luacheck,

  -- c-family
  b.formatting.clang_format.with { filetypes = { "c", "cpp", "cs" } },
  b.diagnostics.cppcheck, -- only works for c(pp)
  b.formatting.astyle.with { filetype = { "arduino" } }, -- only for arduino
  -- golang
  b.formatting.gofmt,
  b.code_actions.gomodifytags,
  b.diagnostics.staticcheck,

  -- Shows the first available definition for the current word under the cursor.
  b.hover.dictionary,
  -- Shows the value for the current environment variable under the cursor.
  b.hover.printenv.with { filetypes = { "sh", "bash", "dosbatch", "ps1" } },

  -- formatting and linting xml
  b.formatting.xmllint,

  -- python
  b.formatting.black,
  b.formatting.isort, -- organize imports
  b.diagnostics.mypy,

  -- bash, csh, ksh, sh and zsh
  b.formatting.beautysh,

  -- SQL
  b.diagnostics.sqlfluff,

  -- markdown
  b.formatting.markdown_toc.with { filetype = { "markdown", "md" } },
  b.diagnostics.write_good.with { filetype = { "markdown", "md", "txt" }},
}

null_ls.setup {
  debug = false,
  sources = sources,
}
