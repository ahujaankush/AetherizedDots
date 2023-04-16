local luasnip = require "luasnip"
local snippet = luasnip.snippet
local snipped_node = luasnip.snippet_node
local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
-- local function_node = luasnip.function_node
local choice_node = luasnip.choice_node
local dynamic_node = luasnip.dynamic_node
-- local restore_node = luasnip.restore_node
-- local lamba = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local partial = require("luasnip.extras").partial
-- local match = require("luasnip.extras").match
-- local noempty = require("luasnip.extras").nonempty
-- local dynamic_lambda = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require "luasnip.util.types"
-- local conds = require "luasnip.extras.conditions"
-- local conds_expand = require "luasnip.extras.conditions.expand"

-- Returns a snippet_node wrapped around an insertNode whose initial
-- text value is set to the current date in the desired format.
local date_input = function(fmt)
  return snipped_node(nil, insert_node(1, os.date(fmt)))
end

return {
  snippet("lorem", {
    text_node {
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
  }),
  snippet("copyright", {
    text_node { "Copyright (C) " },
    choice_node(1, {
      dynamic_node(1, date_input, {}, { user_args = { "%Y-%m-%d" } }),
      text_node "",
    }),
    choice_node(2, {
      text_node ' <a href="https://github.com/ahujaankush/">Ankush Ahuja<a/>',
      text_node " ",
    }),
  }),
}
