-- Monitoring
require("daemon.cpu")
require("daemon.ram")
require("daemon.temperature")
require("daemon.battery")
require("daemon.disk")

-- User controlled

require("daemon.volume")
require("daemon.microphone")
require("daemon.brightness")
require("daemon.bluetooth")

-- Internet access required
-- Note: These daemons use a temp file to store the retrieved values in order
-- to check its modification time and decide if it is time to update or not.
-- No need to worry that you will be updating too often when restarting AwesomeWM :)
-- This is useful because some APIs have a limit on the number of calls per hour.
require("daemon.coronavirus")
require("daemon.weather")
