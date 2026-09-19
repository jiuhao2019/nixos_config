
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

require("awful.autofocus")
local wibox = require("wibox")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local calendar_widget = require("calendar-widget")
local tables = require("function.table")
-- ...
-- Create a textclock widget
tables.my_text_clock = wibox.widget.textclock("%H:%M:%S",1)
-- default
-- local cw = calendar_widget()
-- or customized
local cw = calendar_widget({
	theme = "nord",
	placement = "top_right",
	start_sunday = true,
	radius = 8,
	-- with customized next/previous (see table above)
	previous_month_button = 4,
	next_month_button = 5,
})
tables.my_text_clock:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)
