local bufferline = require "bufferline"
local colors = require("base46").get_theme_tb "base_30"
local options = {
  highlights = {
    fill = {
      bg = colors.black2,
    },
    background = {
      bg = colors.black2,
    },
    tab = {
      fg = colors.white,
      bg = colors.one_bg2,
    },
    tab_selected = {
      fg = colors.black,
      bg = colors.green,
      bold = true,
    },
    tab_separator = {
      fg = colors.one_bg2,
      bg = colors.one_bg2,
    },
    tab_separator_selected = {
      fg = colors.green,
      bg = colors.green,
    },
    tab_close = {
      fg = colors.black2,
      bg = colors.red,
    },
    close_button = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    close_button_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    close_button_selected = {
      fg = colors.baby_pink,
      bg = colors.black,
    },
    buffer_visible = {
      fg = colors.light_grey,
      bg = colors.black2,
    },
    buffer_selected = {
      fg = colors.white,
      bg = colors.black,
      bold = true,
      italic = false,
    },
    numbers = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    numbers_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    numbers_selected = {
      fg = colors.light_grey,
      bg = colors.black,
      bold = false,
      italic = false,
    },
    diagnostic = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    diagnostic_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    diagnostic_selected = {
      fg = colors.light_grey,
      bg = colors.black,
      bold = true,
      italic = false,
    },
    hint = {
      fg = colors.grey_fg,
      sp = colors.black2,
      bg = colors.black2,
    },
    hint_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    hint_selected = {
      fg = colors.purple,
      bg = colors.black,
      sp = colors.black,
      bold = true,
      italic = false,
    },
    hint_diagnostic = {
      fg = colors.grey_fg,
      sp = colors.black2,
      bg = colors.black2,
    },
    hint_diagnostic_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    hint_diagnostic_selected = {
      fg = colors.purple,
      bg = colors.black,
      sp = colors.black,
      bold = true,
      italic = false,
    },
    info = {
      fg = colors.grey_fg,
      sp = colors.black2,
      bg = colors.black2,
    },
    info_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    info_selected = {
      fg = colors.purple,
      bg = colors.black,
      sp = colors.black,
      bold = true,
      italic = false,
    },
    info_diagnostic = {
      fg = colors.grey_fg,
      sp = colors.black2,
      bg = colors.black2,
    },
    info_diagnostic_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    info_diagnostic_selected = {
      fg = colors.purple,
      bg = colors.black,
      sp = colors.black,
      bold = true,
      italic = false,
    },
    warning = {
      fg = colors.grey_fg,
      sp = colors.black2,
      bg = colors.black2,
    },
    warning_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    warning_selected = {
      fg = colors.sun,
      bg = colors.black,
      sp = colors.black,
      bold = true,
      italic = false,
    },
    warning_diagnostic = {
      fg = colors.grey_fg,
      sp = colors.black2,
      bg = colors.black2,
    },
    warning_diagnostic_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    warning_diagnostic_selected = {
      fg = colors.sun,
      bg = colors.black,
      sp = colors.black,
      bold = true,
      italic = false,
    },
    error = {
      fg = colors.grey_fg,
      sp = colors.black2,
      bg = colors.black2,
    },
    error_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    error_selected = {
      fg = colors.red,
      bg = colors.black,
      sp = colors.black,
      bold = true,
      italic = false,
    },
    error_diagnostic = {
      fg = colors.grey_fg,
      sp = colors.black2,
      bg = colors.black2,
    },
    error_diagnostic_visible = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    error_diagnostic_selected = {
      fg = colors.red,
      bg = colors.black,
      sp = colors.black,
      bold = true,
      italic = false,
    },
    modified = {
      fg = colors.purple,
      bg = colors.black2,
    },
    modified_visible = {
      fg = colors.purple,
      bg = colors.black2,
    },
    modified_selected = {
      fg = colors.dark_purple,
      bg = colors.black,
    },
    -- duplicate_selected = {
    --   fg = "<colour-value-here>",
    --   bg = "<colour-value-here>",
    --   italic = true,
    -- },
    -- duplicate_visible = {
    --   fg = "<colour-value-here>",
    --   bg = "<colour-value-here>",
    --   italic = true,
    -- },
    -- duplicate = {
    --   fg = "<colour-value-here>",
    --   bg = "<colour-value-here>",
    --   italic = true,
    -- },
    separator_selected = {
      fg = colors.black2,
      bg = colors.black,
    },
    separator_visible = {
      fg = colors.black2,
      bg = colors.black2,
    },
    separator = {
      fg = colors.black2,
      bg = colors.black2,
    },
    indicator_visible = {
      fg = colors.red,
      bg = colors.black2,
    },
    indicator_selected = {
      fg = colors.dark_purple,
      bg = colors.black,
    },
    pick_selected = {
      fg = colors.sun,
      bg = colors.black,
      bold = true,
      italic = true,
    },
    pick_visible = {
      fg = colors.sun,
      bg = colors.black2,
      bold = false,
      italic = true,
    },
    pick = {
      fg = colors.sun,
      bg = colors.black2,
      bold = false,
      italic = true,
    },
    offset_separator = {
      fg = colors.darker_black,
      bg = colors.darker_black,
    },
  },
  options = {
    always_show_bufferline = true,
    enforce_regular_tabs = true,
    view = "multiwindow",
    themable = true,
    numbers = function(opts)
      return string.format("%s", opts.raise(opts.ordinal))
    end,
    close_icon = "󰅖",
    close_comamnd = function()
      require("bufdelete").bufdelete(0, true)
    end,
    diagnostics = "nvim_lsp",
    show_tab_indicators = true,
    left_trunc_marker = "",
    right_trunc_marker = "",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true, -- use a "true" to enable the default, or set your own character
      },
    },
    custom_filter = function(buf, buf_nums)
      -- return vim.fn.bufname(buf) ~= ""
      return true
    end,
    separator_style = { "", "" },
  },
}

bufferline.setup(options)
