local wibox = require("wibox")
local helpers = require("helpers")
local awful = require("awful")
local colorMod = require("modules.color")
local currentIcon = ""
local color = x.color15

-- the icon itself
local brightness_icon = wibox.widget({
	widget = wibox.widget.textbox,
	markup = helpers.colorize_text(currentIcon, color),
	font = "JetBrainsMono Nerd Font 12",
	align = "center",
	valign = "center",
	resize = true,
})

-- arcchart with brightness icon
local brightness_arcchart = wibox.widget({
	brightness_icon,
	max_value = 100,
	rounded_edge = true,
	thickness = dpi(4.5),
	start_angle = 4.71238898,
	bg = x.color0,
	widget = wibox.container.arcchart,
})

-- tooltip
local brightness_icon_tooltip = awful.tooltip({})
brightness_icon_tooltip.preferred_alignments = { "middle", "front", "back" }
brightness_icon_tooltip.mode = "outside"
brightness_icon_tooltip:add_to_object(brightness_arcchart)
brightness_icon_tooltip.markup = helpers.colorize_text("0", color)

local color1 = colorMod.color({ hex = x.color3 })
local color2 = colorMod.color({ hex = x.color11 })
local transitionFunc = colorMod.transition(color1, color2)
local currentColor = color1

awesome.connect_signal("evil::brightness", function(value, muted)
	if muted then
		currentIcon = ""
	else
		if value <= 30 then
			currentIcon = ""
		elseif value <= 50 then
			currentIcon = ""
		elseif value <= 80 then
			currentIcon = ""
		else
			currentIcon = ""
		end
	end
	brightness_arcchart:set_value(value)
	currentColor = transitionFunc(value / 100)
	brightness_arcchart.colors = { currentColor.hex }
	brightness_icon.markup = helpers.colorize_text(currentIcon, color)
	brightness_icon_tooltip.markup = helpers.colorize_text(value, color)
end)

return brightness_arcchart
