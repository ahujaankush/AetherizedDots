local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local weather_temperature_symbol
if user.weather_units == "metric" then
	weather_temperature_symbol = "°C"
elseif user.weather_units == "imperial" then
	weather_temperature_symbol = "°F"
end

local weather_icon = wibox.widget.imagebox(icons.getIcon("beautyline/apps/scalable/indicator-weather.svg"))
weather_icon.resize = true
weather_icon.forced_width = 40
weather_icon.forced_height = 40

local weather_description = wibox.widget({
	markup = helpers.bold_text("Weather unavailable"),
	-- align  = 'center',
	valign = "center",
	-- font = "sans 14",
	widget = wibox.widget.textbox,
})

local weather_icons = {
	["01d"] = icons.getIcon("elenaLinebit/sun.png"),
	["01n"] = icons.getIcon("elenaLinebit/star.png"),
	["02d"] = icons.getIcon("elenaLinebit/dcloud.png"),
	["02n"] = icons.getIcon("elenaLinebit/ncloud.png"),
	["03d"] = icons.getIcon("elenaLinebit/cloud.png"),
	["03n"] = icons.getIcon("elenaLinebit/cloud.png"),
	["04d"] = icons.getIcon("elenaLinebit/cloud.png"),
	["04n"] = icons.getIcon("elenaLinebit/cloud.png"),
	["09d"] = icons.getIcon("elenaLinebit/rain.png"),
	["09n"] = icons.getIcon("elenaLinebit/rain.png"),
	["10d"] = icons.getIcon("elenaLinebit/rain.png"),
	["10n"] = icons.getIcon("elenaLinebit/rain.png"),
	["11d"] = icons.getIcon("elenaLinebit/storm.png"),
	["11n"] = icons.getIcon("elenaLinebit/storm.png"),
	["13d"] = icons.getIcon("elenaLinebit/snow.png"),
	["13n"] = icons.getIcon("elenaLinebit/snow.png"),
	["40d"] = icons.getIcon("elenaLinebit/mist.png"),
	["40n"] = icons.getIcon("elenaLinebit/mist.png"),
	["50d"] = icons.getIcon("elenaLinebit/mist.png"),
	["50n"] = icons.getIcon("elenaLinebit/mist.png"),
	["_"] = icons.getIcon("beautyline/apps/scalable/indicator-weather.svg"),
}

local weather_temperature = wibox.widget({
	text = "  ",
	-- align  = 'center',
	valign = "center",
	widget = wibox.widget.textbox,
})

awesome.connect_signal("evil::weather", function(temperature, description, icon_code)
	local icon
	if weather_icons[icon_code] then
		icon = weather_icons[icon_code]
	else
		icon = weather_icons["_"]
	end

	weather_icon.image = icon
  if description then
    weather_description.markup = helpers.bold_text(description)
    weather_temperature.markup = tostring(temperature) .. weather_temperature_symbol
  end
	-- weather_temperature.markup = temperature
end)

return wibox.widget({
	{
		{
			{
				{
					nil,
					{
						weather_icon,
						strategy = "exact",
						height = dpi(60),
						width = dpi(60),
						widget = wibox.container.constraint,
					},
					layout = wibox.layout.align.vertical,
				},
				left = dpi(15),
				right = dpi(15),
				widget = wibox.container.margin,
			},
			{
				{
					nil,
					{
						weather_description,
						weather_temperature,
						layout = wibox.layout.fixed.vertical,
					},
					nil,
					expand = "none",
					layout = wibox.layout.align.vertical,
				},
				margins = dpi(8),
				widget = wibox.container.margin,
			},
			layout = wibox.layout.align.horizontal,
		},
		top = dpi(2),
		bottom = dpi(2),
		widget = wibox.container.margin,
	},
	bg = x.color0,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
})
