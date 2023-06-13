local gears = require("gears")
local wibox = require("wibox")

-- Set colors
local active_color = {
	type = "linear",
	from = { 0, 0 },
	to = { 100 }, -- replace with w,h later
	stops = { { 0, x.color2 }, { 0.50, x.color14 } },
}

local cpu_bar = wibox.widget({
	forced_height = dpi(100),
	forced_width = dpi(5),
	shape = gears.shape.rounded_bar,
	bg = active_color,
	widget = wibox.container.background,
})

awesome.connect_signal("evil::cpu", function(value)
	-- Use this if you want to display usage percentage
	-- cpu_bar.value = value
	-- Use this if you want to display idle percentage
	cpu_bar.forced_height = dpi(100 - value)
end)

return cpu_bar
