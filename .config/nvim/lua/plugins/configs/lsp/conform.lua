local options = {
    lsp_fallback = true,
    formatters_by_ft = {},
    -- adding same formatter for multiple filetypes can look too much work for some
    -- instead of the above code you could just use a loop! the config is just a table after all!


    -- format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },
}

local formatterFt = {
    ["prettier"] = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars" },
    ["shfmt"] = { "sh" },
    ["clang_format"] = { "c", "cpp", "cs", "java", "cuda", "proto", "ino" },
    ["autopep8"] = { "py" }

}

for k, v in pairs(formatterFt) do
    for _, f in ipairs(v) do
        options.formatters_by_ft[f] = { k }
    end
end

require("conform").setup(options)
