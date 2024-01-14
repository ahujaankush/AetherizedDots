local dapvirtual = require "nvim-dap-virtual-text"

local options = {
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  display_callback = function(variable, _buf, _stackframe, _node)
    return variable.name .. " = " .. variable.value
  end,
  virt_text_pos = "eol",
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil,
}

dapvirtual.setup(options)
