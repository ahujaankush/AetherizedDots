local colorizer = require "colorizer"
local options = {
    filetypes = { "*" },      -- Filetype options.  Accepts table like `user_default_options`
    buftypes = {},            -- Buftype options.  Accepts table like `user_default_options`
    -- Boolean | List of usercommands to enable.  See User commands section.
    user_commands = true,     -- Enable all or some usercommands
    lazy_load = false,        -- Lazily schedule buffer highlighting setup function
    user_default_options = {
        names = false,         -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
        names_opts = {        -- options for mutating/filtering names.
            lowercase = true, -- name:lower(), highlight `blue` and `red`
            camelcase = true, -- name, highlight `Blue` and `Red`
            uppercase = true, -- name:upper(), highlight `BLUE` and `RED`
            strip_digits = false, -- ignore names with digits,
            -- highlight `blue` and `red`, but not `blue3` and `red4`
        },
        -- Expects a table of color name to #RRGGBB value pairs.  # is optional
        -- Example: { cool = "#107dac", ["notcool"] = "ee9240" }
        -- Set to false to disable, for example when setting filetype options
        names_custom = false, -- Custom names to be highlighted: table|function|false
        RGB = true,           -- #RGB hex codes
        RGBA = true,          -- #RGBA hex codes
        RRGGBB = true,        -- #RRGGBB hex codes
        RRGGBBAA = true,     -- #RRGGBBAA hex codes
        AARRGGBB = true,     -- 0xAARRGGBB hex codes
        rgb_fn = true,       -- CSS rgb() and rgba() functions
        hsl_fn = true,       -- CSS hsl() and hsla() functions
        css = false,          -- Enable all CSS *features*:
        -- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
        css_fn = true,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
        tailwind = true,     -- Enable tailwind colors
        tailwind_opts = {     -- Options for highlighting tailwind names
            update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
        },
        -- parsers can contain values used in `user_default_options`
        sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
        -- Highlighting mode.  'background'|'foreground'|'virtualtext'
        mode = "virtualtext",                          -- Set the display mode
        -- Virtualtext character to use
        virtualtext = "󱓻",
        -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
        virtualtext_inline = 'before',
        -- Virtualtext highlight mode: 'background'|'foreground'
        virtualtext_mode = "foreground",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = true,
        -- hooks to invert control of colorizer
        hooks = {
            -- called before line parsing.  Set to function that returns a boolean and accepts the following parameters.  See hooks section.
            do_lines_parse = false,
        },
    },
}
colorizer.setup(options)

vim.defer_fn(function()
    colorizer.attach_to_buffer(0)
end, 0)
