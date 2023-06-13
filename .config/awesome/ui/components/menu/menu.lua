local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local apps = require("apps")
local menu_popup = require("ui.widgets.menu.menu")
local submenu_popup = require("ui.widgets.menu.submenu")
local menu_entry = require("ui.widgets.menu.entry")

local separator = function()
	return wibox.widget({
		layout = wibox.layout.align.vertical,
		forced_height = dpi(5),
		expand = "none",
		nil,
		{
			widget = wibox.widget.separator,
			forced_height = dpi(2),
			orientation = "horizontal",
			thickness = dpi(1),
			color = x.color8,
		},
	})
end

local applications_entry = menu_entry({
	icon = helpers.colorize_text("", x.color5),
	text = "Applications",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		awful.spawn.with_shell("rofi -show drun -config $HOME/.config/rofi/launcher.rasi")
	end,
})

local terminal_entry = menu_entry({
	icon = helpers.colorize_text("", x.color1),
	text = "Terminal",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		apps.terminal()
	end,
})

local web_entry = menu_entry({
	icon = helpers.colorize_text("󰇧", x.color4),
	text = "Web Browser",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		apps.browser()
	end,
})

local file_entry = menu_entry({
	icon = helpers.colorize_text("", x.color3),
	text = "File Manager",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		apps.file_manager()
	end,
})

local text_entry = menu_entry({
	icon = helpers.colorize_text("󰤀", x.color2),
	text = "Text Editor",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		apps.editor()
	end,
})

local music_entry = menu_entry({
	icon = helpers.colorize_text("", x.color6),
	text = "Music Player",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		apps.music()
	end,
})

local controlcenter_entry = menu_entry({
	icon = helpers.colorize_text("漣", x.color13),
	text = "Control Center",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		control_center_show(mouse.screen)
	end,
})

local dashcenter_entry = menu_entry({
	icon = helpers.colorize_text("", x.color12),
	text = "Dash Center",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		dash_center_show(mouse.screen)
	end,
})

local appdrawer_entry = menu_entry({
	icon = helpers.colorize_text("󰘳", x.color11),
	text = "App Menu",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		app_drawer_show()
	end,
})

local exit_entry = menu_entry({
	icon = helpers.colorize_text("", x.color9),
	text = "Exit",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		exit_screen_show()
	end,
})
----------------------------------------------------------

local keys_entry = menu_entry({
	icon = helpers.colorize_text("󰥻", x.color5),
	text = "Keys",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		require("awful.hotkeys_popup.widget"):show_help()
	end,
})

local api_entry = menu_entry({
	icon = helpers.colorize_text("", x.color1),
	text = "API",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		apps.browser("https://awesomewm.org/apidoc/")
	end,
})

local restart_entry = menu_entry({
	icon = helpers.colorize_text("ﰇ", x.color4),
	text = "Restart",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		awesome.restart()
	end,
})

local quit_entry = menu_entry({
	icon = helpers.colorize_text("󰗼", x.color3),
	text = "Quit",
	submenu_icon = beautiful.menu_submenu_icon,
	press_func = function()
		awesome.quit()
	end,
})

local awesome_menu = submenu_popup({
	pos = {
		x = 100,
		y = 100,
	},
	entries = {
		keys_entry,
		api_entry,
		separator(),
		restart_entry,
		quit_entry,
	},
})
---------------------------------------------------------
local awesome_submenu = menu_entry({
	icon = helpers.colorize_text("缾", x.color14),
	text = "Awesome",
	submenu_icon = beautiful.menu_submenu_icon,
	submenu_parent = true,
	submenu = awesome_menu,
	press_func = function() end,
})

------------------------------------------------------------------

local menu = menu_popup({
	entries = {
		applications_entry,
		terminal_entry,
		web_entry,
		file_entry,
		text_entry,
		music_entry,
		separator(),
		controlcenter_entry,
		dashcenter_entry,
		appdrawer_entry,
		exit_entry,
		separator(),
		awesome_submenu,
	},
})

awesome_submenu:set_parent(menu)

function menu_toggle()
	if menu.menu_popup.visible then
		menu:hide()
	else
		menu:show()
	end
end
