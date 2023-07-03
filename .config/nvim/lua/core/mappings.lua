-- n, v, i, t = mode names

local M = {}
M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<Esc>"] = { ":noh <CR>", "Clear highlights" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- resize vertical splits
    ["v["] = { "<cmd> vertical resize +10 <CR>", "increase vertical split" },
    ["v]"] = { "<cmd> vertical resize -10 <CR>", "decrease vertical split" },
    -- resize horizontal splits
    ["w["] = { "<cmd> resize +10 <CR>", "increase horizontal split" },
    ["w]"] = { "<cmd> resize -10 <CR>", "decrease horizontal split" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- new buffer
    ["<leader>bn"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
    -- tabs
    ["<leader>tn"] = { "<cmd> tab new <CR>", "new tab" },
    ["<leader>tq"] = { "<cmd> tab close <CR>", "close tab" },
    ["<C-t>"] = { "<cmd> tabnext <CR>", "tab next" },
    ["<S-t>"] = { "<cmd> tabprevious <CR>", "tab prev" },
    ["<leader>t."] = { "<cmd> tabmove +1 <CR>", "tab move +1" },
    ["<leader>t,"] = { "<cmd> tabmove -1 <CR>", "tab move -1" },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
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

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<tab>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}

M.bufferline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<tab>"] = {
      "<cmd> BufferLineCycleNext <CR>",
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      "<cmd> BufferLineCyclePrev <CR>",
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>xx"] = {
      function()
        require("bufdelete").bufdelete(0, true)
      end,
      "Close buffer",
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
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.neogen = {
  plugin = true,
  n = {
    ["<leader>,"] = {
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
    -- ["gD"] = {
    --   function()
    --     vim.lsp.buf.declaration()
    --   end,
    --   "LSP declaration",
    -- },
    --
    -- ["gd"] = {
    --   function()
    --     vim.lsp.buf.definition()
    --   end,
    --   "LSP definition",
    -- },

    -- ["K"] = {
    --   function()
    --     vim.lsp.buf.hover()
    --   end,
    --   "LSP hover",
    -- },

    -- ["gi"] = {
    --   function()
    --     vim.lsp.buf.implementation()
    --   end,
    --   "LSP implementation",
    -- },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    -- ["<leader>D"] = {
    --   function()
    --     vim.lsp.buf.type_definition()
    --   end,
    --   "LSP definition type",
    -- },

    -- ["<leader>ra"] = {
    --   function()
    --     require("nvchad_ui.renamer").open()
    --   end,
    --   "LSP rename",
    -- },

    -- ["gr"] = {
    --   function()
    --     vim.lsp.buf.references()
    --   end,
    --   "LSP references",
    -- },

    -- ["<leader>f"] = {
    --   function()
    --     vim.diagnostic.open_float { border = "rounded" }
    --   end,
    --   "Floating diagnostic",
    -- },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    -- ["<leader>q"] = {
    --   function()
    --     vim.diagnostic.setloclist()
    --   end,
    --   "Diagnostic setloclist",
    -- },

    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },
}

M.dial = {
  plugin = true,

  n = {
    -- inc
    ["<leader>di"] = {
      "<cmd> DialIncrement <CR>",
      "Increment (dial) in normal",
    },
    -- dec
    ["<leader>du"] = {
      "<cmd> DialDecrement <CR>",
      "Decrement (dial) in normal",
    },
  },
  v = {
    -- inc
    ["<leader>di"] = {
      "<cmd>'<,'> DialIncrement <CR>",
      "Increment (dial) in visual",
    },
    -- dec
    ["<leader>du"] = {
      "<cmd>'<,'> DialDecrement <CR>",
      "Decrement (dial) in visual",
    },
  },
}

M.navbuddy = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>."] = { "<cmd> Navbuddy <CR>", "Focus navbuddy" },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>;"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

M.saga = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>ca"] = { "<cmd> Lspsaga code_action <CR>", "code action" },
    ["<leader>q"] = { "<cmd> Lspsaga outline <CR>", "code navigation" },
    ["<leader>ra"] = { "<cmd> Lspsaga rename <CR>", "rename" },
    ["<leader>gd"] = { "<cmd> Lspsaga goto_definition <CR>", "goto definition" },
    ["<leader>gD"] = { "<cmd> Lspsaga goto_type_definition <CR>", "goto type definition" },
    ["<leader>pd"] = { "<cmd> Lspsaga peek_definition <CR>", "peek definition" },
    ["<leader>pD"] = { "<cmd> Lspsaga peek_type_definition <CR>", "peek type definition" },
    ["<leader>hd"] = { "<cmd> Lspsaga hover_doc <CR>", "hover doc" },
    ["<leader>lp"] = { "<cmd> Lspsaga lsp_finder <CR>", "lsp finder" },
    ["<leader>ld"] = { "<cmd> Lspsaga show_line_diagnostics  <CR>", "line diagnostics" },
    ["<leader>bd"] = { "<cmd> Lspsaga show_buf_diagnostics <CR>", "buffer diagnostics" },
    ["<leader>cd"] = { "<cmd> Lspsaga show_cursor_diagnostics <CR>", "cursor diagnostics" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    ["<leader>fu"] = { "<CMD> Telescope undo <CR>", "undo tree" },
    -- tabs
    ["<leader>ft"] = { "<CMD> Telescope telescope-tabs list_tabs <CR>", "list tabs" },
    -- projects
    ["<leader>fp"] = { "<CMD> Telescope projects <CR>", "open projects" },
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

M.textcase = {
  plugin = true,
  n = {
    ["<leader>fe"] = { "<CMD> TextCaseOpenTelescope <CR>", "Textcase telescope" },
  },
  v = {
    ["<leader>fe"] = { "<CMD> TextCaseOpenTelescope <CR>", "Textcase telescope" },
  },
}

M.refactoring = {
  plugin = true,
  n = {
    ["<leader>fr"] = {
      function()
        require("telescope").extensions.refactoring.refactors()
      end,
      "refactoring",
    },
  },
  v = {
    -- refactoring
    ["<leader>fr"] = {
      function()
        require("telescope").extensions.refactoring.refactors()
      end,
      "refactoring",
    },
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
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },

    -- new
    ["<leader>ht"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<leader>vt"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },
  },
}

M.scrollbar = {
  plugin = true,

  n = {
    ["<leader>st"] = {
      "<cmd> ScrollbarToggle <CR>",
      "Toggle scrollbar",
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
      "Which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.legendary = {
  plugin = true,

  n = {
    ["<C-S-P>"] = {
      function()
        vim.cmd "Legendary"
      end,
      "Legendary search",
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
      "Jump to current context",
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
