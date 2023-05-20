--       ┏━━━━━━━━━┓
--       ┃ PLUGINS ┃
--       ┗━━━━━━━━━┛

-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {

  "nvim-lua/plenary.nvim",
  "tpope/vim-repeat",
  -- mkdir -p
  { "jghauser/mkdir.nvim", lazy = false },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  -- clipboard image
  {
    "ekickx/clipboard-image.nvim",
    init = function()
      require("core.utils").lazy_load "clipboard-image.nvim"
    end,
    config = function()
      require("clipboard-image").setup()
    end,
  },
  -- markdown preview
  {
    "toppair/peek.nvim",
    init = function()
      require("core.utils").lazy_load "peek.nvim"
    end,
    build = "deno task --quiet build:fast",
    opts = function()
      require "plugins.configs.peek"
    end,
    config = function(_, opts)
      require("peek").setup(opts)
    end,
  },
  {
    "axieax/urlview.nvim",
    init = function()
      require("core.utils").lazy_load "urlview.nvim"
    end,
    config = function()
      require("urlview").setup()
    end,
  },
  {
    "itchyny/vim-highlighturl",
    event = "CursorMoved",
  },
  -- rest client
  {
    "rest-nvim/rest.nvim",
    init = function()
      require("core.utils").lazy_load "rest.nvim"
    end,
    opts = function()
      require "plugins.configs.rest"
    end,
    config = function(_, opts)
      require("rest-nvim").setup(opts)
    end,
  },
  -- discord presence
  {
    "andweeb/presence.nvim",
    init = function()
      require("core.utils").lazy_load "presence.nvim"
    end,
    opts = function()
      require "plugins.configs.presence"
    end,
    config = function(_, opts)
      require("presence").setup(opts)
    end,
  },
  -- nvchad plugins
  { "ahujaankush/nvim-extensions" },

  {
    "ahujaankush/nvim-base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "ahujaankush/nvim-ui",
    lazy = false,
    config = function()
      require "nvchad_ui"
    end,
  },

  {
    "winston0410/range-highlight.nvim",
    init = require("core.utils").lazy_load "range-highlight.nvim",
    config = function()
      require("range-highlight").setup()
    end,
    dependencies = {
      { "winston0410/cmd-parser.nvim" },
    },
  },
  {
    "NvChad/nvterm",
    init = require("core.utils").load_mappings "nvterm",
    opts = function()
      return require "plugins.configs.nvterm"
    end,
    config = function(_, opts)
      require("nvterm").setup(opts)
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    init = require("core.utils").lazy_load "nvim-colorizer.lua",
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
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
    "ray-x/web-tools.nvim",
    init = function()
      require("core.utils").lazy_load "web-tools.nvim"
    end,
    opts = function()
      return require "plugins.configs.webtools"
    end,
    config = function(_, opts)
      require("web-tools").setup(opts)
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
      require("core.utils").lazy_load "indent-blankline.nvim"
    end,
    opts = function()
      return require "plugins.configs.blankline"
    end,
    config = function(_, opts)
      require("core.utils").load_mappings "blankline"
      dofile(vim.g.base46_cache .. "blankline")
      require("indent_blankline").setup(opts)
    end,
  },

  -- autosave
  {
    "Pocco81/auto-save.nvim",
    init = function()
      require("core.utils").lazy_load "auto-save.nvim"
    end,
    opts = function()
      require "plugins.configs.autosave"
    end,
    config = function(_, opts)
      require("auto-save").setup(opts)
    end,
  },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = function()
      return require "plugins.configs.notify"
    end,
    config = function(_, opts)
      local notify = require "notify"
      vim.notify = function(msg, ...)
        if msg:match "warning: multiple different client offset_encodings" then
          return
        end

        notify(msg, ...)
      end

      notify.setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    init = require("core.utils").lazy_load "nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "plugins.configs.treesitter"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)
    end,
    dependencies = {
      {
        "folke/twilight.nvim",
        opts = function()
          require "plugins.configs.twilight"
        end,
        config = function(_, opts)
          require("twilight").setup(opts)
        end,
      },
      {
        "ckolkey/ts-node-action",
        init = require("core.utils").load_mappings "node_action",
        opts = function()
          require "plugins.configs.ts_node"
        end,
        config = function(_, opts)
          require("ts-node-action").setup(opts)
        end,
      },
      {
        "windwp/nvim-ts-autotag",
        opts = function()
          require "plugins.configs.autotag"
        end,
        config = function(_, opts)
          require("nvim-ts-autotag").setup(opts)
        end,
      },
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = "gitsigns.nvim" }
            end)
          end
        end,
      })
    end,
    opts = function()
      return require "plugins.configs.gitsigns"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require "plugins.configs.mason"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
    end,
  },

  {
    "neovim/nvim-lspconfig",
    init = require("core.utils").lazy_load "nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        init = require("core.utils").load_mappings "null_ls",
        config = function()
          require "plugins.configs.null-ls"
        end,
      },
    },

    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  {
    "folke/neodev.nvim",
    init = require("core.utils").lazy_load "neodev.nvim",
    opts = function()
      require "plugins.configs.neodev"
    end,
    config = function(_, opts)
      require("neodev").setup(opts)
    end,
  },

  {
    "aurum77/live-server.nvim",
    cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    init = require("core.utils").lazy_load "live-server.nvim",
    build = function()
      require("live_server.util").install()
    end,
    opts = function()
      require "plugins.configs.live_server"
    end,
    config = function(_, opts)
      require("live_server").setup(opts)
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    init = require("core.utils").lazy_load "refactoring.nvim",
    opts = function()
      return require "plugins.configs.refactoring"
    end,
    config = function(_, opts)
      require("refactoring").setup(opts)
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
  },

  {
    "b0o/schemastore.nvim",
    init = require("core.utils").lazy_load "schemastore.nvim",
  },

  -- Debugger
  {
    "mfussenegger/nvim-dap",
    init = require("core.utils").lazy_load "nvim-dap",
    config = function()
      require "plugins.configs.dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    init = require("core.utils").lazy_load "nvim-dap-ui",
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    init = require("core.utils").lazy_load "nvim-dap-python",
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    init = require("core.utils").lazy_load "nvim-dap-virtual-text",
  },
  -- diagnostics, quickfixed
  {
    "folke/trouble.nvim",
    opts = function()
      return require "plugins.configs.trouble"
    end,
    init = function()
      require("core.utils").lazy_load "trouble.nvim"
      require("core.utils").load_mappings "trouble"
    end,
    config = function(_, opts)
      require("trouble").setup(opts)
    end,
  },

  -- lsp signatures
  {
    "ray-x/lsp_signature.nvim",
    opts = function()
      return require "plugins.configs.lsp_signature"
    end,
    init = require("core.utils").lazy_load "lsp_signature.nvim",
    config = function(_, opts)
      require("lsp_signature").setup(opts)
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

  -- Java
  { "mfussenegger/nvim-jdtls", init = require("core.utils").lazy_load "lsp_signature.nvim" },

  -- CSharp
  { "Hoffs/omnisharp-extended-lsp.nvim", init = require("core.utils").lazy_load "omnisharp-extended-lsp.nvim" },
  -- C(PP)
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    build = "npm -g i @vscode/codicons",
    opts = function()
      require "plugins.configs.clangd"
    end,
    config = function(_, opts)
      require("clangd_extensions").setup(opts)
    end,
  },
  -- -- typescript
  {
    "jose-elias-alvarez/typescript.nvim",
    opts = function()
      return require "plugins.configs.typescript"
    end,
    init = require("core.utils").lazy_load "typescript.nvim",
    config = function(_, opts)
      require("typescript").setup(opts)
    end,
  },

  -- golang

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    init = require("core.utils").lazy_load "go.nvim",
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- lsp progress
  {
    "j-hui/fidget.nvim",
    opts = function()
      return require "plugins.configs.fidget"
    end,
    init = require("core.utils").lazy_load "fidget.nvim",
    config = function(_, opts)
      require("fidget").setup(opts)
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
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
          require "plugins.configs.luasnip"
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
        "hrsh7th/cmp-nvim-lsp-signature-help",
      },
    },

    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  {
    "echasnovski/mini.nvim",
    version = false,
    init = require("core.utils").lazy_load "mini.nvim",
    config = function()
      require("mini.cursorword").setup()
    end,
  },

  {
    "numToStr/Comment.nvim",
    -- keys = { "gc", "gb" },
    init = require("core.utils").load_mappings "comment",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  {
    "folke/todo-comments.nvim",
    init = require("core.utils").lazy_load "todo-comments.nvim",
    opts = function()
      require "plugins.configs.todo_comments"
    end,
    config = function(_, opts)
      require("todo-comments").setup(opts)
    end,
  },

  {
    "LudoPinelli/comment-box.nvim",
    init = require("core.utils").lazy_load "comment-box.nvim",
    opts = function()
      require "plugins.configs.commentbox"
    end,
    config = function(_, opts)
      require("comment-box").setup(opts)
    end,
  },

  {
    "danymat/neogen",
    init = function()
      require("core.utils").load_mappings "neogen"
      require("core.utils").lazy_load "neogen"
    end,
    opts = function()
      require "plugins.configs.neogen"
    end,
    config = function(_, opts)
      require("neogen").setup(opts)
    end,
  },

  {
    "Pocco81/high-str.nvim",
    init = require("core.utils").lazy_load "high-str.nvim",
    opts = function()
      require "plugins.configs.highstr"
    end,
    config = function(_, opts)
      require("high-str").setup(opts)
    end,
  },

  -- Zenmode

  {
    "Pocco81/true-zen.nvim",
    init = function()
      require("core.utils").lazy_load "true-zen.nvim"
      require("core.utils").load_mappings "truezen"
    end,
    opts = function()
      require "plugins.configs.truezen"
    end,
    config = function(_, opts)
      require("true-zen").setup(opts)
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = require("core.utils").load_mappings "nvimtree",
    opts = function()
      return require "plugins.configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    init = require("core.utils").load_mappings "saga",
    opts = function()
      return require "plugins.configs.lspsaga"
    end,
    config = function(_, opts)
      require("lspsaga").setup(opts)
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = require("core.utils").load_mappings "telescope",

    opts = function()
      return require "plugins.configs.telescope"
    end,

    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,

    dependencies = {
      "dharmx/telescope-media.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
  },

  {
    "ahmedkhalf/project.nvim",
    lazy = true,
    config = function()
      require("project_nvim").setup()
    end,
  },

  -- scrollbar
  {
    "petertriho/nvim-scrollbar",
    init = function()
      require("core.utils").lazy_load "nvim-scrollbar"
    end,
    config = function()
      require("scrollbar").setup()
    end,
  },

  -- manage nvim windows
  {
    "sindrets/winshift.nvim",
    init = function()
      require("core.utils").lazy_load "winshift.nvim"
    end,
    opts = function()
      require "plugins.configs.winshift"
    end,
    config = function(_, opts)
      require("winshift").setup(opts)
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`" },
    init = require("core.utils").load_mappings "whichkey",
    opts = function()
      return require "plugins.configs.whichkey"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },
}

local config = require("core.utils").load_config()

if #config.plugins > 0 then
  table.insert(default_plugins, { import = config.plugins })
end

-- lazy_nvim startup opts
local lazy_config = vim.tbl_deep_extend("force", require "plugins.configs.lazy_nvim", config.lazy_nvim)

require("lazy").setup(default_plugins, lazy_config)
