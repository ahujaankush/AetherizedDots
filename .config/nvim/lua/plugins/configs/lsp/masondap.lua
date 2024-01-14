local masondap = require "mason-nvim-dap"

local options = {
  ensure_installed = require("core.servers").mason,
  automatic_installation = true,

  handlers = {
    function(config)
      require("mason-nvim-dap").default_setup(config)
    end,
  },
}

masondap.setup(options)
