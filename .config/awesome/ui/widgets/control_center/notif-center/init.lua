local wibox = require("wibox")
local beautiful = require("beautiful")
local button = require("ui.widgets.notif-button")
local notif_core = require("ui.widgets.control_center.notif-center.build-notifbox")

local notif_header = wibox.widget({
	markup = "Notification Center",
	font = beautiful.font_name .. " 15",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})

local delete_button = button.create_image_onclick(beautiful.clear_grey_icon, beautiful.clear_icon, function()
	notif_core.reset_notifbox_layout()
end)

local delete_button_wrapped = wibox.widget({
	nil,
	{
		delete_button,
		widget = wibox.container.background,
		forced_height = dpi(28),
		forced_width = dpi(28),
	},
	nil,
	expand = "none",
	layout = wibox.layout.align.vertical,
})

return wibox.widget({
	{
		notif_header,
		nil,
    delete_button_wrapped,
		expand = "none",
		spacing = dpi(20),
		layout = wibox.layout.align.horizontal,
	},
	spacing = dpi(20),
	notif_core.notifbox_layout,
	layout = wibox.layout.fixed.vertical,
})
