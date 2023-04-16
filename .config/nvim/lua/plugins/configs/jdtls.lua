-- Java Language Server configuration.
-- Locations:
-- 'nvim/ftplugin/java.lua'.
-- 'nvim/lang-servers/intellij-java-google-style.xml'

local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify "JDTLS not found, install plugin in configuration"
  return
end

local roots = { ".git", "pom.xml", "mvnw", "gradlew", ".idea", ".iml" }
local root = vim.fs.dirname(vim.fs.find(roots, { upward = true })[1]) or vim.loop.cwd()
local workspace = os.getenv "HOME" .. "/Documents/Dev/" .. vim.fn.fnamemodify(root, ":p:h:t")

os.execute("mkdir " .. workspace)

local bundles = {
  vim.fn.glob(
    os.getenv "HOME"
      .. "/Documents/Dev/env/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
  ),
}

vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(os.getenv "HOME" .. "/Documents/Dev/env/vscode-java-test/server/*.jar", 1), "\n")
)

-- Main Config
local config = {
  init_options = {
    bundles = bundles,
  },
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "jdtls",
    "-data",
    workspace,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  -- root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk/",
          },
          {
            name = "JavaSE-19",
            path = "/usr/lib/jvm/java-19-openjdk/",
          },
        },
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
          url = vim.fn.stdpath "config" .. "/ftplugin/formatting/intellij-java-google-style.xml",
          profile = "GoogleStyle",
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
      importOrder = {
        "java",
        "javax",
        "com",
        "org",
      },
    },
    -- extendedClientCapabilities = extendedClientCapabilities,
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
    project = {
      referencedLibraries = {
        root .. "/lib**/*.jar",
        root .. "/*.jar",
      },
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
}

config["on_attach"] = function(client, bufnr)
  require("keymaps").map_java_keys(bufnr)
  require("lsp_signature").on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    floating_window_above_cur_line = false,
    padding = "",
    handler_opts = {
      border = "rounded",
    },
  }, bufnr)
  require("jdtls").setup_dap { hotcodereplace = "auto" }
end

local new_cmd = vim.api.nvim_create_user_command
new_cmd("JdtCompileInc", function()
  require("jdtls").compile "incremental"
end, {})
new_cmd("JdtCompileFull", function()
  require("jdtls").setup_dap { hotcodereplace = "auto" }
  require("jdtls").compile "full"
end, {})
new_cmd("JdtBuildProject", function(opts)
  require("jdtls").build_projects(opts)
end, { nargs = "*" })
new_cmd("JdtUpdateConfig", function()
  require("jdtls").update_project_config()
end, {})
new_cmd("JdtJol", function()
  require("jdtls").jol()
end, {})
new_cmd("JdtBytecode", function()
  require("jdtls").javap()
end, {})
new_cmd("JdtJshell", function()
  require("jdtls").jshell()
end, {})
new_cmd("JdtOrgImp", function()
  require("jdtls").organize_import()
end, {})
new_cmd("JdtExtVar", function()
  require("jdtls").extract_variable()
end, {})
new_cmd("JdtExtConst", function()
  require("jdtls").extract_constant()
end, {})
new_cmd("JdtExtMet", function()
  require("jdtls").extract_method()
end, {})

require("dap.ext.vscode").load_launchjs()

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
