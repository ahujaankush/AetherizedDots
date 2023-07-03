local modicator = require "modicator"
local hl = vim.api.nvim_set_hl
local return_bg = function(name)
  return "#" .. string.format("%06x", vim.api.nvim_get_hl_by_name(name, true).background)
end

hl(0, "NormalMode", { fg = return_bg "St_NormalMode" })
hl(0, "InsertMode", { fg = return_bg "St_InsertMode" })
hl(0, "VisualMode", { fg = return_bg "St_VisualMode" })
hl(0, "CommandMode", { fg = return_bg "St_CommandMode" })
hl(0, "ReplaceMode", { fg = return_bg "St_ReplaceMode" })
hl(0, "SelectMode", { fg = return_bg "St_SelectMode" })

local options = {
  -- Show warning if any required option is missing
  show_warnings = true,
  highlights = {
    -- Default options for bold/italic
    defaults = {
      bold = false,
      italic = false,
    },
  },
}

modicator.setup(options)
