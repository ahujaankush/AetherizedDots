local M = {}
local merge_tb = vim.tbl_deep_extend

M.load_config = function()
  local config = require "core.default_config"
  local chadrc_path = vim.api.nvim_get_runtime_file("lua/custom/chadrc.lua", false)[1]

  if chadrc_path then
    local chadrc = dofile(chadrc_path)

    config.mappings = M.remove_disabled_keys(chadrc.mappings, config.mappings)
    config = merge_tb("force", config, chadrc)
  end

  config.mappings.disabled = nil
  return config
end

M.remove_disabled_keys = function(chadrc_mappings, default_mappings)
  if not chadrc_mappings then
    return default_mappings
  end

  -- store keys in a array with true value to compare
  local keys_to_disable = {}
  for _, mappings in pairs(chadrc_mappings) do
    for mode, section_keys in pairs(mappings) do
      if not keys_to_disable[mode] then
        keys_to_disable[mode] = {}
      end
      section_keys = (type(section_keys) == "table" and section_keys) or {}
      for k, _ in pairs(section_keys) do
        keys_to_disable[mode][k] = true
      end
    end
  end

  -- make a copy as we need to modify default_mappings
  for section_name, section_mappings in pairs(default_mappings) do
    for mode, mode_mappings in pairs(section_mappings) do
      mode_mappings = (type(mode_mappings) == "table" and mode_mappings) or {}
      for k, _ in pairs(mode_mappings) do
        -- if key if found then remove from default_mappings
        if keys_to_disable[mode] and keys_to_disable[mode][k] then
          default_mappings[section_name][mode][k] = nil
        end
      end
    end
  end

  return default_mappings
end

M.load_mappings = function(section, mapping_opt)
  local function set_section_map(section_values)
    if section_values.plugin then
      return
    end

    section_values.plugin = nil

    for mode, mode_values in pairs(section_values) do
      local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
      for keybind, mapping_info in pairs(mode_values) do
        -- merge default + user opts
        local opts = merge_tb("force", default_opts, mapping_info.opts or {})

        mapping_info.opts, opts.mode = nil, nil
        opts.desc = mapping_info[2]

        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end
  end

  local mappings = require("core.utils").load_config().mappings

  if type(section) == "string" then
    mappings[section]["plugin"] = nil
    mappings = { mappings[section] }
  end

  for _, sect in pairs(mappings) do
    set_section_map(sect)
  end
end

M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end

M.close_nvim = function()
  local Menu = require "nui.menu"
  local NuiText = require "nui.text"

  local popup_options = {
    size = { width = 20, height = 4 },
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
      Menu.separator(NuiText(" Save? ", "NUIHeading"), { char = "─", text_align = "center" }),
      Menu.item(NuiText("   Yes      ", "NUIYes")),
      Menu.item(NuiText("   No       ", "NUINo")),
      Menu.item(NuiText("   Cancel   ", "NUICancel")),
    },
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>" },
      submit = { "<CR>", "<Space>" },
    },
  }

  local function force_quit(item)
    local result = vim.trim(item.text._content)
    if result == "Yes" then
      vim.cmd "wqall!"
    elseif result == "No" then
      vim.cmd "quitall!"
    elseif result == "Cancel" then
      vim.api.nvim_notify("Cancelled.", vim.log.levels.INFO, {
        title = "bufclose.lua",
        icon = " ",
      })
    else
      error("Invalid option!", vim.log.levels.ERROR)
    end
  end

  local function normal_quit(item)
    local result = vim.trim(item.text._content)
    if result == "Yes" then
      vim.cmd.write()
      vim.cmd.bdelete()
    elseif result == "No" then
      vim.cmd.bdelete()
    elseif result == "Cancel" then
      vim.api.nvim_notify("Cancelled.", vim.log.levels.INFO, {
        title = "bufclose.lua",
        icon = " ",
      })
    else
      vim.api.nvim_notify("Invalid option!", vim.log.levels.ERROR, {})
    end
  end

  local cur_winnr = vim.fn.winnr()
  local cur_bufnr = vim.fn.bufnr()
  local buflisted = vim.fn.getbufinfo { buflisted = 1 }

  if #buflisted < 2 then
    if not vim.bo.modified then
      vim.cmd "quitall!"
      return
    end
    menu_options.on_submit = force_quit
    Menu(popup_options, menu_options):mount()
    return
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  for _, winid in ipairs(vim.fn.getbufinfo(cur_bufnr)[1].windows) do
    if vim.bo.modified then
      menu_options.on_submit = normal_quit
      Menu(popup_options, menu_options):mount()
    else
      vim.cmd(("%d wincmd w"):format(vim.fn.win_id2win(winid)))
      vim.cmd(cur_bufnr == buflisted[#buflisted].bufnr and "bp" or "bn")
      vim.cmd(("%d wincmd w"):format(cur_winnr))
      local is_terminal = vim.fn.getbufvar(cur_bufnr, "&buftype") == "terminal"
      vim.cmd(is_terminal and "bd! #" or "silent! confirm bd #")
    end
  end
end

return M
