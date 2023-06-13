local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local color = require("modules.color")
local rubato = require("modules.rubato")
local helpers = require("helpers")

local stroke = x.background
local happy_color = color.color({ hex = x.color2 })
local sad_color = color.color({ hex = x.color1 })
local ok_color = color.color({ hex = x.color3 })
local charging_color = color.color({ hex = x.color4 })

local battery_bar = wibox.widget({
	max_value = 100,
	value = 50,
	forced_width = dpi(100),
	bar_shape = gears.shape.rectangle,
	color = happy_color.hex,
	background_color = happy_color.hex .. "55",
	widget = wibox.widget.progressbar,
})

local charging_icon = wibox.widget({
	font = "Material Icons 15",
	align = "left",
	valign = "center",
	markup = helpers.colorize_text("", stroke .. "80"),
	widget = wibox.widget.textbox(),
})

local current_precentage = wibox.widget({
	font = beautiful.font_name .. " 12",
	align = "center",
	valign = "center",
	markup = helpers.colorize_text(helpers.bold_text("50%"), stroke .. "80"),
	widget = wibox.widget.textbox(),
})

local battery_bar_container = wibox.widget({
	{
		battery_bar,
		shape = helpers.rrect(beautiful.border_radius),
		widget = wibox.container.background,
	},
	current_precentage,
	charging_icon,
	layout = wibox.layout.stack,
})
local last_value = 100
local last_color = happy_color
local current_color = happy_color
local transitionFunc = color.transition(last_color, current_color)
local easing = rubato.timed({
	pos = 0,
	duration = 0.5,
	rate = user.animation_rate,
	intro = 0.25,
	outro = 0.25,
	easing = rubato.easing.quadratic,
	subscribed = function(pos)
		battery_bar.color = transitionFunc(pos).hex
		battery_bar.background_color = transitionFunc(pos).hex .. "44"
	end,
})

awesome.connect_signal("evil::battery", function(value)
	current_precentage.markup = helpers.colorize_text(helpers.bold_text(value .. "%"), stroke .. "80")
	-- Update bar
	battery_bar.value = value
	last_value = value
	last_color = current_color
	-- Update face
	if charging_icon.visible then
		current_color = charging_color
	elseif value <= user.battery_threshold_low then
		current_color = sad_color
	elseif value <= user.battery_threshold_ok then
		current_color = ok_color
	else
		current_color = happy_color
	end

	if current_color ~= last_color then
		transitionFunc = color.transition(last_color, current_color)
		easing = rubato.timed({
			pos = 0,
			duration = 0.5,
			rate = user.animation_rate,
			intro = 0,
			outro = 0,
			easing = rubato.easing.zero,
			subscribed = function(pos)
				battery_bar.color = transitionFunc(pos).hex
				battery_bar.background_color = transitionFunc(pos).hex .. "44"
			end,
		})
		easing.target = 1
	end
end)

awesome.connect_signal("evil::charger", function(plugged)
	last_color = current_color
	charging_icon.visible = false
	if plugged then
		charging_icon.visible = true
		current_color = charging_color
	elseif last_value <= user.battery_threshold_low then
		current_color = sad_color
	elseif last_value <= user.battery_threshold_ok then
		current_color = ok_color
	else
		current_color = happy_color
	end

	transitionFunc = color.transition(last_color, current_color)
	easing = rubato.timed({
		pos = 0,
		duration = 0.5,
		rate = user.animation_rate,
		intro = 0.25,
		outro = 0.25,
		easing = rubato.easing.quadratic,
		subscribed = function(pos)
			battery_bar.color = transitionFunc(pos).hex
			battery_bar.background_color = transitionFunc(pos).hex .. "44"
		end,
	})
	easing.target = 1
end)

return battery_bar_container
