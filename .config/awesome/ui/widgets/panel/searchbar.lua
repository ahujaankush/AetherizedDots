local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local helpers = require("helpers")
local rubato = require("modules.rubato")

local search_icon = wibox.widget({
	font = "icomoon bold 12",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox(),
})

local reset_search_icon = function()
	search_icon.markup = helpers.colorize_text("", x.color5)
end
reset_search_icon()

local search_text = wibox.widget({
	markup = helpers.colorize_text("Search", x.foreground),
	align = "center",
	valign = "center",
	font = beautiful.prompt_font,
	widget = wibox.widget.textbox(),
})

local search = wibox.widget({
	{
		{
			search_icon,
			{
				search_text,
				margins = {
					left = dpi(5),
				},
				widget = wibox.container.margin,
			},
			layout = wibox.layout.fixed.horizontal,
		},
		left = dpi(10),
		widget = wibox.container.margin,
	},
	forced_width = dpi(95),
	shape = helpers.rrect(beautiful.border_radius),
	bg = x.color0,
	widget = wibox.container.background(),
})

local anim_w = rubato.timed({
	pos = dpi(95),
	duration = 0.4,
	intro = 0.2,
	outro = 0.2,
  rate = user.animation_rate,
	easing = rubato.easing.quadratic,
	subscribed = function(pos)
		search.forced_width = pos
	end,
})

local function generate_prompt_icon(icon, color)
	return "<span font='icomoon bold 12' foreground='" .. color .. "'>" .. icon .. "</span> "
end

function searchbar_activate_prompt(action)
	search_icon.visible = false
	anim_w.target = dpi(225)
	local prompt
	if action == "run" then
		prompt = generate_prompt_icon("", x.color1)
	elseif action == "web_search" then
		prompt = generate_prompt_icon("", x.color4)
	end
	helpers.prompt(action, search_text, prompt, function()
		search_text.markup = helpers.colorize_text("Search", x.foreground)
		search_icon.visible = true
		anim_w.target = dpi(95)
	end)
end

search:buttons(gears.table.join(
	awful.button({}, 1, function()
		searchbar_activate_prompt("run")
	end),
	awful.button({}, 3, function()
		searchbar_activate_prompt("web_search")
	end)
))

return search
