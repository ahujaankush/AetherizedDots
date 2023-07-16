local jdtls = require "jdtls"

-------------------
-- GENERAL SETTINGS
-------------------
local M = {}
-- Determine OS
local home = os.getenv "HOME"
local workspace_path = home .. "/.cache/jdtls/workspace/"
local cfg = "linux"

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")

local workspace_dir = workspace_path .. project_name

--Make sure DAP is activated by default
JAVA_DAP_ACTIVE = true

----------------------------
-- Prepare JAR dependencies
----------------------------
--Debugging
local bundles = {
  vim.fn.glob(home .. "/.config/nvim/jars/java-debug/com.microsoft.java.debug.plugin-*.jar", 1),
}

--Testing
for _, bundle in ipairs(vim.split(vim.fn.glob(home .. "/.config/nvim/jars/vscode-java-test/server/*.jar", 1), "\n")) do
  --These two jars are not bundles, therefore don't put them in the table
  if
    not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
    and not vim.endswith(bundle, "com.microsoft.java.test.runner.jar")
  then
    table.insert(bundles, bundle)
  end
end

--Decompiler
for _, bundle in
  ipairs(vim.split(vim.fn.glob(home .. "/.config/nvim/jars/vscode-java-decompiler/server/*.jar", 1), "\n"))
do
  table.insert(bundles, bundle)
end

-------------------------------
-- Prepare on_attach and capabilities
-------------------------

-- Highlight symbol under cursor
local function lsp_highlight(client, bufnr)
  if client.supports_method "textDocument/documentHighlight" then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

M.on_attach = function(client, bufnr)
  if client.name == "jdtls" then
    require("jdtls.setup").add_commands()
    jdtls.setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
    require("lsp_signature").on_attach {
      bind = true,
      use_lspsaga = true,
      floating_window = true,
      fix_pos = true,
      hint_enable = true,
      hi_parameter = "Search",
      handler_opts = {
        border = "rounded",
      },
    }
    lsp_highlight(client, bufnr)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

------------------
-- Server settings
------------------
M.attach = function()
  -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
  local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

      "java", -- or '/path/to/java17_or_newer/bin/java'
      -- depends on if `java` is in your $PATH env variable and if it points to the right version.

      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",

      "-jar",
      vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
      -- Must point to the                                                     Change this to
      -- eclipse.jdt.ls installation                                           the actual version

      "-configuration",
      home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. cfg,
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
      -- Must point to the                      Change to one of `linux`, `win` or `mac`
      -- eclipse.jdt.ls installation            Depending on your system.

      -- üíÄ
      -- See `data directory configuration` section in the README
      "-data",
      workspace_dir,
    },
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = root_dir,
    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- or https://github.com/redhat-developer/vscode-java#supported-vs-code-settings
    -- for a list of options
    settings = {
      java = {
        eclipse = {
          downloadSources = true,
        },
        configuration = {
          updateBuildConfiguration = "interactive",
          -- runtimes = {
          -- 	{
          -- 		name = "JavaSE-1.8",
          -- 		path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home",
          -- 	},
          -- 	{
          -- 		name = "JavaSE-1.8",
          -- 		path = "/Library/Java/JavaVirtualMachines/jdk1.8.0_291.jdk/Contents/Home",
          -- 	},
          -- 	{
          -- 		name = "JavaSE-11",
          -- 		path = "/opt/homebrew/Cellar/openjdk@11/11.0.18/libexec/openjdk.jdk/Contents/Home",
          -- 	},
          -- 	{
          -- 		name = "JavaSE-19",
          -- 		path = "/opt/homebrew/Cellar/openjdk/19.0.2/libexec/openjdk.jdk/Contents/Home",
          -- 	},
          -- },
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        format = {
          enabled = true,
          settings = {
            url = vim.fn.stdpath "config" .. "/configs/formatting/intellij-java-google-style.xml",
            profile = "GoogleStyle",
          },
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
    importOrder = {
      "java",
      "javax",
      "com",
      "org",
    },
    flags = {
      allow_incremental_sync = true,
    },
    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
      bundles = bundles,
      extendedClientCapabilities = extendedClientCapabilities,
    },
    on_attach = M.attach,
    capabilities = capabilities,
  }

  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  jdtls.start_or_attach(config)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

--JDTLS commands
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

return M
