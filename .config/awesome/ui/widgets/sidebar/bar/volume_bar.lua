local gears = require("gears")
local wibox = require("wibox")

-- Set colors
local active_color = {
	type = "linear",
	from = { 0, 0 },
	to = { 100 }, -- replace with w,h later
	stops = { { 0, x.color4 }, { 0.50, x.color6 } },
}
local active_background_color = active_color or "#222222"
local muted_background_color = "#222222"

local volume_bar = wibox.widget({
	forced_height = dpi(100),
	forced_width = dpi(5),
	shape = gears.shape.rounded_bar,
	bg = active_background_color,
	widget = wibox.container.background,
})

awesome.connect_signal("evil::volume", function(volume, muted)
	local bg_color
	if muted then
		bg_color = muted_background_color
	else
		bg_color = active_background_color
	end
	volume_bar.forced_height = dpi(volume)
	volume_bar.bg = bg_color
end)

return volume_bar
