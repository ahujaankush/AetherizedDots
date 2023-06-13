local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

local empty_notifbox = require("ui.widgets.control_center.notif-center.build-notifbox.empty-notifbox")

local notif_core = {}
local width = dpi(500)
notif_core.remove_notifbox_empty = true

notif_core.notifbox_layout = wibox.widget({
	layout = require("modules.overflow").vertical,
	scrollbar_width = dpi(4),
	spacing = 7,
	scroll_speed = 1,
})
notif_core.notifbox_layout.forced_width = width
notif_core.notifbox_layout:insert(1, empty_notifbox)

notif_core.reset_notifbox_layout = function()
	notif_core.notifbox_layout:reset()
	notif_core.notifbox_layout:insert(1, empty_notifbox)
	notif_core.remove_notifbox_empty = true
end

local notifbox_add = function(n, notif_icon, notifbox_color)
	if #notif_core.notifbox_layout.children == 1 and notif_core.remove_notifbox_empty then
		notif_core.notifbox_layout:reset(notif_core.notifbox_layout)
		notif_core.remove_notifbox_empty = false
	end

	local notifbox_box = require("ui.widgets.control_center.notif-center.build-notifbox.notifbox-builder")
	notif_core.notifbox_layout:insert(1, notifbox_box(n, notif_icon, n.title, n.message, n.app_name, notifbox_color))
end

naughty.connect_signal("request::display", function(n)
	local notifbox_color = colors.transparent

	local notif_icon = n.icon or n.app_icon
	if not notif_icon then
		notif_icon = beautiful.theme_assets.awesome_icon(24, x.color0, x.color0)
	end

	notifbox_add(n, notif_icon, notifbox_color)
end)

return notif_core
