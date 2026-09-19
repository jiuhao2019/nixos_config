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
-- {{{ Menu
-- Create a launcher widget and a main menu
local current_menu = nil
myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "config", editor_cmd .. " " .. awesome.conffile },
	{ "reload", awesome.restart },
	{
		"logout",
		function()
			awesome.quit()
		end,
	},
}

local menu_awesome =
	{ "awesome", myawesomemenu, "/home/microvee/Downloads/deploy-linux/.config/awesome/awesome-icon.png" }
local menu_terminal = { "terminal", terminal }

mymainmenu = awful.menu({
	items = {
		menu_awesome,
		menu_terminal,
	},
})

mylauncher = awful.widget.launcher({
	image = "/home/microvee/Downloads/deploy-linux/.config/awesome/widgets_24dp_E3E3E3_FILL0_wght400_GRAD0_opsz24.svg",
	menu = mymainmenu,
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
