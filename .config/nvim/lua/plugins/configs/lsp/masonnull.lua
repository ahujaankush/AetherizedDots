local masonnull = require("mason-null-ls")

local options = {
  ensure_installed = { "stylua", "jq" },
  automatic_installation = true,
  automatic_setup = true
}

masonnull.setup(options)
