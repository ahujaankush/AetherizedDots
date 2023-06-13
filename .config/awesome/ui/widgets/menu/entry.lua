local beautiful = require("beautiful")
local helpers = require("helpers")
local wibox = require("wibox")
local colorMod = require("modules.color")
local rubato = require("modules.rubato")

local bg = colorMod.color({ hex = beautiful.menu_bg_normal })
local bg_hover = colorMod.color({ hex = beautiful.menu_bg_focus })

return function(args)
	local entry = {}
	function entry:new()
		self.bg = bg
		self.bg_hover = bg_hover
		self.icon = args.icon
		self.text = args.text
		self.submenu_icon = beautiful.menu_submenu_icon
		self.press_func = args.press_func
		self.transition = colorMod.transition(self.bg, self.bg, colorMod.transition.HSLA)
		self.submenu_parent = args.submenu_parent or false
		self.submenu = args.submenu
		self.menu_pos = 0
		self.container = wibox.widget({
			{
				{
					{
						{
							markup = self.icon,
							font = beautiful.menu_icon_font,
							align = "left",
							valign = "center",
							widget = wibox.widget.textbox,
						},
						{
							markup = helpers.colorize_text(self.text, beautiful.menu_fg_normal),
							font = beautiful.menu_text_font,
							align = "left",
							valign = "center",
							widget = wibox.widget.textbox,
						},
						layout = wibox.layout.fixed.horizontal,
						spacing = dpi(10),
					},
					nil,
					{
						markup = self.submenu_parent
								and helpers.colorize_text(self.submenu_icon, beautiful.menu_fg_normal)
							or "",
						font = beautiful.menu_submenu_icon_font,
						align = "right",
						valign = "center",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.align.horizontal,
				},
				margins = {
					left = dpi(10),
					right = dpi(10),
				},
				widget = wibox.container.margin,
			},

			forced_height = beautiful.menu_height,
			bg = self.bg.hex,
			shape = helpers.rrect(beautiful.menu_radius),
			widget = wibox.container.background,
		})

		self.transition = colorMod.transition(self.bg, self.bg_hover)
		self.transitionFunc = rubato.timed({
			pos = 0,
			duration = 0.15,
			rate = user.animation_rate,
			intro = 0.075,
			outro = 0.075,
			easing = rubato.easing.zero,
			subscribed = function(pos)
				self.container:set_bg(self.transition(pos).hex)
			end,
		})

		self.container:connect_signal("mouse::enter", function()
			self.transitionFunc.target = 1
			if self.submenu_parent then
				self.submenu:show({
					x = self.parent_menu.menu_popup.x + beautiful.menu_width,
					y = self.parent_menu.menu_popup.y + self.menu_pos,
				})
			end
		end)

		self.container:connect_signal("mouse::leave", function()
			self.transitionFunc.target = 0
			if self.submenu_parent then
				self.submenu:hide()
			end
		end)

		self.container:connect_signal("button::press", function()
			self.press_func()
		end)

		function self:set_parent(parent)
			self.parent_menu = parent
		end
	end

	entry:new()
	return entry
end
