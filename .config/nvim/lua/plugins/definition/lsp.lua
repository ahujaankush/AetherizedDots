return {
    -- lsp stuff
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
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
            "williamboman/mason-lspconfig.nvim",
        },
        init = function()
            require("core.utils").lazy_load "nvim-lspconfig"
            require("core.utils").load_mappings "lspconfig"
        end,
        config = function()
            require "plugins.configs.lsp.lspconfig"
        end,
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- Uncomment whichever supported plugin(s) you use
            "nvim-tree/nvim-tree.lua",
            -- "nvim-neo-tree/neo-tree.nvim",
            -- "simonmclean/triptych.nvim"
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    -- Formatter
    {
        "stevearc/conform.nvim",
        event = "BufRead",
        init = function()
            require("core.utils").load_mappings "conform"
        end,

        config = function()
            require "plugins.configs.lsp.conform"
        end,
    },
    -- language specific plugins
    -- typescript (lsp)
    {
        "pmizio/typescript-tools.nvim",
        ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
        build = ":MasonInstall typescript-language-server",
        config = function()
            require "plugins.configs.lsp.lang.typescript"
        end,
    },
    -- c/cpp (lsp)
    {
        "p00f/clangd_extensions.nvim",
        ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        build = { ":MasonInstall clangd", "npm -g i @vscode/codicons" },
        config = function()
            require "plugins.configs.lsp.lang.clangd"
        end,
    },
    -- jdtls
    {
        "mfussenegger/nvim-jdtls",
        dependencies = { "williamboman/mason.nvim" },
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
    {
        "nvim-neotest/neotest",
        event = "LspAttach",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/nvim-nio",
            -- language specific
            "haydenmeade/neotest-jest",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-plenary",
            "nvim-neotest/neotest-go",
            "alfaix/neotest-gtest"
        },
        config = function()
            require "plugins.configs.lsp.neotest"
        end,
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
                dependencies = {
                    "nvim-neotest/nvim-nio"
                }
            },
            -- mason.nvim integration
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = { "mason.nvim" },
                cmd = { "DapInstall", "DapUninstall" },
                config = function()
                    require "plugins.configs.lsp.masondap"
                end,
            },
        },
        config = function()
            require "plugins.configs.lsp.dap"
        end,
    },
}
