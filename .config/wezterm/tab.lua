local wezterm = require("wezterm")
local colors = require("theme").get_colors()

local Tab = {}

local function get_process(tab)
	local process_icons = {
		["docker"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "󰡨" },
		},
		["docker-compose"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "󰡨" },
		},
		["nvim"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = "" },
		},
		["bob"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "" },
		},
		["vim"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = "" },
		},
		["node"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = "󰋘" },
		},
		["zsh"] = {
			{ Foreground = { Color = colors.purple } },
			{ Text = "" },
		},
		["bash"] = {
			{ Foreground = { Color = colors.purple } },
			{ Text = "" },
		},
		["htop"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = "" },
		},
		["btop"] = {
			{ Foreground = { Color = colors.red } },
			{ Text = "" },
		},
		["cargo"] = {
			{ Foreground = { Color = colors.sun } },
			{ Text = wezterm.nerdfonts.dev_rust },
		},
		["go"] = {
			{ Foreground = { Color = colors.nord_blue } },
			{ Text = "" },
		},
		["git"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = "󰊢" },
		},
		["lazygit"] = {
			{ Foreground = { Color = colors.purple } },
			{ Text = "󰊢" },
		},
		["lua"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "" },
		},
		["wget"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = "󰄠" },
		},
		["curl"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = "" },
		},
		["gh"] = {
			{ Foreground = { Color = colors.dark_purple } },
			{ Text = "" },
		},
		["flatpak"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "󰏖" },
		},
	}

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

	if not process_name then
		process_name = "zsh"
	end

	return wezterm.format(
		process_icons[process_name]
			or { { Foreground = { Color = colors.nord_blue } }, { Text = string.format("[%s]", process_name) } }
	)
end

local function get_current_working_folder_name(tab)
	local cwd_uri = tab.active_pane.current_working_dir

	cwd_uri = cwd_uri:sub(8)

	local slash = cwd_uri:find("/")
	local cwd = cwd_uri:sub(slash)

	local HOME_DIR = os.getenv("HOME").."/"
	if cwd == HOME_DIR then
		return "  ~"
	end

	return string.format("  %s", cwd)
end

function Tab.setup(config)
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.tab_max_width = 50
	config.hide_tab_bar_if_only_one_tab = true

	wezterm.on("format-tab-title", function(tab)
		return wezterm.format({
			{ Attribute = { Intensity = "Half" } },
			{ Foreground = { Color = colors.white } },
			{ Text = string.format(" %s  ", tab.tab_index + 1) },
			"ResetAttributes",
			{ Text = get_process(tab) },
			{ Text = " " },
			{ Text = get_current_working_folder_name(tab) },
			{ Foreground = { Color = colors.black } },
			{ Text = "  ▕" },
		})
	end)
end

return Tab
