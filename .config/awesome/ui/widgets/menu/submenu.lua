local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local apps = require("apps")
local colorMod = require("modules.color")
local rubato = require("modules.rubato")

return function(args)
	local submenu = {}
	function submenu:new()
		self.menu_popup_height = 2 * beautiful.menu_border_width - dpi(5)

		self.layout_widget = wibox.widget({

			spacing = dpi(5),
			layout = wibox.layout.fixed.vertical,
		})

		for i = 1, #args.entries, 1 do
			args.entries[i].menu_pos = self.menu_popup_height - beautiful.menu_border_width
			local currentEntry = args.entries[i].container or args.entries[i]
			self.layout_widget:add(currentEntry)
			self.menu_popup_height = self.menu_popup_height + currentEntry.forced_height
			self.menu_popup_height = self.menu_popup_height + dpi(5)
		end

		self.menu_container = wibox.widget({
			self.layout_widget,
			forced_width = beautiful.menu_width,
			forced_height = self.menu_popup_height,
			margins = beautiful.menu_border_width,
			widget = wibox.container.margin,
		})

		self.menu_popup = awful.popup({
			widget = self.menu_container,
			visible = false,
		})

		self.menu_popup:buttons(gears.table.join( -- Left click - Hide app_drawer
			awful.button({}, 1, function()
				self:hide()
			end),
			-- Right click - Hide app_drawer
			awful.button({}, 2, function()
				self:hide()
			end),
			-- Middle click - Hide app_drawer
			awful.button({}, 2, function()
				self:hide()
			end)
		))

		self.timer = gears.timer({
			timeout = 0.6,
			single_shot = true,
			callback = function()
				self.menu_popup.visible = false
			end,
		})

		self.wait = gears.timer({
			timeout = 1,
			single_shot = true,
			callback = function()
				if mouse.current_wibox == self.menu_popup then
					return
				end

				self:force_hide()
			end,
		})

		self.anim = rubato.timed({
			pos = 0,
			intro = 0.3,
			outro = 0.3,
			duration = 0.6,
			rate = user.animation_rate,
			easing = rubato.easing.quadratic,
			subscribed = function(pos)
				self.menu_popup.maximum_height = pos
			end,
		})
	end

	function submenu:show(pos)
		self.menu_popup.x = pos.x
		self.menu_popup.y = pos.y
		self.menu_popup.visible = true
		self.anim.target = self.menu_popup_height
	end

	function submenu:hide()
		self.wait:start()
	end

	function submenu:force_hide()
		self.anim.target = 0
		self.timer:again()
	end

	awesome.connect_signal("elemental::dismiss", function()
		submenu:hide()
	end)
	submenu:new()
	return submenu
end
