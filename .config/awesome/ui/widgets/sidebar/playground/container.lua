local wibox = require("wibox")

return function(args)
	local container = {}
	function container:new()
		self.layout = wibox.widget({
			layout = require("modules.overflow").vertical,
			scrollbar_width = dpi(4),
			spacing = 7,
			scroll_speed = 1,
		})

		self.layout.forced_width = args.width
		self.layout.forced_height = args.height
	end

	function container:add(widget)
		container.layout:insert(1, widget)
	end

	container:new()

	return container
end
