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

-- {{{ -----------------------------------------------------------------Rules
awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = function(c)
				awful.placement.no_overlap(c)
				awful.placement.no_offscreen(c)
				awful.placement.centered(c)
			end,
		},
	},

	-- 默认全浮动
	{
		rule = {},
		properties = {
			floating = true,
		},
	},
	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA",
				"copyq",
				"pinentry",
			},
			class = {
				"pavucontrol",
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},
	-- tag 1~9 { "󰼏 ", "󰼐 ", "󰼑 ", "󰼒 ", "󰼓 ", "󰼔 ", "󰼕 ", "󰼖 ", "󰼗 " },
	--         { "󰲠 ", "󰲢 ", "󰲤 ", "󰲦 ", "󰲨 ", "󰲪 ", "󰲬 ", "󰲮 ", "󰲰 " },
	{
		rule = { class = "org.wezfurlong.wezterm" },
		properties = {
			size_hints_honor = false,
			screen = 1,
			tag = "⒈",
			switch_to_tags = true,
			placement = awful.placement.centered,
		},
		callback = function(c)
			local g = c.screen.workarea

			c:geometry({
				x = g.x + 700,
				y = g.y + 50,
				width = math.floor(g.width * 0.5),
				height = math.floor(g.height * 0.8),
			})
		end,
	},
	{
		rule = { class = "Chromium" },
		properties = {
			screen = 1,
			tag = "⒉",
			switch_to_tags = true,
		},
	},
	{
		rule_any = { class = { "emacs", "Emacs" } },
		properties = {
			screen = 1,
			tag = "⒊",
			switch_to_tags = true,
			size_hints_honor = false,
		},
	},
	{
		rule_any = { class = { "thunar" ,"Thunar"}, },
		properties = { screen = 1, tag = "⒋", switch_to_tags = true, placement = awful.placement.centered },
	},
	{
		rule_any = {
			class = { "LibreOffice", "libreoffice", "libreoffice-writer", "libreoffice-calc" },
		},
		properties = {
			screen = 1,
			tag = "⒌",
			switch_to_tags = true,
			size_hints_honor = false,
			floating = true,
			maximized = false,
			fullscreen = false,
		},
	},
	{
		rule = { class = "v2rayN" },
		properties = {
			screen = 1,
			tag = "⒍",
			switch_to_tags = false,
			placement = awful.placement.centered,
		},
	},
	{
		rule = { class = "mihomo-party" },
		properties = {
			screen = 1,
			tag = "⒍",
			switch_to_tags = false,
			placement = awful.placement.centered,
		},
	},
	{
		rule_any = { class = { "clash-verge" ,"Clash-verge"} },
		properties = {
			screen = 1,
			tag = "⒍",
			switch_to_tags = false,
			placement = awful.placement.centered,
		},
	},
	{
		rule = { class = "jetbrains-clion" },
		properties = {
			screen = 1,
			tag = "7",
			switch_to_tags = true,
			placement = awful.placement.centered,
		},
	},
}
-- }}}
