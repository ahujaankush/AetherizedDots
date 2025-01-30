return {
    -- autosave
    {
        "NvChad/nvterm",
        init = function()
            require("core.utils").load_mappings "nvterm"
        end,
        config = function()
            require "custom.utils.term_override"
            require "plugins.configs.code.nvterm"
        end,
    },
    -- competitive programming
    {
        "ahujaankush/competitest.nvim",
        cmd = "CompetiTest",
        dependencies = 'MunifTanjim/nui.nvim',
        config = function() require('competitest').setup() end,
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
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require "plugins.configs.code.surround"
        end,
    },
    -- json schemas
    "b0o/schemastore.nvim",
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
    -- highlight curr word
    {
        "echasnovski/mini.nvim",
        event = "BufEnter",
        version = false,
        config = function()
            require "plugins.configs.code.cursorword"
            require "plugins.configs.code.move"
        end,
    },
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
                "David-Kunz/cmp-npm",
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
            { "gc",  mode = "v" },
            { "gbc", mode = "n" },
            { "gb",  mode = "v" },
        },
        init = function()
            require("core.utils").load_mappings "comment"
        end,
        config = function()
            require "plugins.configs.code.comment"
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
}
