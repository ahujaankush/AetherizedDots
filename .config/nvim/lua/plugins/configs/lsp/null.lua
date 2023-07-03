local null = require "null-ls"

local b = null.builtins

local sources = {
  -- webdev stuff
  require "typescript.extensions.null-ls.code-actions",
  b.code_actions.eslint_d,
  b.formatting.prettier.with {
    disabled_filetypes = { "markdown", "markdown.mdx" },
  },
  b.formatting.tidy,
  b.diagnostics.djlint,
  b.formatting.djlint,
  -- css/sass
  b.formatting.stylelint,
  -- json
  b.diagnostics.cfn_lint, -- AWS CloudFormation Resource Specification
  b.formatting.fixjson,
  -- python
  b.diagnostics.ruff,
  -- c/cpp
  b.formatting.astyle.with { filetypes = { "arduino", "c", "cpp", "cs" } }, -- formatting cs
  b.diagnostics.cpplint,
  -- cs
  -- java
  -- formatting cs
  -- rust
  -- asm
  b.formatting.asmfmt,
  -- r
  b.formatting.format_r,
  -- lua
  b.diagnostics.selene,
  b.formatting.stylua,
  -- vimscript
  b.diagnostics.vulture,
  -- markdown
  b.formatting.markdownlint,
  b.formatting.markdown_toc,
}

null.setup {
  debug = false,
  sources = sources,
}
