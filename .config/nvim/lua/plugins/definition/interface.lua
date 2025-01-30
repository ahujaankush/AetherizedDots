return {
    {
        "goolord/alpha-nvim",
        lazy = false,
        dependencies = { "ahujaankush/base46" },
        config = function()
            require "plugins.configs.interface.alpha"
        end,
    },
    {
        "ahujaankush/base46",
        branch = "v2.0",
        lazy = false,
        build = function()
            require("base46").load_all_highlights()
        end,
    },
    {
        'akinsho/bufferline.nvim',
        event = "BufRead",
        config = function()
            require "plugins.configs.interface.bufferline"
        end,
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
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
        "petertriho/nvim-scrollbar",
        event = "BufRead",
        config = function()
            require "plugins.configs.interface.scrollbar"
        end,
    },
    -- nvim ui
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require "plugins.configs.interface.devicons"
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufRead",
        config = function()
            require "plugins.configs.interface.blankline"
        end,
    },
    -- preview when entering line numbers
    {
        "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require "plugins.configs.interface.numb"
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        init = function()
            require("core.utils").load_mappings "nvimtree"
        end,
        config = function()
            require "plugins.configs.interface.nvimtree"
        end,
    },
    -- load luasnips + cmp related in insert mode only
    -- Only load whichkey after all the gui
    {
        "folke/which-key.nvim",
        keys = { "<leader>" },
        init = function()
            require("core.utils").load_mappings "whichkey"
        end,
        config = function()
            dofile(vim.g.base46_cache .. "whichkey")
            -- require("which-key").register(require("core.utils").load_config().mappings)
            require("which-key").setup()
        end,
    },
}
