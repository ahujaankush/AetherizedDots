local bling = require("modules.bling")
local rubato = require("modules.rubato") -- Totally optional, only required if you are using animations.

screen.connect_signal("request::desktop_decoration", function(s)
	-- These are example rubato tables. You can use one for just y, just x, or both.
	-- The duration and easing is up to you. Please check out the rubato docs to learn more.
	s.term_scratchpad_anim_y = rubato.timed({
		pos = s.geometry.y - s.geometry.height * 0.5,
		easing = rubato.easing.quadratic,
		rate = user.animation_rate,
		intro = 0.25,
		duration = 0.5,
		awestore_compat = true, -- This option must be set to true.
	})

	s.term_scratchpad = bling.module.scratchpad({
		command = "kitty --class spad", -- How to spawn the scratchpad
		rule = { instance = "spad" }, -- The rule that the scratchpad will be searched by
		sticky = true, -- Whether the scratchpad should be sticky
		autoclose = true, -- Whether it should hide itself when losing focus
		floating = true, -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
		geometry = { x = 0, y = s.geometry.y, height = s.geometry.height * 0.5, width = s.geometry.width }, -- The geometry in a floating state
		reapply = true, -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
		dont_focus_before_close = true, -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
		rubato = { y = s.term_scratchpad_anim_y }, -- Optional. This is how you can pass in the rubato tables for animations. If you don't want animations, you can ignore this option.
	})
end)
