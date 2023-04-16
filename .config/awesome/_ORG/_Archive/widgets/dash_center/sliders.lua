local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local currentVolIcon = "ﱝ"
local currentBriIcon

local active_color_vol = {
    type = 'linear',
    from = {0, 0},
    to = {dpi(375)},
    stops = {{0, x.color6}, {0.50, x.color4}}
}

local active_color_bri = {
    type = 'linear',
    from = {0, 0},
    to = {dpi(375)},
    stops = {{0, x.color11}, {0.50, x.color3}}
}

----------------------
-- Volume

local volume_bar = wibox.widget({
	max_value = 100,
	value = 50,
	forced_height = dpi(10),
	margins = {
		top = dpi(8),
		bottom = dpi(8),
	},
	forced_width = dpi(375),
	shape = gears.shape.rounded_bar,
	bar_shape = gears.shape.rounded_bar,
	color = active_color_vol,
	background_color = x.color0,
	border_width = 0,
	border_color = beautiful.border_color,
	widget = wibox.widget.progressbar,
})

local volume_icon = wibox.widget({
	widget = wibox.widget.textbox,
	markup = currentVolIcon,
	font = "JetBrainsMono Nerd Font 16",
	align = "center",
	valign = "center",
	resize = true,
})

local volume_text = wibox.widget({
	widget = wibox.widget.textbox,
	markup = "0%",
	font = beautiful.font_name .. " 12",
	align = "center",
	valign = "center",
	resize = true,
})

local volume_cont = wibox.widget({
	volume_icon,
	volume_bar,
	volume_text,
	forced_width = beautiful.dash_center_width - dpi(55),
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal,
})

---------------------------
-- Brightness

local brightness_bar = wibox.widget({
	max_value = 100,
	value = 50,
	forced_height = dpi(10),
	margins = {
		top = dpi(8),
		bottom = dpi(8),
	},
	forced_width = dpi(375),
	shape = gears.shape.rounded_bar,
	bar_shape = gears.shape.rounded_bar,
	color = active_color_bri,
	background_color = x.color0,
	border_width = 0,
	border_color = beautiful.border_color,
	widget = wibox.widget.progressbar,
})

local brightness_icon = wibox.widget({
	widget = wibox.widget.textbox,
	markup = currentBriIcon,
	font = "JetBrainsMono Nerd Font 16",
	align = "center",
	valign = "center",
	resize = true,
})

local brightness_text = wibox.widget({
	widget = wibox.widget.textbox,
	markup = "0%",
	font = beautiful.font_name .. " 12",
	align = "center",
	valign = "center",
	resize = true,
})

local brightness_cont = wibox.widget({
	brightness_icon,
	brightness_bar,
	brightness_text,
	forced_width = beautiful.dash_center_width - dpi(55),
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal,
})

awesome.connect_signal("evil::volume", function(value, muted)
	if muted then
		currentVolIcon = "ﱝ"
	else
		if value <= 10 then
			currentVolIcon = ""
		elseif value <= 30 then
			currentVolIcon = ""
		elseif value <= 60 then
			currentVolIcon = "墳"
		elseif value <= 90 then
			currentVolIcon = ""
		else
			currentVolIcon = ""
		end
	end
	volume_text.markup = tostring(value) .. "%"
	volume_icon.markup = currentVolIcon
	volume_bar.value = value
end)

awesome.connect_signal("evil::brightness", function(value, muted)
	if muted then
		currentBriIcon = ""
	else
		if value <= 30 then
			currentBriIcon = ""
		elseif value <= 50 then
			currentBriIcon = ""
		elseif value <= 80 then
			currentBriIcon = ""
		else
			currentBriIcon = ""
		end
	end
	brightness_text.markup = tostring(value) .. "%"
	brightness_icon.markup = currentBriIcon
	brightness_bar.value = value
end)

return wibox.widget({
	{
		nil,
		volume_cont,
		layout = wibox.layout.align.horizontal,
		expand = "none",
	},
	{
		nil,
		brightness_cont,
		layout = wibox.layout.align.horizontal,
		expand = "none",
	},

	spacing = dpi(20),
	layout = wibox.layout.fixed.vertical,
})
