local gears = require("gears")
local wibox = require("wibox")

-- Set colors
local active_color = {
	type = "linear",
	from = { 0, 0 },
	to = { 100 }, -- replace with w,h later
	stops = { { 0, x.color3 }, { 0.50, x.color11 } },
}

local brightness_bar = wibox.widget({
	forced_height = dpi(100),
	forced_width = dpi(5),
	shape = gears.shape.rounded_bar,
	bg = active_color,
	widget = wibox.container.background,
})

awesome.connect_signal("evil::brightness", function(value)
	brightness_bar.forced_height = dpi(value)
end)

return brightness_bar
