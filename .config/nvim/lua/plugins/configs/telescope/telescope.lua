dofile(vim.g.base46_cache .. "telescope")
local telescope = require "telescope"
local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.6,
        results_width = 0.7,
      },
      vertical = {
        mirror = false,
      },
      width = 0.9,
      height = 0.9,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  extensions = {
    media = {
      backend = "jp2a",
      backend_options = {
        jp2a = {
          move = true,
        },
      },
    },
    undo = {
      use_delta = true,
      use_custom_command = nil,
      side_by_side = true,
      diff_context_lines = vim.o.scrolloff,
      entry_format = "state #$ID, $STAT, $TIME",
      time_format = "",
      mappings = {
        i = {
          -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
          -- you want to replicate these defaults and use the following actions. This means
          -- installing as a dependency of telescope in it's `requirements` and loading this
          -- extension from there instead of having the separate plugin definition as outlined
          -- above.
          ["<C-CR>"] = require("telescope-undo.actions").yank_additions,
          ["<S-CR>"] = require("telescope-undo.actions").yank_deletions,
          ["<CR>"] = require("telescope-undo.actions").restore,
        },
      },
    },
  },
  extensions_list = {
    "themes",
    "terms",
    "media",
    "projects",
    "ui-select",
    "refactoring",
    "undo",
    "dap",
  },
}

telescope.setup(options)

for _, ext in ipairs(options.extensions_list) do
  telescope.load_extension(ext)
end
