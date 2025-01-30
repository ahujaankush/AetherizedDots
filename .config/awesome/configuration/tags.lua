local awful = require("awful")

--- Tags
--- ~~~~

local tags = { "1", "2", "3", "4", "5" }

screen.connect_signal("request::desktop_decoration", function(s)
  --- Each screen has its own tag table.
  awful.tag(tags, s, awful.layout.layouts[1])
end)
