local refactoring = require "refactoring"
local options = {
  prompt_func_return_type = {
    go = false,
    java = true,

    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
  prompt_func_param_type = {
    go = true,
    java = true,

    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
  printf_statements = {},
  print_var_statements = {},
}

refactoring.setup(options)
