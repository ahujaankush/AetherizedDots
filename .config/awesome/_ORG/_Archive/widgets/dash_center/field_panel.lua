local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local naughty = require("naughty")
local apps = require("apps")
local helpers = require("helpers")
local colorMod = require("modules.color")
local rubato = require("modules.rubato")

-- define colors for smooth fading
local active = colorMod.color({hex = x.color0})
local inactive = colorMod.color({hex = x.color7})
local hover = colorMod.color({hex = x.color8})
local networkColor = active
local bluetoothColor = active
local audioColor = active
local notificationsColor = active
local screenshotColor = active
local bluelightColor = inactive

local aud_inner = wibox.widget({
	{
		id = "aud",
		widget = wibox.widget.textbox,
		font = "JetBrainsMono Nerd Font 26",
		markup = helpers.colorize_text("墳", x.foreground),
		halign = "center",
		align = "center",
		forced_height = dpi(75),
	},
	fg = x.foreground,
	bg = audioColor.hex,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
})

local aud_cont = wibox.widget({
	aud_inner,
	{
		markup = "Audio",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	},
	spacing = dpi(6),
	layout = wibox.layout.fixed.vertical,
})

aud_inner:connect_signal("mouse::enter", function()
	aud_inner:set_bg(x.color8)
end)

aud_inner:connect_signal("mouse::leave", function()
	aud_inner:set_bg(x.color0)
end)

aud_inner:connect_signal("button::press", function()
	helpers.volume_control(0)
end)

awesome.connect_signal("evil::volume", function(value, muted)
	if muted then
		aud_inner:get_children_by_id("aud")[1].markup = helpers.colorize_text("ﱝ", x.color7)
	else
		aud_inner:get_children_by_id("aud")[1].markup = helpers.colorize_text("墳", x.foreground)
	end
end)

-- bluetooth is on (std)
local bluetooth_status = true

local blu_inner = wibox.widget({
	{
		id = "blu",
		widget = wibox.widget.textbox,
		font = "JetBrainsMono Nerd Font 26",
		markup = helpers.colorize_text("", x.foreground),
		halign = "center",
		align = "center",
		forced_height = dpi(80),
		forced_width = dpi(150),
	},
	fg = x.foreground,
	bg = x.color0,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
})

local blu_cont = wibox.widget({
	blu_inner,
	{
		markup = "Bluetooth",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	},
	spacing = dpi(6),
	layout = wibox.layout.fixed.vertical,
})

blu_inner:connect_signal("mouse::enter", function()
	blu_inner:set_bg(x.color8)
end)

blu_inner:connect_signal("mouse::leave", function()
	blu_inner:set_bg(x.color0)
end)

blu_inner:connect_signal("button::press", function()
	if bluetooth_status then
		awful.spawn.with_shell("bluetoothctl power off")
		blu_inner:get_children_by_id("blu")[1].markup = helpers.colorize_text("", x.color7)
	else
		awful.spawn.with_shell("bluetoothctl power on")
		blu_inner:get_children_by_id("blu")[1].markup = helpers.colorize_text("", x.foreground)
	end
	bluetooth_status = not bluetooth_status
end)

-- network is on (std)
local network_status = true

local net_inner = wibox.widget({
	{
		id = "net",
		widget = wibox.widget.textbox,
		font = "JetBrainsMono Nerd Font 26",
		markup = helpers.colorize_text("", x.foreground),
		halign = "center",
		align = "center",
		forced_height = dpi(80),
		forced_width = dpi(150),
	},
	fg = x.foreground,
	bg = x.color0,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
})

local net_cont = wibox.widget({
	net_inner,
	{
		markup = "Network",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	},
	spacing = dpi(6),
	layout = wibox.layout.fixed.vertical,
})

net_inner:connect_signal("mouse::enter", function()
	net_inner:set_bg(x.color8)
end)

net_inner:connect_signal("mouse::leave", function()
	net_inner:set_bg(x.color0)
end)

net_inner:connect_signal("button::press", function()
	if network_status then
		awful.spawn.with_shell("nmcli radio wifi off")
		net_inner:get_children_by_id("net")[1].markup = helpers.colorize_text("睊", x.color7)
	else
		awful.spawn.with_shell("nmcli radio wifi on")
		net_inner:get_children_by_id("net")[1].markup = helpers.colorize_text("", x.foreground)
	end
	network_status = not network_status
end)

local not_inner = wibox.widget({
	{
		id = "not",
		widget = wibox.widget.textbox,
		font = "JetBrainsMono Nerd Font 26",
		markup = helpers.colorize_text("", x.foreground),
		halign = "center",
		align = "center",
		forced_height = dpi(80),
		forced_width = dpi(150),
	},
	fg = x.foreground,
	bg = x.color0,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
})

local not_cont = wibox.widget({
	not_inner,
	{
		markup = "Notifications",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	},
	spacing = dpi(6),
	layout = wibox.layout.fixed.vertical,
})

not_inner:connect_signal("mouse::enter", function()
	not_inner:set_bg(x.color8)
end)

not_inner:connect_signal("mouse::leave", function()
	not_inner:set_bg(x.color0)
end)

not_inner:connect_signal("button::press", function()
	naughty.suspended = not naughty.suspended
	if naughty.suspended then
		not_inner:get_children_by_id("not")[1].markup = helpers.colorize_text("", x.foreground)
	else
		not_inner:get_children_by_id("not")[1].markup = helpers.colorize_text("", x.color7)
	end
end)

local scr_inner = wibox.widget({
	{
		id = "not",
		widget = wibox.widget.textbox,
		font = "JetBrainsMono Nerd Font 26",
		markup = helpers.colorize_text("", x.foreground),
		halign = "center",
		align = "center",
		forced_height = dpi(80),
		forced_width = dpi(150),
	},
	fg = x.foreground,
	bg = x.color0,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
})


local scr_cont = wibox.widget({
	scr_inner,
	{
		markup = "Screenshot",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	},
	spacing = dpi(6),
	layout = wibox.layout.fixed.vertical,
})

scr_inner:connect_signal("mouse::enter", function()
	scr_inner:set_bg(x.color8)
end)

scr_inner:connect_signal("mouse::leave", function()
	scr_inner:set_bg(x.color0)
end)

scr_inner:connect_signal("button::press", function()
	apps.screenshot("full")
end)

local bluelight_status = false

local lig_inner = wibox.widget({
	{
		id = "lig",
		widget = wibox.widget.textbox,
		font = "JetBrainsMono Nerd Font 26",
		markup = helpers.colorize_text("", x.foreground),
		halign = "center",
		align = "center",
		forced_height = dpi(80),
		forced_width = dpi(150),
	},
	fg = x.foreground,
	bg = x.color0,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
})

local lig_cont = wibox.widget({
	lig_inner,
	{
		markup = "Bluelight",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	},
	spacing = dpi(6),
	layout = wibox.layout.fixed.vertical,
})

lig_inner:connect_signal("mouse::enter", function()
	lig_inner:set_bg(x.color8)
end)

lig_inner:connect_signal("mouse::leave", function()
	lig_inner:set_bg(x.color0)
end)

lig_inner:connect_signal("button::press", function()
	if bluelight_status then
		lig_inner:get_children_by_id("lig")[1].markup = helpers.colorize_text("", x.color7)
		apps.night_mode("off")
	else
		lig_inner:get_children_by_id("lig")[1].markup = helpers.colorize_text("", x.foreground)
		apps.night_mode("on")
	end
	bluelight_status = not bluelight_status
end)

return wibox.widget({
	{
		net_cont,
		blu_cont,
		aud_cont,
		not_cont,
		scr_cont,
		lig_cont,
		homogeneous = true,
    expand = true,
		forced_num_cols = 3,
		forced_num_rows = 2,
		spacing = dpi(20),
		layout = wibox.layout.grid,
	},
  widget = wibox.container.margin,
  margins = {
    left = dpi(20),
    right = dpi(20)
  }
})
