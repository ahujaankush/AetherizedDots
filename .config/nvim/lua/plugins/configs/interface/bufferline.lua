local bufferline = require("bufferline")

dofile(vim.g.base46_cache .. "bufferline")

local options = {
  options = {
    offsets = {
      {
        filetype = "undotree",
        text = "",
        padding = 0,
      },
      {
        filetype = "NvimTree",
        text = "",
        padding = 1,
      },
    },
    mode = "buffers",
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = "bdelete! %d",
    indicator = { style = "none" },
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "X",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 14,
    max_prefix_length = 15,
    truncate_names = true,
    tab_size = 15,
    diagnostics = false,
    show_buffer_icons = false,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    separator_style = "none",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  },
}

bufferline.setup(options)
