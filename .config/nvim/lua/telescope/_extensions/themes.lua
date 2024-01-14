local fn = vim.fn

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"

local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function reload_theme(name)
  vim.g.nvchad_theme = name
  require("base46").load_all_highlights()
  vim.api.nvim_exec_autocmds("User", { pattern = "NvChadThemeReload" })
end

local function replace_word(old, new)
  local chadrc = vim.fn.stdpath "config" .. "/lua/custom/" .. "chadrc.lua"
  local file = io.open(chadrc, "r")
  local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
  local new_content = file:read("*all"):gsub(added_pattern, new)

  file = io.open(chadrc, "w")
  file:write(new_content)
  file:close()
end

local function list_themes()
  local default_themes = vim.fn.readdir(vim.fn.stdpath "data" .. "/lazy/base46/lua/base46/themes")

  local custom_themes = vim.loop.fs_stat(fn.stdpath "config" .. "/lua/custom/themes")

  if custom_themes and custom_themes.type == "directory" then
    local themes_tb = fn.readdir(fn.stdpath "config" .. "/lua/custom/themes")
    for _, value in ipairs(themes_tb) do
      default_themes[#default_themes + 1] = value
    end
  end

  for index, theme in ipairs(default_themes) do
    default_themes[index] = theme:match "(.+)%..+"
  end

  return default_themes
end

local function switcher()
  local bufnr = vim.api.nvim_get_current_buf()

  -- show current buffer content in previewer
  local previewer = previewers.new_buffer_previewer {
    define_preview = function(self, entry)
      -- add content
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      -- add syntax highlighting in previewer
      local ft = (vim.filetype.match { buf = bufnr } or "diff"):match "%w+"
      require("telescope.previewers.utils").highlighter(self.state.bufnr, ft)

      reload_theme(entry.value)
    end,
  }

  -- our picker function: colors
  local picker = pickers.new {
    prompt_title = "󱥚 Set Theme",
    previewer = previewer,
    finder = finders.new_table {
      results = list_themes(),
    },
    sorter = conf.generic_sorter(),

    attach_mappings = function(prompt_bufnr, map)
      -- reload theme while typing
      vim.schedule(function()
        vim.api.nvim_create_autocmd("TextChangedI", {
          buffer = prompt_bufnr,
          callback = function()
            if action_state.get_selected_entry() then
              reload_theme(action_state.get_selected_entry()[1])
            end
          end,
        })
      end)
      -- reload theme on cycling
      map("i", "<C-n>", function()
        actions.move_selection_next(prompt_bufnr)
        reload_theme(action_state.get_selected_entry()[1])
      end)

      map("i", "<C-p>", function()
        actions.move_selection_previous(prompt_bufnr)
        reload_theme(action_state.get_selected_entry()[1])
      end)

      ------------ save theme to chadrc on enter ----------------
      actions.select_default:replace(function()
        if action_state.get_selected_entry() then
          actions.close(prompt_bufnr)
          local current_theme = require("core.utils").load_config().ui.theme
          replace_word(current_theme, action_state.get_selected_entry()[1])
        end
      end)
      return true
    end,
  }

  picker:find()
end

return require("telescope").register_extension {
  exports = { themes = switcher },
}
