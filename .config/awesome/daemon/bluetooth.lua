-- Provides:
-- evil::brightness
--      percentage (integer)
local awful = require("awful")
local gears = require("gears")
-- Subscribe to backlight changes
-- Requires inotify-tools

local bluetooth_script = [[bash -c "
  bluetoothctl show | grep Powered: | cut -d ' ' -f 2
"]]

local emit_bluetooth_info = function()
	awful.spawn.with_line_callback(bluetooth_script, {
		stdout = function(line)
			awesome.emit_signal("evil::bluetooth", line:match("yes") and true or false)
		end,
	})
end

-- Run once to initialize widgets
emit_bluetooth_info()

gears.timer({
	timeout = 1,
	call_now = true,
	autostart = true,
	callback = function()
		emit_bluetooth_info()
	end,
})
