local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  require "typescript.extensions.null-ls.code-actions",
  b.formatting.prettier, -- so prettier works only on these filetypes
  b.formatting.djlint,
  -- Lua
  b.formatting.stylua,
  b.diagnostics.selene,

  -- c-family
  -- b.formatting.clang_format.with { filetypes = { "c", "cpp", "cs" } },
  b.diagnostics.clang_check,
  b.diagnostics.clazy,
  b.diagnostics.cppcheck,
  b.formatting.astyle.with { filetype = { "arduino" } },
  -- golang
  b.formatting.gofmt,
  b.code_actions.gomodifytags,
  b.diagnostics.staticcheck,

  -- Shows the first available definition for the current word under the cursor.
  b.hover.dictionary,
  -- Shows the value for the current environment variable under the cursor.
  b.hover.printenv,

  -- formatting and linting xml
  b.formatting.xmllint,

  -- python
  b.formatting.black,
  b.formatting.isort,
  b.diagnostics.pylint,

  -- bash, csh, ksh, sh and zsh
  b.formatting.beautysh,
  b.code_actions.shellcheck,

  -- SQL
  b.diagnostics.sqlfluff,

  -- markdown
  b.formatting.markdown_toc,
  b.diagnostics.write_good,
}

null_ls.setup {
  debug = false,
  sources = sources,
}
