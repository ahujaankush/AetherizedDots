-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {
  "nvim-lua/plenary.nvim",
  {
    "jghauser/mkdir.nvim",
    event = "BufEnter",
  },
  {
    "tpope/vim-repeat",
    event = "InsertEnter",
  },
  {
    "johmsalas/text-case.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require "plugins.configs.code.textcase"
    end,
  },
  -- autosave
  {
    "tmillr/sos.nvim",
    event = "BufLeave",
    config = function()
      require "plugins.configs.code.sos"
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "BufModifiedSet",
    config = function()
      require "plugins.configs.code.neoscroll"
    end,
  },
  -- nvchad plugins
  { "NvChad/extensions", branch = "v2.0" },
  {
    "NvChad/base46",
    branch = "v2.0",
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  -- nvchad bufferline is disabled
  {
    "NvChad/ui",
    branch = "v2.0",
    lazy = false,
    config = function()
      require "nvchad_ui"
    end,
  },
  {
    "mawkler/modicator.nvim",
    event = "BufRead",
    dependencies = "NvChad/base46",
    config = function()
      require "plugins.configs.interface.modicator"
    end,
  },
  -- Zen Mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require "plugins.configs.interface.zenmode"
    end,
  },
  -- buffer + tab line
  {
    "akinsho/bufferline.nvim",
    event = "BufRead",
    dependencies = {
      "famiu/bufdelete.nvim",
      {
        "tiagovla/scope.nvim",
        config = function()
          require("scope").setup { restore_state = false }
        end,
      },
    },
    init = function()
      require("core.utils").load_mappings "bufferline"
    end,
    config = function()
      require "plugins.configs.interface.bufferline"
    end,
  },

  {
    "NvChad/nvterm",
    init = function()
      require("core.utils").load_mappings "nvterm"
    end,
    config = function(_, opts)
      require "base46.term"
      require("nvterm").setup(opts)
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    init = require("core.utils").load_mappings "saga",
    config = function()
      require "plugins.configs.interface.lspsaga"
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },

  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "romgrk/fzy-lua-native",
        build = "make",
      },
    },
    config = function()
      require "plugins.configs.interface.wilder"
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "UIenter",
    config = function()
      require "plugins.configs.interface.notify"
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    event = "BufRead",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require "plugins.configs.code.colorizer"
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    cmd = { "CccConvert", "CccPick" },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require "plugins.configs.code.ccc"
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require("nvchad_ui.icons").devicons }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    init = function()
      require("core.utils").load_mappings "blankline"
    end,
    config = function()
      require "plugins.configs.interface.blankline"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("core.utils").lazy_load "nvim-treesitter"
    end,
    dependencies = {
      "HiPhish/nvim-ts-rainbow2",
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require "plugins.configs.treesitter.context"
        end,
      },
      {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
          require "plugins.configs.code.surround"
        end,
      },
    },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter.treesitter"
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "LspAttach",
    config = function()
      require "plugins.configs.treesitter.dapvirtua"
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    config = function()
      require "plugins.configs.code.gitsigns"
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function()
      require "plugins.configs.lsp.mason"
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require "plugins.configs.lsp.masonlsp"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- format & linting
        {
          "jay-babu/mason-null-ls.nvim",
          dependencies = {
            "williamboman/mason.nvim",
            {
              "jose-elias-alvarez/null-ls.nvim",
              init = require("core.utils").load_mappings "null_ls",
              config = function()
                require "plugins.configs.lsp.null"
              end,
            },
          },
          config = function()
            require "plugins.configs.lsp.masonnull"
          end,
        },
        "williamboman/mason-lspconfig.nvim",
      },
    },
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
    end,
    config = function()
      require "plugins.configs.lsp.lspconfig"
    end,
  },
  -- language specific plugins
  -- typescript (lsp)
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    config = function()
      require "plugins.configs.lsp.lang.typescript"
    end,
  },
  -- web dev general
  {
    "ray-x/web-tools.nvim",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "jinja.html",
      "htmldjango",
      "css",
      "scss",
    },
    dependencies = {
      "ray-x/guihua.lua",
    },
    build = "npm install -g browser-sync",
    config = function()
      require "plugins.configs.code.webtools"
    end,
  },
  -- json schemas
  "b0o/schemastore.nvim",
  -- Rest client
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    config = function()
      require "plugins.configs.code.rest"
    end,
  },
  -- c/cpp (lsp)
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    build = "npm -g i @vscode/codicons",
    config = function()
      require "plugins.configs.lsp.lang.clangd"
    end,
  },
  -- jdtls
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    build = ":MasonInstall jdtls",
  },
  -- lua
  {
    "folke/neodev.nvim", -- neovim development
    ft = { "lua" },
    config = function()
      require "plugins.configs.lsp.neodev"
    end,
  },
  -- Rofi
  {
    "Fymyte/rasi.vim",
    ft = "rasi",
  },
  -- EWW (yuck)
  {
    "elkowar/yuck.vim",
    ft = "yuck",
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
        end,
      },
    },
  },
  -- Note taking -> Neorg
  {
    "nvim-neorg/neorg",
    cmd = { "Neorg" },
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "plugins.configs.notes.neorg"
    end,
  },
  -- Markdown
  {
    "toppair/peek.nvim", -- markdown preview
    ft = { "md" },
    build = "deno task --quiet build:fast",
    config = function()
      require "plugins.configs.lsp.lang.peek"
    end,
  },
  -- inc/dec plugin
  {
    "monaqa/dial.nvim",
    event = "BufRead",
    init = function()
      require("core.utils").load_mappings "dial"
    end,
    config = function()
      require "plugins.configs.code.dial"
    end,
  },
  -- code navigation
  {
    "SmiteshP/nvim-navbuddy",
    event = "LspAttach",
    init = function()
      require("core.utils").load_mappings "navbuddy"
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim", -- Optional
      "nvim-telescope/telescope.nvim", -- Optional
    },
    config = function()
      require "plugins.configs.interface.navbuddy"
    end,
  },
  -- highlight curr word
  {
    "echasnovski/mini.nvim",
    event = "BufEnter",
    version = false,
    config = function()
      require "plugins.configs.code.cursorword"
      require "plugins.configs.interface.animate"
    end,
  },
  -- lsp progress
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require "plugins.configs.interface.fidget"
    end,
  },
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    init = function()
      require("core.utils").load_mappings "trouble"
    end,
    config = function()
      require "plugins.configs.interface.trouble"
    end,
  },
  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require "plugins.configs.code.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-emoji",
      },
    },
    config = function()
      require "plugins.configs.code.cmp"
    end,
  },
  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "InsertEnter",
    keys = {
      { "gcc", mode = "n" },
      { "gc", mode = "v" },
      { "gbc", mode = "n" },
      { "gb", mode = "v" },
    },
    init = function()
      require("core.utils").load_mappings "comment"
    end,
    config = function()
      require "plugins.configs.code.comment"
    end,
  },
  -- Todo comments with highlights
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "plugins.configs.code.todo_comments"
    end,
  },
  -- Annotations highlights
  {
    "folke/paint.nvim",
    event = "BufRead",
    config = function()
      require "plugins.configs.code.paint"
    end,
  },
  -- Annotations generator
  {
    "danymat/neogen",
    cmd = "Neogen",
    init = function()
      require("core.utils").load_mappings "neogen"
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    dependencies = {
      {
        "stevearc/dressing.nvim",
        config = function()
          require "plugins.configs.interface.dressing"
        end,
      },
    },
    config = function()
      require "plugins.configs.interface.nvimtree"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-treesitter/nvim-treesitter",
      "dharmx/telescope-media.nvim",
      "LukasPietzschmann/telescope-tabs",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    config = function()
      require "plugins.configs.telescope.telescope"
    end,
  },
  -- refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    event = "LspAttach",
    init = function()
      require("core.utils").load_mappings "refactoring"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require "plugins.configs.code.refactoring"
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require "plugins.configs.telescope.project"
    end,
  },

  {
    "ziontee113/icon-picker.nvim",
    cmd = { "IconPickerInsert", "IconPickerNormal", "IconPickerYank" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      {
        "stevearc/dressing.nvim",
        config = function()
          require "plugins.configs.interface.dressing"
        end,
      },
    },
    config = function()
      require "plugins.configs.telescope.icons"
    end,
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`", "c", "v", "g" },
    init = function()
      require("core.utils").load_mappings "whichkey"
    end,
    config = function()
      dofile(vim.g.base46_cache .. "whichkey")
      -- require("which-key").register(require("core.utils").load_config().mappings)
      require("which-key").setup()
    end,
  },
  {
    "mrjones2014/legendary.nvim",
    cmd = { "Legendary" },
    init = function()
      require("core.utils").load_mappings "legendary"
    end,
    config = function()
      require "plugins.configs.interface.legendary"
    end,
  },
}
local config = require("core.utils").load_config()

if #config.plugins > 0 then
  table.insert(default_plugins, { import = config.plugins })
end

require("lazy").setup(default_plugins, config.lazy_nvim)
