local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local icons = require("icons")
local rubato = require("modules.rubato")
local helpers = require("helpers")
-- Note: This theme does not show image notification icons

-- For antialiasing
-- The real background color is set in the widget_template

local color = {
	type = "linear",
	from = { 0, 0 },
	to = { beautiful.notification_image_size * 1.65 }, -- replace with w,h later
	stops = { { 0, x.color6 }, { 0.5, x.color5 } },
}

local app_config = {
	["NetworkManager"] = {
		icon = icons.getIcon("beautyline/devices/scalable/network-wireless.svg"),
	},
	["NetworkManager Applet"] = {
		icon = icons.getIcon("beautyline/devices/scalable/network-wireless.svg"),
	},
	["blueman"] = {
		icon = icons.getIcon("beautyline/apps/scalable/bluetooth.svg"),
	},
}

-- Template
-- ===================================================================
naughty.connect_signal("request::display", function(n)
	if app_config[n.app_name] then
		n.icon = app_config[n.app_name].icon
	elseif n.icon == nil then
		n.icon = icons.getIcon("beautyline/apps/scalable/preferences-desktop-notification.svg")
	end

	-- Basics
	local title = wibox.widget({
		widget = wibox.container.scroll.horizontal,
		step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
		speed = 100,
		rate = user.animation_rate,
		{
			markup = n.title:match(".") and "<b>" .. n.title .. "</b>" or "<b>Notification</b>",
			font = beautiful.notification_title_font,
			halign = "center",
			widget = wibox.widget.textbox,
		},
	})
	local summary = wibox.widget({
		widget = wibox.container.scroll.horizontal,
		step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
		speed = 100,
		rate = user.animation_rate,
		{
			widget = wibox.widget.textbox,
			halign = "center",
			font = beautiful.notification_font,
			text = gears.string.xml_unescape(n.message),
		},
	})

	-- Fancy timeout image frame animation
	local image = wibox.widget({
		widget = wibox.widget.imagebox,
		image = n.icon,
		resize = true,
		align = "center",
		horizontal_fit_policy = "fit",
		vertical_fit_policy = "fit",
	})
	-- Animation stolen right off the certified animation lady.
	local timeout_graph = wibox.widget({
		widget = wibox.container.arcchart,
		min_value = 0,
		max_value = 100,
		value = 0,
		thickness = dpi(7),
		paddings = dpi(7),
		rounded_edge = true,
		colors = { color },
		bg = x.color0,
		forced_height = beautiful.notification_image_size,
		forced_width = beautiful.notification_image_size,
		image,
	})

	-- Action buttons
	local actions = wibox.widget({
		notification = n,
		base_layout = wibox.widget({
			spacing = dpi(7),
			layout = wibox.layout.flex.horizontal,
		}),
		widget_template = {
			{
				{
					{
						id = "text_role",
						font = beautiful.notification_font,
						widget = wibox.widget.textbox,
					},
					align = "center",
					widget = wibox.container.place,
				},
				bottom = dpi(9),
				top = dpi(9),
				left = dpi(13),
				right = dpi(13),
				widget = wibox.container.margin,
			},
			bg = x.color8,
			widget = wibox.container.background,
		},
		style = {
			underline_normal = false,
			underline_selected = true,
			bg_normal = x.color8,
		},
		widget = naughty.list.actions,
	})

	-- The actual notification
	local widget = naughty.layout.box({
		notification = n,
		cursor = "hand2",
		shape = helpers.rrect(beautiful.notification_border_radius),
		widget_template = {
			{
				{
					{
						{
							timeout_graph,
							margins = dpi(16),
							widget = wibox.container.margin,
						},
						strategy = "min",
						width = beautiful.notification_image_container_min_size,
						widget = wibox.container.constraint,
					},
					strategy = "max",
					width = beautiful.notification_image_container_max_size,
					widget = wibox.container.constraint,
				},
				{
					{
						{
							{
								{
									{
										{
											title,
											halign = "center",
											widget = wibox.container.place,
										},
										{
											summary,
											halign = "center",
											widget = wibox.container.place,
										},
										{
											{
												actions,
												shape = helpers.rrect(beautiful.notification_border_radius),
												widget = wibox.container.background,
											},
											left = dpi(9),
											right = dpi(9),
											top = dpi(7),
											widget = wibox.container.margin,
											visible = n.actions and #n.actions > 0,
										},
										spacing = dpi(7),
										layout = wibox.layout.fixed.vertical,
									},
									align = "center",
									widget = wibox.container.place,
								},
								margins = {
									left = dpi(40),
									right = dpi(40),
									bottom = dpi(20),
									top = dpi(20),
								},
								widget = wibox.container.margin,
							},
							bg = x.color0,
							shape = helpers.rrect(beautiful.notification_border_radius),
							widget = wibox.container.background,
						},
						strategy = "min",
						width = beautiful.notification_min_width,
						height = beautiful.notification_min_height,
						widget = wibox.container.constraint,
					},
					strategy = "max",
					width = beautiful.notification_width,
					height = beautiful.notification_height,
					widget = wibox.container.constraint,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			id = "background_role",
			widget = naughty.container.background,
		},
	})

	local anim = rubato.timed({
		intro = 0,
		duration = n.timeout,
		rate = user.animation_rate,
		subscribed = function(pos)
			timeout_graph.value = pos
		end,
	})
	anim.target = 100
end)
