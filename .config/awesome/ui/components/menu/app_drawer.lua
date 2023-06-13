local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local apps = require("apps")
-- local naughty = require("naughty")
local rubato = require("modules.rubato")
local helpers = require("helpers")

-- Appearance
-- local button_size = beautiful.app_drawer_icon_size or dpi(100)
--
local keybinds = {}

-- Helper function that creates buttons given a text symbol, color, hover_color
-- and the command to run on click.
local function create_button(symbol, color, hover_color, cmd, key)
	local icon = wibox.widget({
		markup = helpers.colorize_text(symbol, color),
		align = "center",
		valign = "center",
		font = "JetBrainsMono Nerd Font 40",
		forced_width = dpi(180),
		forced_height = dpi(200),
		widget = wibox.widget.textbox,
	})

	-- Press "animation"
	icon:connect_signal("button::press", function(_, _, __, button)
		if button == 3 then
			icon.markup = helpers.colorize_text(symbol, hover_color .. "55")
		end
	end)
	icon:connect_signal("button::release", function()
		icon.markup = helpers.colorize_text(symbol, hover_color)
	end)

	-- Hover "animation"
	icon:connect_signal("mouse::enter", function()
		icon.markup = helpers.colorize_text(symbol, hover_color)
	end)
	icon:connect_signal("mouse::leave", function()
		icon.markup = helpers.colorize_text(symbol, color)
	end)

	-- Change cursor on hover
	helpers.add_hover_cursor(icon, "hand1")

	-- Adds mousebinds if cmd is provided
	if cmd then
		icon:buttons(gears.table.join(
			awful.button({}, 1, function()
				cmd()
			end),
			awful.button({}, 3, function()
				cmd()
			end)
		))
	end

	-- Add keybind to dict, if given
	if key then
		keybinds[key] = cmd
	end

	return icon
end

-- Create app buttons
local terminal = create_button("", x.color1, x.color9, function()
	awful.spawn.with_shell(user.terminal)
end, "1")
local editor = create_button("﬏", x.color4, x.color12, apps.editor, "2")
local vim = create_button("", x.color2, x.color10, apps.nvim, "3")
local browser = create_button("爵", x.color5, x.color13, apps.browser, "4")
local mail = create_button("", x.color3, x.color11, apps.mail, "5")

local files = create_button("", x.color3, x.color11, apps.file_manager, "6")
local office = create_button("", x.color5, x.color13, apps.office, "7")
local okular = create_button("", x.color6, x.color14, apps.okular, "8")
local schedule = create_button("", x.color2, x.color10, apps.networks, "9")
local pyroWrite = create_button("", x.color1, x.color9, apps.editor, "0")

local resources = create_button("", x.color2, x.color10, function()
	awful.spawn.with_shell(user.file_manager .. " " .. user.dirs.resources)
end, "q")
local workspace = create_button("", x.color1, x.color9, function()
	awful.spawn.with_shell(user.file_manager .. " " .. user.dirs.workspace)
end, "w")
local student = create_button("拾", x.color5, x.color13, function()
	awful.spawn.with_shell(user.file_manager .. " " .. user.dirs.student)
end, "e")
local books = create_button("", x.color3, x.color11, function()
	awful.spawn.with_shell(user.file_manager .. " " .. user.dirs.books)
	require("ui.components.sidebar")
end, "r")
local toDO = create_button("", x.color6, x.color14, function()
	awful.spawn.with_shell(user.file_manager .. " " .. user.dirs.toDO)
end, "t")

local night_mode = create_button("望", x.color4, x.color12, apps.night_mode, "y")
local keys = create_button("", x.color2, x.color10, apps.passwords, "u")
local compositor = create_button("", x.color3, x.color11, apps.compositor, "i")
local restart_awesome = create_button("ﰇ", x.color1, x.color9, awesome.restart, "o")
local quit_awesome = create_button("", x.color5, x.color13, awesome.quit, "p")

-- Create the widget

local function create_stripe(widgets, bg)
	local buttons = wibox.widget({
		-- spacing = dpi(20),
		layout = wibox.layout.fixed.horizontal,
	})

	for _, widget in ipairs(widgets) do
		buttons:add(widget)
	end

	local stripe = wibox.widget({
		{
			nil,
			{
				nil,
				buttons,
				expand = "none",
				layout = wibox.layout.align.horizontal,
			},
			expand = "none",
			layout = wibox.layout.align.vertical,
		},
		bg = bg,
		widget = wibox.container.background,
	})

	return stripe
end

-- Add app drawer or mask to each screen
app_drawer = awful.popup({
	screen = screen.primary,
	visible = false,
	ontop = true,
	maximum_height = screen.primary.geometry.height,
	minimum_height = screen.primary.geometry.height,
	maximum_width = screen.primary.geometry.width,
	minimum_width = screen.primary.geometry.width,
	placement = function(c)
		awful.placement.centered(c)
	end,
	widget = {
		{
			-- Stripes
			create_stripe({ terminal, editor, vim, browser, mail }, "#00000000"),
			create_stripe({ files, office, okular, schedule, pyroWrite }, x.color8 .. "20"),
			create_stripe({ resources, workspace, student, books, toDO }, x.color8 .. "40"),
			create_stripe({
				night_mode,
				keys,
				compositor,
				restart_awesome,
				quit_awesome,
			}, x.color8 .. "60"),
			layout = wibox.layout.flex.vertical,
		},
		bg = x.background .. "FF",
		opacity = beautiful.app_drawer_opacity,
		widget = wibox.container.background,
	},
})

app_drawer.bg = "#00000000"
-- app_drawer.bg = beautiful.app_drawer_bg or x.background or "#111111"
app_drawer.fg = beautiful.app_drawer_fg or x.foreground or "#FEFEFE"

app_drawer:buttons(gears.table.join( -- Left click - Hide app_drawer
	awful.button({}, 1, function()
		app_drawer_hide()
	end),
	-- Right click - Hide app_drawer
	awful.button({}, 2, function()
		app_drawer_hide()
	end),
	-- Middle click - Hide app_drawer
	awful.button({}, 2, function()
		app_drawer_hide()
	end)
))

app_drawer_animation = rubato.timed({
	pos = screen.primary.geometry.height,
	intro = 0.3,
	outro = 0.3,
	duration = 0.6,
	rate = user.animation_rate,
	easing = rubato.easing.quadratic,
	subscribed = function(pos)
		app_drawer.y = pos
	end,
})

app_drawer_animation_timer = gears.timer({
	timeout = 0.6,
	single_shot = true,
	callback = function()
		app_drawer.visible = false
	end,
})

app_drawer_grabber = nil
app_drawer_animation_target = screen.primary.geometry.height

function app_drawer_hide()
	awful.keygrabber.stop(app_drawer_grabber)
	app_drawer_animation_target = app_drawer_animation_target * -1
	app_drawer_animation.target = app_drawer_animation_target
	app_drawer_animation_timer:start()
end

function app_drawer_show()
	-- naughty.notify({text = "starting the keygrabber"})
	if app_drawer.visible then
		app_drawer_animation_timer:stop()
	end
	app_drawer_grabber = awful.keygrabber.run(function(_, key, event)
		local invalid_key = false

		-- Debug
		-- naughty.notify({ title = event, text = key })
		-- if event == "press" and key == "Alt_L" or key == "Alt_R" then
		--     naughty.notify({ title = "you pressed alt" })
		-- end
		-- if event == "release" and key == "Alt_L" or key == "Alt_R" then
		--     naughty.notify({ title = "you released alt" })
		-- end

		if event == "release" then
			return
		end

		if keybinds[key] then
			keybinds[key]()
		else
			invalid_key = true
		end

		if not invalid_key or key == "Escape" then
			app_drawer_hide()
		end
	end)
	app_drawer.visible = true
	app_drawer_animation.target = 0
end
