local present, null_ls = pcall(require, "null-ls")

if not present then
  null_ls.register {
    name = "more_actions",
    method = { require("null-ls").methods.CODE_ACTION },
    filetypes = { "_all" },
    generator = {
      fn = require("ts-node-action").available_actions,
    },
  }
end

return {}
