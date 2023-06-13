local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local rubato = require("modules.rubato")
local dpi = beautiful.xresources.apply_dpi

local width = dpi(50)
local height = dpi(300)

local active_color_1 = {
	type = "linear",
	from = { 0, 0 },
	to = { height }, -- replace with w,h later
	stops = { { 0, x.color3 }, { 0.50, x.color11 } },
}

local bright_icon = wibox.widget({
	{
		widget = wibox.widget.textbox,
		markup = helpers.colorize_text("", x.color3),
		font = "JetBrainsMono Nerd Font 22",
		valign = "center",
		align = "center",
	},
	margins = dpi(5),
	widget = wibox.container.margin,
})

local bright_adjust = awful.popup({
	type = "notification",
	maximum_width = width,
	maximum_height = height,
	visible = false,
	ontop = true,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
	bg = "#00000000",
	placement = function(c)
		awful.placement.right(c, { margins = { right = 10 } })
	end,
})

local bright_bar = wibox.widget({
	bar_shape = gears.shape.rounded_rect,
	shape = gears.shape.rounded_rect,
	background_color = beautiful.notification_osd_indicator_bg,
	color = active_color_1,
	max_value = 100,
	value = 0,
	widget = wibox.widget.progressbar,
})

local bright_ratio = wibox.widget({
	layout = wibox.layout.ratio.vertical,
	{
		{ bright_bar, direction = "east", widget = wibox.container.rotate },
		top = dpi(20),
		left = dpi(20),
		right = dpi(20),
		widget = wibox.container.margin,
	},
	bright_icon,
	nil,
})

bright_ratio:adjust_ratio(2, 0.72, 0.28, 0)

bright_adjust.widget = wibox.widget({
	bright_ratio,
	border_width = beautiful.border_width * 0,
	border_color = beautiful.border_color,
	bg = beautiful.notification_osd_bg,
	opacity = beautiful.notification_osd_opacity,
	widget = wibox.container.background,
})

-- create a 3 second timer to hide the volume adjust
-- component whenever the timer is started
local animations = rubato.timed({
	pos = 0,
	rate = user.animation_rate,
	intro = 0.15,
	outro = 0.15,
	duration = 0.3,
	easing = rubato.easing.quadratic,
	subscribed = function(pos)
		bright_adjust.maximum_height = pos
	end,
})

local animations_timer = gears.timer({
	timeout = 0.3,
	single_shot = true,
	callback = function()
		bright_adjust.visible = false
		bright_bar.mouse_enter = false
	end,
})

-- create a 3 second timer to hide the volume adjust
-- component whenever the timer is started
local hide_bright_adjust = gears.timer({
	timeout = 3,
	autostart = true,
	callback = function()
		animations.target = 0
		animations_timer:again()
	end,
})

awesome.connect_signal("evil::brightness", function(value)
	bright_bar.value = value
	if bright_adjust.visible then
		hide_bright_adjust:again()
	else
		bright_adjust.visible = true
		animations.target = height
		hide_bright_adjust:start()
	end
end)
