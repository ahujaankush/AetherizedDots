local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local apps = require("apps")

local helpers = require("helpers")

local rubato = require("modules.rubato")

-- Item configuration
-- ==================
local temperature_bar = require("ui.widgets.sidebar.bar.temperature_bar")
temperature_bar:buttons(gears.table.join(awful.button({}, 1, apps.temperature_monitor)))

local cpu_bar = require("ui.widgets.sidebar.bar.cpu_bar")

cpu_bar:buttons(
	gears.table.join(awful.button({}, 1, apps.process_monitor), awful.button({}, 3, apps.process_monitor_gui))
)

local ram_bar = require("ui.widgets.sidebar.bar.ram_bar")

ram_bar:buttons(
	gears.table.join(awful.button({}, 1, apps.process_monitor), awful.button({}, 3, apps.process_monitor_gui))
)

local brightness_bar = require("ui.widgets.sidebar.bar.brightness_bar")

brightness_bar:buttons(gears.table.join(
	-- Left click - Toggle redshift
	awful.button({}, 1, apps.night_mode),
	-- Right click - Reset brightness (Set to max)
	awful.button({}, 3, function()
		helpers.set_brightness(100)
	end),
	-- Scroll up - Increase brightness
	awful.button({}, 4, function()
		helpers.brightness_control(10)
	end),
	-- Scroll down - Decrease brightness
	awful.button({}, 5, function()
		helpers.brightness_control(-10)
	end)
))

local hours = wibox.widget.textclock("%H")
local minutes = wibox.widget.textclock("%M")

local make_little_dot = function(color)
	return wibox.widget({
		bg = color,
		forced_width = dpi(13),
		forced_height = dpi(13),
		shape = helpers.rrect(dpi(2)),
		widget = wibox.container.background,
	})
end

local time = {
	{
		font = "biotif extra bold 55",
		align = "right",
		valign = "top",
		widget = hours,
	},
	{
		nil,
		{
			make_little_dot(x.color10),
			make_little_dot(x.color12),
			make_little_dot(x.color5),
			spacing = dpi(10),
			widget = wibox.layout.fixed.vertical,
		},
		expand = "none",
		widget = wibox.layout.align.vertical,
	},
	{
		font = "biotif extra bold 55",
		align = "left",
		valign = "top",
		widget = minutes,
	},
	spacing = dpi(20),
	layout = wibox.layout.fixed.horizontal,
}

-- Day of the week (dotw)
local dotw = require("ui.widgets.sidebar.day_of_the_week")
local day_of_the_week = wibox.widget({
	nil,
	dotw,
	expand = "none",
	layout = wibox.layout.align.horizontal,
})

local volume_bar = require("ui.widgets.sidebar.bar.volume_bar")

volume_bar:buttons(gears.table.join(
	-- Left click - Mute / Unmute
	awful.button({}, 1, function()
		helpers.volume_control(0)
	end),
	-- Right click - Run or raise pavucontrol
	awful.button({}, 3, apps.volume),
	-- Scroll - Increase / Decrease volume
	awful.button({}, 4, function()
		helpers.volume_control(2)
	end),
	awful.button({}, 5, function()
		helpers.volume_control(-2)
	end)
))

-- Create tooltip widget
-- It should change depending on what the user is hovering over
local adaptive_tooltip = wibox.widget({
	visible = false,
	top_only = true,
	layout = wibox.layout.stack,
})

-- Create tooltip for widget w
local tooltip_counter = 0
local create_tooltip = function(w)
	local tooltip = wibox.widget({
		font = beautiful.font_name .. " 10",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	tooltip_counter = tooltip_counter + 1
	local index = tooltip_counter

	adaptive_tooltip:insert(index, tooltip)

	w:connect_signal("mouse::enter", function()
		-- Raise tooltip to the top of the stack
		adaptive_tooltip:set(1, tooltip)
		adaptive_tooltip.visible = true
	end)
	w:connect_signal("mouse::leave", function()
		adaptive_tooltip.visible = false
	end)

	return tooltip
end

local brightness_tooltip = create_tooltip(brightness_bar)
awesome.connect_signal("evil::brightness", function(value)
	brightness_tooltip.markup = "Your screen is <span foreground='"
		.. beautiful.brightness_bar_active_color
		.. "'><b>"
		.. tostring(value)
		.. "%</b></span> bright"
end)

local cpu_tooltip = create_tooltip(cpu_bar)
awesome.connect_signal("evil::cpu", function(value)
	cpu_tooltip.markup = "You are using <span foreground='"
		.. beautiful.cpu_bar_active_color
		.. "'><b>"
		.. tostring(value)
		.. "%</b></span> of CPU"
end)

local ram_tooltip = create_tooltip(ram_bar)
awesome.connect_signal("evil::ram", function(value, _)
	ram_tooltip.markup = "You are using <span foreground='"
		.. beautiful.ram_bar_active_color
		.. "'><b>"
		.. string.format("%.1f", value / 1000)
		.. "G</b></span> of memory"
end)

local volume_tooltip = create_tooltip(volume_bar)
awesome.connect_signal("evil::volume", function(value, muted)
	volume_tooltip.markup = "The volume is at <span foreground='"
		.. beautiful.volume_bar_active_color
		.. "'><b>"
		.. tostring(value)
		.. "%</b></span>"
	if muted then
		volume_tooltip.markup = volume_tooltip.markup
			.. " and <span foreground='"
			.. beautiful.volume_bar_active_color
			.. "'><b>muted</b></span>"
	end
end)

local temperature_tooltip = create_tooltip(temperature_bar)
awesome.connect_signal("evil::temperature", function(value)
	temperature_tooltip.markup = "Your CPU temperature is at <span foreground='"
		.. beautiful.temperature_bar_active_color
		.. "'><b>"
		.. tostring(value)
		.. "°C</b></span>"
end)

-- Add clickable mouse effects on some widgets
helpers.add_hover_cursor(cpu_bar, "hand1")
helpers.add_hover_cursor(ram_bar, "hand1")
helpers.add_hover_cursor(temperature_bar, "hand1")
helpers.add_hover_cursor(volume_bar, "hand1")
helpers.add_hover_cursor(brightness_bar, "hand1")

-- Create the sidebar
sidebar = wibox({ visible = false, ontop = true, type = "dock", screen = screen.primary })
sidebar.bg = "#00000000" -- For anti aliasing
sidebar.fg = beautiful.sidebar_fg or beautiful.wibar_fg or "#FFFFFF"
sidebar.opacity = beautiful.sidebar_opacity or 1
sidebar.height = beautiful.sidebar_height
sidebar.width = beautiful.sidebar_width or dpi(300)
sidebar.y = beautiful.sidebar_y or 0
local radius = beautiful.sidebar_border_radius or 0
if beautiful.sidebar_position == "right" then
	awful.placement.top_right(sidebar)
	sidebar.shape = helpers.prrect(radius, true, false, false, true)
else
	awful.placement.top_left(sidebar)
	sidebar.shape = helpers.prrect(radius, false, true, true, false)
end
--awful.placement.maximize_vertically(sidebar, { honor_workarea = true, margins = { top = beautiful.useless_gap * 2 } })

-- rubato sidebar slide
local slide = rubato.timed({
	pos = screen.primary.geometry.x - sidebar.width,
	intro = 0.1,
	outro = 0,
	duration = 0.4,
	easing = rubato.easing.quadratic,
	subscribed = function(pos)
		sidebar.x = screen.primary.geometry.x + pos
	end,
})

sidebar.timer = gears.timer({
	timeout = 0.45,
	single_shot = true,
	callback = function()
		sidebar.visible = not sidebar.visible
	end,
})

sidebar:buttons(gears.table.join(
	-- Middle click - Hide sidebar
	awful.button({}, 2, function()
		sidebar_hide()
	end)
))

sidebar_show = function()
	sidebar.visible = true
	slide.target = screen.primary.geometry.x
end

sidebar_hide = function()
	slide.target = screen.primary.geometry.x - sidebar.width
	sidebar.timer:start()
end

sidebar_toggle = function()
	if sidebar.visible then
		sidebar_hide()
	else
		sidebar.timer:start()
	end
end

-- Hide sidebar when mouse leaves
if user.sidebar.hide_on_mouse_leave then
	sidebar:connect_signal("mouse::leave", function()
		sidebar_hide()
	end)
end
-- Activate sidebar by moving the mouse at the edge of the screen
if user.sidebar.show_on_mouse_screen_edge then
	local sidebar_activator = wibox({
		y = sidebar.y,
		width = 1,
		visible = true,
		ontop = false,
		opacity = 0,
		below = true,
		screen = screen.primary,
	})
	sidebar_activator.height = sidebar.height
	sidebar_activator:connect_signal("mouse::enter", function()
		sidebar_show()
	end)

	if beautiful.sidebar_position == "right" then
		awful.placement.right(sidebar_activator)
	else
		awful.placement.left(sidebar_activator)
	end

	sidebar_activator:buttons(gears.table.join(
		awful.button({}, 4, function()
			awful.tag.viewprev()
		end),
		awful.button({}, 5, function()
			awful.tag.viewnext()
		end)
	))
end

local playground = require("ui.widgets.sidebar.playground")

-- Item placement
sidebar:setup({
	{
		{ ----------- TOP GROUP -----------
			{
				helpers.vertical_pad(dpi(30)),
				{
					nil,
					{
						time,
						spacing = dpi(12),
						layout = wibox.layout.fixed.horizontal,
					},
					expand = "none",
					layout = wibox.layout.align.horizontal,
				},
				helpers.vertical_pad(dpi(20)),
				day_of_the_week,
				helpers.vertical_pad(dpi(20)),
				{
					nil,
					expand = "none",
					layout = wibox.layout.align.horizontal,
				},
				helpers.vertical_pad(dpi(20)),
				layout = wibox.layout.fixed.vertical,
			},
			{
				nil,
				{
					{
						nil,
						volume_bar,
						expand = "none",
						layout = wibox.layout.align.vertical,
					},
					{
						nil,
						cpu_bar,
						expand = "none",
						layout = wibox.layout.align.vertical,
					},

					{
						nil,
						temperature_bar,
						expand = "none",
						layout = wibox.layout.align.vertical,
					},
					{
						nil,
						ram_bar,
						expand = "none",
						layout = wibox.layout.align.vertical,
					},
					{
						nil,
						brightness_bar,
						expand = "none",
						layout = wibox.layout.align.vertical,
					},
					spacing = dpi(20),
					forced_height = dpi(110),
					layout = wibox.layout.fixed.horizontal,
				},
				expand = "none",
				layout = wibox.layout.align.horizontal,
			},
			helpers.vertical_pad(dpi(30)),
			layout = wibox.layout.fixed.vertical,
		},
		{ ----------- MIDDLE GROUP -----------
			{
				helpers.vertical_pad(dpi(30)),
				{
					playground,
					margins = {
						left = dpi(20),
						right = dpi(20),
					},
					widget = wibox.container.margin,
				},
				layout = wibox.layout.fixed.vertical,
			},
			shape = helpers.prrect(beautiful.sidebar_border_radius, false, true, false, false),
			bg = x.color0 .. "66",
			widget = wibox.container.background,
		},
		{ ----------- BOTTOM GROUP -----------
			{
				{

					{
						nil,
						adaptive_tooltip,
						expand = "none",
						layout = wibox.layout.align.horizontal,
					},

					layout = wibox.layout.fixed.vertical,
				},
				margins = dpi(20),
				widget = wibox.container.margin,
			},
			bg = x.color0 .. "66",
			widget = wibox.container.background,
		},

		layout = wibox.layout.align.vertical,
	},
	bg = beautiful.sidebar_bg or beautiful.wibar_bg or "#111111",
	widget = wibox.container.background,
})
