local luasnip = require "luasnip"
-- local snippet = luasnip.snippet
-- local snipped_node = luasnip.snippet_node
-- local text_node = luasnip.text_node
-- local insert_node = luasnip.insert_node
-- local function_node = luasnip.function_node
-- local choice_node = luasnip.choice_node
-- local dynamic_node = luasnip.dynamic_node
-- local restore_node = luasnip.restore_node
-- local lamba = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local partial = require("luasnip.extras").partial
-- local match = require("luasnip.extras").match
-- local noempty = require("luasnip.extras").nonempty
-- local dynamic_lambda = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
-- local conds = require "luasnip.extras.conditions"
-- local conds_expand = require "luasnip.extras.conditions.expand"

luasnip.setup {
  history = true,
  -- Update more often, :h events for more info.
  update_events = "TextChanged,TextChangedI",
  -- Snippets aren't automatically removed if their text is deleted.
  -- `delete_check_events` determines on which events (:h events) a check for
  -- deleted snippets is performed.
  -- This can be especially useful when `history` is enabled.
  delete_check_events = "TextChanged",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "choiceNode", "Comment" } },
      },
    },
  },
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 200,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = true,
  -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
  -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
  store_selection_keys = "<Tab>",
  -- luasnip uses this function to get the currently active filetype. This
  -- is the (rather uninteresting) default, but it's possible to use
  -- eg. treesitter for getting the current filetype by setting ft_func to
  -- require("luasnip.extras.filetype_functions").from_cursor (requires
  -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
  -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
  ft_func = function()
    return vim.split(vim.bo.filetype, ".", true)
  end, -- Lazy loading
}

luasnip.add_snippets("all", require "plugins.configs.luasnip.all", {
  key = "all",
})

luasnip.add_snippets("java", require "plugins.configs.luasnip.java", {
  key = "java",
})

require("luasnip.loaders.from_vscode").lazy_load()

luasnip.filetype_extend("all", { "_" })

require("luasnip.loaders.from_snipmate").lazy_load()

vim.cmd [[command! LuaSnipEdit :lua require("plugins.luasnip.ft_edit")()]]
vim.cmd [[
	inoremap <silent> <C-K> <cmd>lua require("luasnip").expand()<Cr>
	inoremap <silent> <C-L> <cmd>lua require("luasnip").jump(1)<Cr>
	inoremap <silent> <C-J> <cmd>lua require("luasnip").jump(-1)<Cr>
	snoremap <silent> <C-L> <cmd>lua require("luasnip").jump(1)<Cr>
	snoremap <silent> <C-J> <cmd>lua require("luasnip").jump(-1)<Cr>
	imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : ''
	smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : ''
	imap <silent><expr> <C-S-E> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : ''
	smap <silent><expr> <C-S-E> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : ''
]]
