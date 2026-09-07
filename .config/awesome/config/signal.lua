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
local focus_sta = require("function.table")
-- {{{ --------------------------------------------------------------Signals
--
-- ----------------------
-- 指定的tag不产生urgent
-- ----------------------
local no_urgent_class = {
	v2rayN = true,
	["clash-verge"] = true,
	["mihomo-party"] = true,
}
client.connect_signal("property::urgent", function(c)
	if c.class and no_urgent_class[c.class] then
		c.urgent = false
	end
end)

client.connect_signal("manage", function(c)
	local class = c.class
	if c.class == "Chromium" or c.class == "chromium" then
		gears.timer.delayed_call(function()
			if c.valid then
				c.floating = true
				c.maximized = false
				c.fullscreen = false

				c:geometry({
					width = 1500,
					height = 1000,
				})

				awful.placement.centered(c, {
					honor_workarea = true,
					honor_padding = true,
				})
			end
		end)
	end
	-- Emacs
	if c.class == "Emacs" or c.class == "emacs" then
		gears.timer.delayed_call(function()
			if c.valid then
				c.floating = true

				c:geometry({
					width = 1400,
					height = 900,
				})

				awful.placement.centered(c)
			end
		end)
	end
	-- libreoffice
	if
		c.class == "libreoffice"
		or c.class == "LibreOffice"
		or c.class == "libreOffice-startcenter"
		or c.class == "libreoffice-writer"
		or c.class == "libreoffice-calc"
	then
		gears.timer.delayed_call(function()
			if c.valid then
				c.floating = true
				c.maximized = false
				c.fullscreen = false

				c:geometry({
					width = 1500,
					height = 1000,
				})

				awful.placement.centered(c)
			end
		end)
	end
end)

-- ----------------------------
-- Enable sloppy focus, so that focus follows mouse.
-- 鼠标移到窗口不自动获取焦点（需要点击）
-- ----------------------------
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

client.connect_signal("focus", function(c)
	local t = c.screen.selected_tag

	if t then
		focus_sta.tag_last_focus[t] = c
	end
end)
-- }}}
