local Menu = require "nui.menu"
local NuiText = require "nui.text"

return function()
  local popup_options = {
    size = { width = 30, height = 7 },
    position = {
      row = "50%",
      col = "50%",
    },
    border = {
      style = {
        top_left = NuiText(" ", "NUINormal"),
        top = NuiText(" ", "NUINormal"),
        top_right = NuiText(" ", "NUINormal"),
        left = NuiText(" ", "NUINormal"),
        right = NuiText(" ", "NUINormal"),
        bottom_left = NuiText(" ", "NUINormal"),
        bottom = NuiText(" ", "NUINormal"),
        bottom_right = NuiText(" ", "NUINormal"),
      },
      text = {
        top = NuiText("", "NUIHeading"),
        top_align = "center",
      },
    },
    win_options = {
      winblend = 0,
      winhighlight = "NUIText:NUIText",
    },
  }

  local menu_options = {
    lines = {
      Menu.separator(NuiText("  Colortils ", "NUIHeading"), { char = "─", text_align = "center" }),
      Menu.item(NuiText("   Picker      ", "NUIYes")),
      Menu.item(NuiText("   Gradient      ", "NUIYes")),
      Menu.item(NuiText("   Darken      ", "NUINo")),
      Menu.item(NuiText("   Lighten       ", "NUINo")),
      Menu.item(NuiText("   Greyscale   ", "NUICancel")),
      Menu.item(NuiText("   CSS   ", "NUICancel")),
    },
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>" },
      submit = { "<CR>", "<Space>" },
    },
  }
  menu_options.on_submit = function(item)
    local result = vim.trim(item.text._content)
    vim.cmd("Colortils " .. string.lower(result))
  end
  Menu(popup_options, menu_options):mount()
end
