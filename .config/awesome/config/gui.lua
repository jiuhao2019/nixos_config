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

-- {{{ -----------------------------------------------------------------------Gui

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),

	-- ----------------------------
	-- 例如：
	-- 当前在 tag1 的窗口。
	-- mod + 左键 tag2后：
	-- 当前窗口移动到tag2
	-- ----------------------------
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),

	-- ----------------------------
	-- 例如：
	-- 当前在 tag 1。
	-- 右键 tag 2 后：
	-- tag1 + tag2 同时显示
	-- 再右键 tag2：
	-- 取消 tag2
	-- 回到只显示 tag1
	-- 这就是 Awesome 的 multi-tag view（多 tag 同时查看）。
	-- ----------------------------
	awful.button({}, 3, awful.tag.viewtoggle),

	-- ----------------------------
	-- 例如：
	-- 当前窗口 chromium 在 tag1
	-- 按 Mod + 右键 tag2
	-- 那么 chromium 会：
	-- 同时属于 tag1 和 tag2
	-- 再按一次：
	-- 从 tag2 移除
	-- ----------------------------
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),

	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),

	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)
local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),

	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),

	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)
awful.screen.connect_for_each_screen(function(s)
	awful.tag(
		{ "⒈", "⒉", "⒊", "⒋", "⒌", "⒍", "⒎", "⒏", "⒐" },
		s,
		awful.layout.layouts[1]
	)

	gears.wallpaper.set("#32302f", s)

	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	local tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		layout = {
			spacing = 8,
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					{
						id = "icon_role",
						widget = wibox.widget.imagebox,
					},
					margins = 4,
					widget = wibox.container.margin,
				},
				{
					id = "text_role",
					widget = wibox.widget.textbox,
				},
				spacing = 6,
				layout = wibox.layout.fixed.horizontal,
			},

			left = 10,
			right = 10,
			top = 4,
			bottom = 4,
			widget = wibox.container.margin,

			id = "background_role",
			widget = wibox.container.background,

			shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, 10)
			end,
		},
	})
	local systray = wibox.widget.systray()
	local cpu_widget = require("mr_incredible_cpu_widget")
	local tables = require("function.table")
	s.mywibox = awful.wibar({ position = "top", screen = s, bg = "#32302f" })

	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			taglist,
		},
		tasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,
			tables.my_net_speed,
			systray,
			tables.my_text_clock, -- clock,
			tables.my_keybind.widget,
			cpu_widget, -- four pic to show cpu load level
			mylauncher,
		},
	})
end)
-- }}}
