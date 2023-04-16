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

-- complicated function for dynamicNode.
local function java_mtd_doc(args, _, old_state)
  -- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
  -- Using a restoreNode instead is much easier.
  -- View this only as an example on how old_state functions.
  local nodes = {
    text_node { "/**", " * " },
    insert_node(1, "Function Description"),
    text_node { "", "" },
  }

  -- These will be merged with the snippet; that way, should the snippet be updated,
  -- some user input eg. text can be referred to in the new snippet.
  local param_nodes = {}

  if old_state then
    nodes[2] = insert_node(1, old_state.descr:get_text())
  end
  param_nodes.descr = nodes[2]

  -- At least one param.
  if string.find(args[2][1], ", ") then
    vim.list_extend(nodes, { text_node { " * ", "" } })
  end

  local insert = 2
  for i, arg in ipairs(vim.split(args[2][1], ", ", true)) do
    -- Get actual name parameter.
    arg = vim.split(arg, " ", true)[2]
    if arg then
      local inode
      -- if there was some text in this parameter, use it as static_text for this new snippet.
      if old_state and old_state[arg] then
        inode = insert_node(insert, old_state["arg" .. arg]:get_text())
      else
        inode = insert_node(insert)
      end
      vim.list_extend(nodes, { text_node { " * @param " .. arg .. " " }, inode, text_node { "", "" } })
      param_nodes["arg" .. arg] = inode

      insert = insert + 1
    end
  end

  if args[1][1] ~= "void" then
    local inode
    if old_state and old_state.ret then
      inode = insert_node(insert, old_state.ret:get_text())
    else
      inode = insert_node(insert)
    end

    vim.list_extend(nodes, { text_node { " * ", " * @return " }, inode, text_node { "", "" } })
    param_nodes.ret = inode
    insert = insert + 1
  end

  if vim.tbl_count(args[3]) ~= 1 then
    local exc = string.gsub(args[3][2], " throws ", "")
    local ins
    if old_state and old_state.ex then
      ins = insert_node(insert, old_state.ex:get_text())
    else
      ins = insert_node(insert)
    end
    vim.list_extend(nodes, { text_node { " * ", " * @throws " .. exc .. " " }, ins, text_node { "", "" } })
    param_nodes.ex = ins
    insert = insert + 1
  end

  vim.list_extend(nodes, { text_node { " */" } })

  local snip = snipped_node(nil, nodes)
  -- Error on attempting overwrite.
  snip.old_state = param_nodes
  return snip
end

return {
  snippet("cdoc", {
    text_node { "/**", " * " },
    -- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
    insert_node(1, ""),
    text_node { "", " *", " * @autor " },
    choice_node(2, {
      text_node '<a href="https://github.com/ahujaankush/">Ankush Ahuja<a/>',
      text_node "",
    }),
    text_node { "", " * @version " },
    choice_node(3, {
      text_node "1.0",
      text_node "",
    }),
    text_node { "", "**/", "" },
  }),
  snippet("mdoc", {
    text_node { "/**" },
    -- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
    insert_node(1, ""),
    text_node { "", "**/" },
  }),
  snippet("fn", {
    dynamic_node(6, java_mtd_doc, { 2, 4, 5 }),
    text_node { "", "" },
    choice_node(1, {
      text_node "public ",
      text_node "private ",
      text_node "public static ",
      text_node "private static ",
    }),
    choice_node(2, {
      text_node "void",
      text_node "String",
      text_node "char",
      text_node "int",
      text_node "double",
      text_node "boolean",
      insert_node(nil, ""),
    }),
    text_node " ",
    insert_node(3, "mtd"),
    text_node "(",
    insert_node(4),
    text_node ")",
    choice_node(5, {
      text_node "",
      snipped_node(nil, {
        text_node { "", " throws " },
        insert_node(1),
      }),
    }),
    text_node { " {", "\t" },
    insert_node(0),
    text_node { "", "}" },
  }),
  snippet("print", {
    text_node "System.",
    -- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
    choice_node(1, {
      text_node "out.",
      text_node "err.",
    }),
    choice_node(2, {
      text_node "print",
      text_node "println",
    }),
    text_node "(",
    insert_node(3),
    text_node ");",
  }),
  snippet("sout", {
    text_node "System.out.print",
    text_node "(",
    insert_node(1),
    text_node ");",
  }),
  snippet("serr", {
    text_node "System.err.print",
    text_node "(",
    insert_node(1),
    text_node ");",
  }),
}
