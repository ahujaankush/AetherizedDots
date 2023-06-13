local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")
local gears = require("gears")
local helpers = require("helpers")

local ui_notifbox_builder = {}

--- Notification icon container
ui_notifbox_builder.notifbox_icon = function(ico_image)
	local noti_icon = wibox.widget({
		{
			id = "icon",
			resize = true,
			forced_height = dpi(25),
			forced_width = dpi(25),
			widget = wibox.widget.imagebox,
		},
		layout = wibox.layout.fixed.horizontal,
	})
	noti_icon.icon:set_image(ico_image)
	return noti_icon
end

--- Notification title container
ui_notifbox_builder.notifbox_title = function(title)
	return wibox.widget({
		widget = wibox.container.scroll.horizontal,
		step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
		speed = 50,
		rate = user.animation_rate,
		{
			markup = title ~= "" and helpers.bold_text(title) or helpers.bold_text("Empty Title"),
			font = beautiful.font_name .. " 12",
			align = "left",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		forced_height = dpi(30),
	})
end

--- Notification message container
ui_notifbox_builder.notifbox_message = function(msg)
	return wibox.widget({
		widget = wibox.container.scroll.horizontal,
		step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
		speed = 50,
		rate = user.animation_rate,
		{
			markup = msg ~= "" and msg or "Empty Message",
			font = beautiful.font_name .. " 11",
			align = "left",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		forced_height = dpi(20),
	})
end

--- Notification app name container
ui_notifbox_builder.notifbox_appname = function(app)
	return wibox.widget({
		widget = wibox.container.scroll.horizontal,
		step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
		speed = 50,
		rate = user.animation_rate,

		{
			markup = app,
			font = beautiful.font_name .. " 12",
			align = "left",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		forced_height = dpi(30),
	})
end

--- Notification actions container
ui_notifbox_builder.notifbox_actions = function(n)
	actions_template = wibox.widget({
		notification = n,
		base_layout = wibox.widget({
			spacing = dpi(0),
			layout = wibox.layout.flex.horizontal,
		}),
		widget_template = {
			{
				{
					{
						id = "text_role",
						font = beautiful.font_name .. " 10",
						widget = wibox.widget.textbox,
					},
					widget = wibox.container.place,
				},
				bg = x.color8,
				shape = gears.shape.rounded_rect,
				forced_height = dpi(30),
				widget = wibox.container.background,
			},
			margins = dpi(4),
			widget = wibox.container.margin,
		},
		style = { underline_normal = false, underline_selected = true },
		widget = naughty.list.actions,
	})

	helpers.add_hover_cursor(actions_template, "hand1")
	return actions_template
end

--- Notification dismiss button
ui_notifbox_builder.notifbox_dismiss = function()
	local dismiss_textbox = wibox.widget({
		{
			id = "dismiss_icon",
			font = "JetBrainsMono Nerd Font 10",
			markup = helpers.colorize_text("", x.color1),
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.fixed.horizontal,
	})

	local notifbox_dismiss = wibox.widget({
		{
			dismiss_textbox,
			margins = dpi(5),
			widget = wibox.container.margin,
		},
		visible = false,
		bg = x.color8,
		shape = gears.shape.circle,
		widget = wibox.container.background,
	})

	helpers.add_hover_cursor(notifbox_dismiss, "hand1")
	return notifbox_dismiss
end

return ui_notifbox_builder
