local legendary = require "legendary"
local mappings = require "compiled.legendary.keymaps"

local compile = function()
  local cfg = require("core.utils").load_config().mappings
  local compiled = {}
  local tableIO = require "deps.tableIO"
  for _, map in pairs(cfg) do
    for mode, section_keys in pairs(map) do
      section_keys = (type(section_keys) == "table" and section_keys) or {}
      for k, tb in pairs(section_keys) do
        compiled[#compiled + 1] = { k, mode = mode, description = tb[2] and tb[2] or "<empty>" }
      end
    end
  end
  local filepath = os.getenv "HOME" .. "/.config/nvim/lua/compiled/legendary/keymaps.lua"
  tableIO.save(compiled, filepath)
  print("Compiled keymaps at " .. filepath)
end

vim.api.nvim_create_user_command("LegendaryCompile", function()
  compile()
end, {})

local options = {
  keymaps = mappings,
}
legendary.setup(options)
