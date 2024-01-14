local neotest = require "neotest"
local options = {
  status = { virtual_text = true },
  output = { open_on_run = true },
  quickfix = {
    open = function()
      vim.cmd "Trouble quickfix"
    end,
  },
  adapters = {
    require "neotest-jest" {
      jestCommand = "npm run test:api --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    },
  },
}

local neotest_ns = vim.api.nvim_create_namespace "neotest"
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      -- Replace newline and tab characters with space for more compact diagnostics
      local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)

neotest.setup(options)
