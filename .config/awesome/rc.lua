-- contain these module:
--                      [ Error handling ]
--                      [ Variable definitions ]
--                      [ Gui ]
--                      [ Keys ]
--                      [ Rules ]
--                      [ Signals ]
pcall(require, "luarocks.loader")

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

-- -------------------------------------------------------------------------------------
-- {{{                                                                    Error handling
-- -------------------------------------------------------------------------------------
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- -------------------------------------------------------------------------------------
-- {{{                                                              Variable definitions
-- -------------------------------------------------------------------------------------
-- Themes define colours, icons, font and wallpapers.

-- This is used later as the default terminal and editor to run.
terminal = "wezterm"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " start -- " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- }}}

-- -------------------------------------------------------------------------------------
-- {{{                                                    Autostart windowless processes
-- -------------------------------------------------------------------------------------

-- This function will run once every time Awesome is started
local function run_once(process, cmd)
	cmd = cmd or process
	awful.spawn.with_shell(string.format("pgrep -x '%s' > /dev/null || %s", process, cmd))
end

run_once("picom", "picom --config ~/.config/picom/picom.conf")
run_once("clash-verge","sudo env WEBKIT_DISABLE_DMABUF_RENDERER=1 $(which clash-verge)")
run_once("emacs","emacs")
run_once("chromium","chromium")
run_once("wezterm-gui", "wezterm start -- tmux")
-- run_once("feh","feh --randomize --bg-fill ~/wallpapers")
-- }}}

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.font = "Victor Mono Nerd Font Mono Regular 13"

colors = {
	charcoal = "#151918",
	charcoal2 = "#1c211f",
	charcoal3 = "#242a26",

	cream = "#eee7d0",
	cream_soft = "#d8d0b8",
	cream_bright = "#fff6df",

	muted = "#8f9187",
	muted_dark = "#6f746d",

	border = "#3a403c",
	border_soft = "#15191833",
	-- border_focus = "#aaa48f",
	border_focus = "#8f9187",

	gold = "#d8b46a",
	sage = "#87996f",
	sage_light = "#a7b88c",
	blue = "#8fa6a0",
	mauve = "#b89cae",
	rust = "#c47f5f",

	user_bg = "#32302f",
	transparent = "#00000000",
}
c = colors

beautiful.bg_normal = c.charcoal
beautiful.bg_focus = c.cream
beautiful.bg_urgent = c.rust

beautiful.fg_normal = c.cream
beautiful.fg_focus = c.charcoal
beautiful.fg_urgent = c.charcoal

beautiful.border_width = 0
beautiful.border_normal = c.border
beautiful.border_focus = c.border_focus
beautiful.border_marked = c.gold

beautiful.useless_gap = 12
beautiful.gap_single_client = true

beautiful.taglist_squares_sel = nil
beautiful.taglist_squares_unsel = nil

beautiful.taglist_bg_focus = c.blue
beautiful.taglist_fg_focus = c.charcoal

beautiful.taglist_bg_occupied = c.transparent
beautiful.taglist_fg_occupied = c.cream_soft

beautiful.taglist_bg_empty = c.transparent
beautiful.taglist_fg_empty = c.border_focus

beautiful.taglist_bg_urgent = c.gold
beautiful.taglist_fg_urgent = c.charcoal

beautiful.tasklist_bg_focus = c.blue
beautiful.tasklist_bg_normal = c.user_bg

require("function.menu")
require("function.calendar")
require("function.net-speed")
require("function.dis-keybind")

require("config.gui")
require("config.key")
require("config.rule")
require("config.signal")
