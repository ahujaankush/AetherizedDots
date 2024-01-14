dofile(vim.g.base46_cache .. "dap")

vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DapBreakpointCondition" })
vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped" })
