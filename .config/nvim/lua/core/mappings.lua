-- n, v, i, t = mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "move left" },
    ["<C-l>"] = { "<Right>", "move right" },
    ["<C-j>"] = { "<Down>", "move down" },
    ["<C-k>"] = { "<Up>", "move up" },
  },

  n = {
  ["<A-c>"] = {
      function()
        require("core.utils").close_nvim()
      end,
      "close nvim",
    },

    ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },

    -- resize vertical splits
    ["v["] = { "<cmd> vertical resize +10 <CR>", "increase vertical split" },
    ["v]"] = { "<cmd> vertical resize -10 <CR>", "decrease vertical split" },
    -- resize horizontal splits
    ["w["] = { "<cmd> resize +3 <CR>", "increase horizontal split" },
    ["w]"] = { "<cmd> resize -3 <CR>", "decrease horizontal split" },
    -- sav:
    ["<C-s>"] = { "<cmd> w <CR>", "save file" },
    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

    ["<leader>ts"] = {
      function()
        require("base46").toggle_theme()
      end,
      "toggle theme",
    },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

    -- new buffer
    ["<leader>bn"] = { "<cmd> enew <CR>", "new buffer" },
    ["<leader>tn"] = { "<cmd> tab new <CR>", "new tab" },
    ["<leader>tq"] = { "<cmd> tab new <CR>", "close tab" },
    ["<C-t>"] = { "<cmd> tabNext <CR>", "tab next" },
    ["<S-t>"] = { "<cmd> tabprevious <CR>", "tab prev" },
    ["<leader>t."] = { "<cmd> tabmove +1 <CR>", "tab move +1" },
    ["<leader>t,"] = { "<cmd> tabmove -1 <CR>", "tab move -1" },
  },

  t = { ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move left", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move down", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "dont copy replaced text", opts = { silent = true } },
  },
}

M.null_ls = {
  plugin = true,

  n = {
    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format { timeout_ms = 2000 }
      end,
      "format file",
    },
  },
}

M.truezen = {
  plugin = true,
  n = {
    ["<leader>zn"] = {
      "<cmd> TZNarrow <CR>",
      "True-Zen narrow",
    },
    ["<leader>zf"] = {
      "<cmd> TZFocus <CR>",
      "True-Zen focus",
    },
    ["<leader>zm"] = {
      "<cmd> TZMinimalist <CR>",
      "True-Zen minimalist",
    },
    ["<leader>za"] = {
      "<cmd> TZAtaraxis <CR>",
      "True-Zen ataraxis",
    },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<C-Tab>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "goto next buffer",
    },

    ["<S-Tab>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "goto prev buffer",
    },

    -- pick buffers via numbers
    ["<Bslash>"] = { "<cmd> TbufPick <CR>", "Pick buffer" },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    },
  },
}

M.node_action = {
  plugin = true,

  n = {
    ["na"] = {
      function()
        require("ts-node-action").node_action()
      end,
      "Treesitter node action",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.neogen = {
  plugin = true,
  n = {
    ["nc"] = {
      function()
        require("neogen").generate()
      end,
      "Neogen generate annotation",
    },
  },
}

M.trouble = {
  plugin = true,

  n = {
    ["<leader>tt"] = {
      "<cmd>TroubleToggle<CR>",
      "toggle trouble",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "list workspace folders",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>;"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },

    -- collapse nvim tree
    ["<leader>tc"] = { "<cmd> NvimTreeCollapse <CR>", "collapse nvimtree" },
  },
}

M.saga = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>ca"] = { "<cmd> Lspsaga code_action <CR>", "code navigation" },
    ["<leader>,"] = { "<cmd> Lspsaga outline <CR>", "code navigation" },
    ["<F2>"] = { "<cmd> Lspsaga rename <CR>", "rename" },
    ["<leader>ra"] = { "<cmd> Lspsaga rename <CR>", "rename" },
    ["<leader>gd"] = { "<cmd> Lspsaga goto_definition <CR>", "goto definition" },
    ["<leader>gD"] = { "<cmd> Lspsaga goto_type_definition <CR>", "goto type definition" },
    ["<leader>pd"] = { "<cmd> Lspsaga peek_definition <CR>", "peek definition" },
    ["<leader>pD"] = { "<cmd> Lspsaga peek_type_definition <CR>", "peek type definition" },
    ["<leader>h"] = { "<cmd> Lspsaga hover_doc <CR>", "hover doc" },
    ["<leader>lp"] = { "<cmd> Lspsaga lsp_finder <CR>", "lsp finder" },
    ["<leader>ld"] = { "<cmd> Lspsaga show_line_diagnostics  <CR>", "line diagnostics" },
    ["<leader>lb"] = { "<cmd> Lspsaga show_buf_diagnostics <CR>", "buffer diagnostics" },
    ["<leader>lc"] = { "<cmd> Lspsaga show_cursor_diagnostics <CR>", "cursor diagnostics" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },

    -- new

    ["<leader>ht"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "new horizontal term",
    },

    ["<leader>vt"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "new vertical term",
    },
  },
}

M.telescope = {
  plugin = true,
  v = {
    ["<leader>rr"] = {
      function()
        require("telescope").extensions.refactoring.refactors()
      end,
      "refactoring",
    },
  },
  n = {
    -- telescope projects
    ["<leader>fp"] = { "<cmd> Telescope projects <CR>", "open projects" },
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

M.refactoring = {
  v = {
    ["<leader>re"] = {
      function()
        require("refactoring").refactor "Extract Function"
      end,
      "extract function",
    },
    ["<leader>rf"] = {
      function()
        require("refactoring").refactor "Extract Function To File"
      end,
      "extract function to file",
    },
    ["<leader>rv"] = {
      function()
        require("refactoring").refactor "Extract Variable"
      end,
      "extract variable",
    },
    ["<leader>ri"] = {
      function()
        require("refactoring").refactor "Inline Variable"
      end,
      "refactor inline var",
    },
  },
  n = {
    ["<leader>rb"] = {
      function()
        require("refactoring").refactor "Extract Block"
      end,
      "extract block",
    },
    ["<leader>rf"] = {
      function()
        require("refactoring").refactor "Extract Block To File"
      end,
      "extract block to file",
    },
    ["<leader>ri"] = {
      function()
        require("refactoring").refactor "Inline Variable"
      end,
      "refactor inline var",
    },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "which-key query lookup",
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current_context",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

return M
