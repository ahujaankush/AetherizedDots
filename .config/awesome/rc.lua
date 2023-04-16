-- User variables and preferences
-- ===================================================================
local awful = require("awful")
require("awful.autofocus")

-- Get screen geometry
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

user = {
	-- default applications
	terminal = "kitty",
	floating_terminal = "kitty",
	browser = "brave",
	file_manager = "dolphin",
	image_viewer = "lximage-qt",
	editor = "neovide",
	code = "code",
	nvim = "neovide",
	email_client = "evolution",
	music_client = "spotify-launcher",
	office = "libreoffice",
	-- Serach engine
	web_search_cmd = "xdg-open https://duckduckgo.com/?q=",

	-- >> User profile <<
	profile_picture = os.getenv("HOME") .. "/.face",
	nickname = "pyxodan",
	-- Keyboard layouts
	keyboardLayouts = { "us", "at" },

	-- Directories with fallback values
	dirs = {
		downloads = os.getenv("XDG_DOWNLOAD_DIR") or os.getenv("HOME") .. "/Downloads",
		documents = os.getenv("XDG_DOCUMENTS_DIR") or os.getenv("HOME") .. "/Documents",
		music = os.getenv("XDG_MUSIC_DIR") or os.getenv("HOME") .. "/Music",
		pictures = os.getenv("XDG_PICTURES_DIR") or os.getenv("HOME") .. "/Pictures",
		videos = os.getenv("XDG_VIDEOS_DIR") or os.getenv("HOME") .. "/Videos",
		-- directory has to exist, otherwise screenshots will not be saved
		screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or os.getenv("HOME") .. "/Pictures/Screenshots",

		resources = "~/Documents/resources",
		workspace = "~/Documents/workspace",
		student = "~/Documents/student",
		books = "~/Documents/books",
		toDO = "~/Documents/toDO",
	},

	sidebar = { hide_on_mouse_leave = true, show_on_mouse_screen_edge = true },
	-- lockscreen passwd. will be used with luapam is not installed
	lock_screen_custom_password = "123",

	-- battery notif. will be send on the following percentage:
	battery_threshold_ok = 60,
	battery_threshold_low = 30,
	battery_threshold_critical = 20,

	-- Enter key and cityID (https://openweathermap.org/) for weather
	openweathermap_key = "39f36d59bbaf2f916ea06dbbf29fcf1f",
	openweathermap_city_id = "2761369",

	-- Use "metric" for Celcius, "imperial" for Fahrenheit
	weather_units = "metric",

	coronavirus_country = "austria",
	-- rate for rubato
	animation_rate = 144,
}

-- Initialization
-- ===================================================================

-- Theme handling library
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()
-- Make dpi function global
dpi = beautiful.xresources.apply_dpi

-- global variable, transparent background
colors = { transparent = "00000000" }
-- Make xresources colors global
x = {
	--           xrdb variable
	background = xrdb.background,
	foreground = xrdb.foreground,
	color0 = xrdb.color0,
	color1 = xrdb.color1,
	color2 = xrdb.color2,
	color3 = xrdb.color3,
	color4 = xrdb.color4,
	color5 = xrdb.color5,
	color6 = xrdb.color6,
	color7 = xrdb.color7,
	color8 = xrdb.color8,
	color9 = xrdb.color9,
	color10 = xrdb.color10,
	color11 = xrdb.color11,
	color12 = xrdb.color12,
	color13 = xrdb.color13,
	color14 = xrdb.color14,
	color15 = xrdb.color15,
}

-- Load AwesomeWM libraries
local gears = require("gears")
-- Default notification library
local naughty = require("naughty")

-- Load theme
local theme_dir = os.getenv("HOME") .. "/.config/awesome/theme/"
beautiful.init(theme_dir .. "theme.lua")

-- bling
local bling = require("modules.bling")
local machi = require("modules.layout-machi")

-- Error handling
-- ===================================================================
naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)

-- Features
-- ===================================================================
-- Keybinds and mousebinds
local keys = require("keys")
-- Load notification daemons and notification theme
local notifications = require("ui.notifications")
notifications.init()
-- Load window decoration theme and custom decorations
local decorations = require("ui.decorations")
decorations.init()

-- Wallpaper
-- ===================================================================
-- setup for multiple screens at once
-- the 'screen' argument can be a table of screen objects
bling.module.wallpaper.setup({
	screen = screen, -- The awesome 'screen' variable is an array of all screen objects
	wallpaper = { beautiful.wallpaper },
	position = "maximized",
})

-- Layouts
-- ===================================================================
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile, -- awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle, --    awful.layout.suit.tile.top,
	--    awful.layout.suit.fair,
	--    awful.layout.suit.fair.horizontal,
	--    awful.layout.suit.tile.left,
	--    awful.layout.suit.tile.bottom,
	--    awful.layout.suit.max.fullscreen,
	--    awful.layout.suit.corner.nw,
	--    awful.layout.suit.magnifier,
	bling.layout.mstab,
	bling.layout.centered, --    bling.layout.vertical,
	--    bling.layout.horizontal,
	bling.layout.equalarea,
	bling.layout.deck,
	--    awful.layout.suit.corner.ne,
	--    awful.layout.suit.corner.sw,
	--    awful.layout.suit.corner.se,
	machi.default_layout,
}

-- ===================================================================

-- flash focus
-- bling.module.flash_focus.enable()

-- icons
require("icons")

-- >> Elements - Desktop component
-- Statusbar(s)
require("ui.components.wibar")
-- Exit screen
require("ui.components.exit_screen.exit_screen")
-- Control Center
require("ui.components.control_center")
-- Dash Center
require("ui.components.dash_center")
-- Lock screen
-- Make sure to install lua-pam as described in the README or configure your
-- custom password in the 'user' section above
require("ui.components.exit_screen.lockscreen").init()
-- App drawer
require("ui.components.menu.app_drawer")
-- Menu
require("ui.components.menu.menu")
-- Layout popup
require("ui.components.layout_popup")
-- Hotkeys overlay
require("awful.hotkeys_popup.keys")
-- window window
require("ui.components.window_switcher")
-- dropdown terminal
require("ui.components.term_scratchpad")
-- dropdown pavucontrol
require("ui.components.audio_scratchpad")
-- sidebar
require("ui.components.sidebar")
-- >> Daemons
-- Most widgets that display system/external info depend on daemons.
-- Make sure to initialize it last in order to allow all widgets to connect to
-- their needed signals.
require("daemon")

-- ===================================================================

-- Autostart
-- ===================================================================
-- runs shell script
awful.spawn.with_shell("sh $HOME/.config/awesome/autostart.sh")

-- Tags
-- ===================================================================
awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	local l = awful.layout.suit -- Alias to save time :)
	-- Tag layouts
	local layouts = {
		l.floating,
		l.floating,
		l.floating,
		l.floating,
		l.floating,
		l.floating,
		l.floating,
		l.floating,
		l.floating,
		l.floating,
	}

	-- Tag names
	local tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }
	-- Create all tags at once (without seperate configuration for each tag)
	awful.tag(tagnames, s, layouts)

	-- Create tags with seperate configuration for each tag
	-- awful.tag.add(tagnames[1], {
	--     layout = layouts[1],
	--     screen = s,
	--     master_width_factor = 0.6,
	--     selected = true,
	-- })
	-- ...
end)

-- Determines how floating clients should be placed
local floating_client_placement = function(c)
	-- If the layout is floating or there are no other visible
	-- clients, center client
	if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating or mouse.screen.clients == 1 then
		return awful.placement.centered(c, {
			honor_padding = true,
			honor_workarea = true,
		})
	end

	-- Else use this placement
	local p = awful.placement.no_overlap + awful.placement.no_offscreen
	return p(c, {
		honor_padding = true,
		honor_workarea = true,
		margins = beautiful.useless_gap * 2,
	})
end

local centered_client_placement = function(c)
	return gears.timer.delayed_call(function()
		awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
	end)
end

-- Rules
-- ===================================================================
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	{
		-- All clients will match this rule.
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = keys.clientkeys,
			buttons = keys.clientbuttons,
			-- screen = awful.screen.preferred,
			screen = awful.screen.focused,
			size_hints_honor = false,
			honor_workarea = true,
			honor_padding = true,
			maximized = false,
			titlebars_enabled = beautiful.titlebars_enabled,
			maximized_horizontal = false,
			maximized_vertical = false,
			placement = floating_client_placement,
		},
	}, -- Floating clients
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"floating_terminal",
				"riotclientux.exe",
				"leagueclientux.exe",
				"Devtools", -- Firefox devtools
			},
			class = {
				"Gpick",
				"Lxappearance",
				"Nm-connection-editor",
				"File-roller",
				"fst",
				"Nvidia-settings",
			},
			name = {
				"Event Tester", -- xev
				"MetaMask Notification",
			},
			role = {
				"AlarmWindow",
				"pop-up",
				"GtkFileChooserDialog",
				"conversation",
			},
			type = { "dialog" },
		},
		properties = { floating = true },
	}, -- TODO why does Chromium always start up floating in AwesomeWM?
	-- Temporary fix until I figure it out
	{
		rule_any = { class = { "Chromium-browser", "Chromium" } },
		properties = { floating = false },
	}, -- Fullscreen clients
	{
		rule_any = {
			class = {
				"lt-love",
				"portal2_linux",
				"csgo_linux64",
				"EtG.x86_64",
				"factorio",
				"dota2",
				"Terraria.bin.x86",
				"dontstarve_steam",
			},
			instance = { "synthetik.exe" },
		},
		properties = { fullscreen = true },
	}, -- -- Unfocusable clients (unless clicked with the mouse)
	-- -- If you want to prevent focusing even when clicking them, you need to
	-- -- modify the left click client mouse bind in keys.lua
	{
		rule_any = {
			class = {
				"spad",
				"Pavucontrol",
			},
		},
		properties = { skip_taskbar = true },
	},
	-- Centered clients
	{
		rule_any = {
			type = { "dialog" },
			class = {
				"Steam",
				"discord",
				"music",
				"markdown_input",
				"scratchpad",
			},
			instance = { "music", "markdown_input", "scratchpad" },
			role = { "GtkFileChooserDialog", "conversation" },
		},
		properties = { placement = centered_client_placement },
	}, -- Titlebars OFF (explicitly)
	{
		rule_any = {
			instance = {
				"^editor$",
				"markdown_input",
			},
			class = {
				"qutebrowser",
				"Sublime_text",
				"Subl3",
				"spad",
				"TelegramDesktop",
				"Conky",
				"Pavucontrol",
				"Nightly",
				"Steam",
				"Lutris",
				"Chromium",
				"^editor$",
				"markdown_input", -- "Thunderbird",
			},
			type = { "splash" },
			name = {
				"^discord.com is sharing your screen.$", -- Discord (running in browser) screen sharing popup
			},
		},
		callback = function(c)
			decorations.hide(c)
		end,
	}, -- Titlebars ON (explicitly)
	{
		rule_any = { type = { "dialog" }, role = { "conversation" } },
		callback = function(c)
			decorations.show(c)
		end,
	}, -- "Needy": Clients that steal focus when they are urgent
	{
		rule_any = {
			class = { "TelegramDesktop", "firefox", "Nightly" },
			type = { "dialog" },
		},
		callback = function(c)
			c:connect_signal("property::urgent", function()
				if c.urgent then
					c:jump_to()
				end
			end)
		end,
	}, -- Fixed terminal geometry for floating terminals
	{
		rule_any = {
			class = {
				"Alacritty",
				"Termite",
				"mpvtube",
				"kitty",
				"st-256color",
				"st",
				"URxvt",
			},
		},
		properties = { width = screen_width * 0.45, height = screen_height * 0.5 },
	}, -- Visualizer
	{
		rule_any = { class = { "Visualizer" } },
		properties = {
			floating = true,
			maximized_horizontal = true,
			sticky = true,
			ontop = false,
			skip_taskbar = true,
			below = true,
			focusable = false,
			height = screen_height * 0.40,
			opacity = 0.6,
			titlebars_enabled = false,
		},
		callback = function(c)
			awful.placement.bottom(c)
		end,
	}, -- File chooser dialog
	{
		rule_any = { role = { "GtkFileChooserDialog" } },
		properties = {
			floating = true,
			width = screen_width * 0.55,
			height = screen_height * 0.65,
		},
	},
	{
		rule_any = { class = { "kcalc" } },
		except_any = { type = { "dialog" } },
		properties = {
			floating = true,
			width = screen_width * 0.2,
			height = screen_height * 0.4,
		},
	}, -- File managers
	{
		rule_any = { class = { "dolphin", "Thunar" } },
		except_any = { type = { "dialog" } },
		properties = {
			floating = true,
			width = screen_width * 0.45,
			height = screen_height * 0.55,
		},
	}, -- Screenruler
	{
		rule_any = { class = { "Screenruler" } },
		properties = {
			border_width = 0,
			floating = true,
			ontop = true,
			titlebars_enabled = false,
		},
		callback = function(c)
			awful.placement.centered(c, {
				honor_padding = true,
				honor_workarea = true,
			})
		end,
	}, -- Keepass
	{
		rule_any = { class = { "KeePassXC" } },
		except_any = {
			name = { "KeePassXC-Browser Confirm Access" },
			type = { "dialog" },
		},
		properties = {
			floating = true,
			width = screen_width * 0.7,
			height = screen_height * 0.75,
		},
	}, -- Scratchpad
	{
		rule_any = {
			instance = { "scratchpad", "markdown_input" },
			class = { "scratchpad", "markdown_input" },
		},
		properties = {
			skip_taskbar = false,
			floating = true,
			ontop = false,
			minimized = true,
			sticky = false,
			width = screen_width * 0.7,
			height = screen_height * 0.75,
		},
	}, -- Markdown input
	{
		rule_any = { instance = { "markdown_input" }, class = { "markdown_input" } },
		properties = {
			skip_taskbar = false,
			floating = true,
			ontop = false,
			minimized = true,
			sticky = false,
			width = screen_width * 0.5,
			height = screen_height * 0.7,
		},
	}, -- Music clients (usually a terminal running ncmpcpp)
	{
		rule_any = { class = { "music" }, instance = { "music" } },
		properties = {
			floating = true,
			width = screen_width * 0.45,
			height = screen_height * 0.50,
		},
	}, -- Image viewers
	{
		rule_any = { class = { "feh", "gwenview" } },
		properties = {
			floating = true,
			width = screen_width * 0.7,
			height = screen_height * 0.75,
		},
		callback = function(c)
			awful.placement.centered(c, {
				honor_padding = true,
				honor_workarea = true,
			})
		end,
	}, -- Dragon drag and drop utility
	{
		rule_any = { class = { "Dragon-drag-and-drop", "Dragon" } },
		properties = {
			floating = true,
			ontop = true,
			sticky = true,
			width = screen_width * 0.3,
		},
		callback = function(c)
			awful.placement.bottom_right(c, {
				honor_padding = true,
				honor_workarea = true,
				margins = {
					bottom = beautiful.useless_gap * 2,
					right = beautiful.useless_gap * 2,
				},
			})
		end,
	}, -- Magit window
	{
		rule = { instance = "Magit" },
		properties = {
			floating = true,
			width = screen_width * 0.55,
			height = screen_height * 0.6,
		},
	}, -- Steam guard
	{
		rule = { name = "Steam Guard - Computer Authorization Required" },
		properties = { floating = true },
		-- Such a stubborn window, centering it does not work
		-- callback = function (c)
		--     gears.timer.delayed_call(function()
		--         awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
		--     end)
		-- end
	},
	{
		rule = { class = "eww-ocular" },
		properties = { floating = false, ontop = false },
	},
	{
		rule_any = { instance = { "synthetik.exe" } },
		properties = {},
		callback = function(c)
			-- Unminimize automatically
			c:connect_signal("property::minimized", function()
				if c.minimized then
					c.minimized = false
				end
			end)
		end,
	}, -- League of Legends client QoL fixes
	{
		rule = { instance = "league of legends.exe" },
		properties = {},
		callback = function(c)
			local matcher = function(c)
				return awful.rules.match(c, { instance = "leagueclientux.exe" })
			end
			-- Minimize LoL client after game window opens
			for c in awful.client.iterate(matcher) do
				c.urgent = false
				c.minimized = true
			end

			-- Unminimize LoL client after game window closes
			c:connect_signal("unmanage", function()
				for c in awful.client.iterate(matcher) do
					c.minimized = false
				end
			end)
		end,
	},
}
-- (Rules end here) ..................................................
-- ===================================================================

-- Signals
-- ===================================================================
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- For debugging awful.rules
	-- print('c.class = '..c.class)
	-- print('c.instance = '..c.instance)
	-- print('c.name = '..c.name)

	-- Set every new window as a slave,
	-- i.e. put it at the end of others instead of setting it master.
	if not awesome.startup then
		awful.client.setslave(c)
	end

	-- if awesome.startup
	-- and not c.size_hints.user_position
	-- and not c.size_hints.program_position then
	--     -- Prevent clients from being unreachable after screen count changes.
	--     awful.placement.no_offscreen(c)
	--     awful.placement.no_overlap(c)
	-- end
end)

-- When a client starts up in fullscreen, resize it to cover the fullscreen a short moment later
-- Fixes wrong geometry when titlebars are enabled
client.connect_signal("manage", function(c)
	if c.fullscreen then
		gears.timer.delayed_call(function()
			if c.valid then
				c:geometry(c.screen.geometry)
			end
		end)
	end
end)

if beautiful.border_width > 0 then
	client.connect_signal("focus", function(c)
		c.border_color = beautiful.border_focus
	end)
	client.connect_signal("unfocus", function(c)
		c.border_color = beautiful.border_normal
	end)
end

-- Set mouse resize mode (live or after)
awful.mouse.resize.set_mode("live")

-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)
-- ==============================================================
tag.connect_signal("property::layout", function(t)
	for k, c in ipairs(t:clients()) do
		if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
			local cgeo = awful.client.property.get(c, "floating_geometry")
			if cgeo then
				c:geometry(awful.client.property.get(c, "floating_geometry"))
			end
		end
	end
end)

client.connect_signal("manage", function(c)
	if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
		awful.client.property.set(c, "floating_geometry", c:geometry())
	end
end)

client.connect_signal("property::geometry", function(c)
	if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
		awful.client.property.set(c, "floating_geometry", c:geometry())
	end
end)

-- ==============================================================
-- ==============================================================

-- When switching to a tag with urgent clients, raise them.
-- This fixes the issue (visual mismatch) where after switching to
-- a tag which includes an urgent client, the urgent client is
-- unfocused but still covers all other windows (even the currently
-- focused window).
awful.tag.attached_connect_signal(s, "property::selected", function()
	local urgent_clients = function(c)
		return awful.rules.match(c, { urgent = true })
	end
	for c in awful.client.iterate(urgent_clients) do
		if c.first_tag == mouse.screen.selected_tag then
			client.focus = c
		end
	end
end)

-- Raise focused clients automatically
client.connect_signal("focus", function(c)
	c:raise()
end)

-- Focus all urgent clients automatically
-- client.connect_signal("property::urgent", function(c)
--     if c.urgent then
--         c.minimized = false
--         c:jump_to()
--     end
-- end)

-- Disable ontop when the client is not floating, and restore ontop if needed
-- when the client is floating again
-- I never want a non floating client to be ontop.
client.connect_signal("property::floating", function(c)
	if c.floating then
		if c.restore_ontop then
			c.ontop = c.restore_ontop
		end
	else
		c.restore_ontop = c.ontop
		c.ontop = false
	end
end)

-- Garbage collection
-- Enable for lower memory consumption
-- ===================================================================

collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

-- collectgarbage("setpause", 110)
-- collectgarbage("setstepmul", 1000)
