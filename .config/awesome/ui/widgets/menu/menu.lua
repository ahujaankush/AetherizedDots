local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local rubato = require("modules.rubato")

return function(args)
	local menu = {}
	function menu:new()
		self.menu_popup_height = 2 * beautiful.menu_border_width - beautiful.menu_spacing

		self.layout_widget = wibox.widget({

			spacing = dpi(5),
			layout = wibox.layout.fixed.vertical,
		})

		for i = 1, #args.entries, 1 do
			args.entries[i].menu_pos = self.menu_popup_height - beautiful.menu_border_width
			local currentEntry = args.entries[i].container or args.entries[i]
			self.layout_widget:add(currentEntry)
			self.menu_popup_height = self.menu_popup_height + currentEntry.forced_height
			self.menu_popup_height = self.menu_popup_height + beautiful.menu_spacing
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

		self.anim = rubato.timed({
			pos = 0,
			intro = 0.3,
			outro = 0.3,
			duration = 0.6,
			rate = user.animation_rate,
			easing = rubato.easing.quadratic,
			subscribed = function(pos)
				self.menu_container.forced_height = pos
			end,
		})

		self.grabber = nil
		function self:show()
			self.grabber = awful.keygrabber.run(function(_, key, event)
				if event == "release" then
					return
				end
				-- Press Escape or q or F1 to hide itf
				if key == "Escape" or key == "q" or key == "F1" then
					self:hide()
				end
			end)
			awful.placement.next_to_mouse(self.menu_popup)
			self.menu_popup.visible = true
			self.anim.target = self.menu_popup_height
		end

		function self:hide()
			--if mouse.current_wibox == self.menu_popup then
			--	return
			--end

			awful.keygrabber.stop(self.grabber)
			self.anim.target = 0
			self.timer:start()
			for i = 1, #args.entries, 1 do
				if args.entries[i].submenu ~= nil then
					args.entries[i].submenu:force_hide()
				end
			end
		end

		awesome.connect_signal("elemental::dismiss", function()
			self:hide()
		end)
	end

	menu:new()
	return menu
end
