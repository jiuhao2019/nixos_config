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

-- }}}
-- 比例缩放右下边框方向
local function resize_keep_current_ratio(c, delta)
	local g = c:geometry()

	local ratio = g.width / g.height

	g.width = g.width + delta
	g.height = math.floor(g.width / ratio)

	c:geometry(g)
end
-- 缩放右边框方向
local function resize_right(c, delta)
	local g = c:geometry()

	g.width = math.max(100, g.width + delta)

	c:geometry(g)
end
-- 缩放下边框方向
local function resize_bottom(c, delta)
	local g = c:geometry()

	g.height = math.max(100, g.height + delta)

	c:geometry(g)
end
-- 缩放左边框方向
local function resize_left(c, delta)
	local g = c:geometry()

	local new_width = g.width - delta

	if new_width < 100 then
		return
	end

	g.x = g.x + delta
	g.width = new_width

	c:geometry(g)
end
-- 缩放上边框方向
local function resize_top(c, delta)
	local g = c:geometry()

	local new_height = g.height - delta

	if new_height < 100 then
		return
	end

	g.y = g.y + delta
	g.height = new_height

	c:geometry(g)
end
-- {{{ ----------------------------------------------------------------Keys

globalkeys = gears.table.join(
	-- 吸附左屏幕
	awful.key({ modkey, "Shift" }, "h", function()
		local c = client.focus
		if c then
			local s = c.screen
			c:geometry({
				x = s.workarea.x,
				y = c.y,
			})
		end
	end),
	-- 吸附右屏幕
    awful.key({ modkey, "Shift" }, "l", function()
        local c = client.focus
        if c then
            local wa = c.screen.workarea
            c:geometry({
                x = wa.x + wa.width - c.width,
                y = c.y,
            })
        end
    end),

	-- 吸附上屏幕
    awful.key({ modkey, "Shift" }, "k", function()
        local c = client.focus
        if c then
            local wa = c.screen.workarea
            c:geometry({
                x = c.x,
                y = wa.y,
            })
        end
    end),

	-- 吸附下屏幕
    awful.key({ modkey, "Shift" }, "j", function()
        local c = client.focus
        if c then
            local wa = c.screen.workarea
            c:geometry({
                x = c.x,
                y = wa.y + wa.height - c.height,
            })
        end
    end),
	-- Show/hide wibox,即隐藏/显示顶部和底部的bar
	-- ---------------
	awful.key({ modkey }, "b", function()
		for s in screen do
			s.mywibox.visible = not s.mywibox.visible

			if s.mybottomwibox then
				s.mybottomwibox.visible = not s.mybottomwibox.visible
			end
		end
	end, { description = "toggle wibox", group = "awesome" }),

	awful.key({ modkey }, "y", function()
		-- awful.spawn.with_shell("/opt/v2rayn-bin/v2rayN")
		-- awful.spawn.with_shell("/opt/mihomo-party/mihomo-party")
		-- awful.spawn.with_shell("clash-verge")
		awful.spawn.with_shell("sudo env WEBKIT_DISABLE_DMABUF_RENDERER=1 $(which clash-verge)")
	end),

	awful.key({ modkey }, "Return", function()
		awful.spawn.with_shell("wezterm start -- tmux")
	end),

	awful.key({ modkey }, "r", function()
		awful.spawn.with_shell("rofi -show drun")
	end),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)

		if not client.focus then
			local c = awful.client.focus.history.get(nil, 1)
			if c then
				c:emit_signal("request::activate", "focus", { raise = true })
			end
		end
	end),

	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)

		if not client.focus then
			local c = awful.client.focus.history.get(nil, 1)
			if c then
				c:emit_signal("request::activate", "focus", { raise = true })
			end
		end
	end),

	awful.key({ modkey }, "q", function()
		if client.focus then
			client.focus:kill()
		end
	end),
	awful.key({ modkey }, "Tab", function()
		local s = awful.screen.focused()

		awful.tag.viewnext(s)

		local t = s.selected_tag
		local c = focus_sta.tag_last_focus[t]

		if c and c.valid then
			client.focus = c
			c:raise()
		end
	end),
	awful.key({ modkey, "Shift" }, "Tab", function()
		local s = awful.screen.focused()
		awful.tag.viewprev(s)
		local t = s.selected_tag
		local c = focus_sta.tag_last_focus[t]

		if c and c.valid then
			client.focus = c
			c:raise()
		end
	end)
)
-- =========================
-- ★ 在这里添加 tag 切换
-- =========================
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,

		-- Mod + i：切换 tag
		awful.key({ modkey }, "#" .. i + 9, function()
			local s = awful.screen.focused()
			local t = s.tags[i]

			if t then
				t:view_only()

				local c = focus_sta.tag_last_focus[t]

				if c and c.valid then
					client.focus = c
					c:raise()
				end
			end
		end),

		-- ★ Mod + Shift + i：移动窗口到 tag
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			local c = client.focus
			if not c then
				return
			end

			local t = c.screen.tags[i]
			if not t then
				return
			end

			c:move_to_tag(t)
			t:view_only()

			focus_sta.tag_last_focus[t] = c

			client.focus = c
			c:raise()
		end)
	)
end
root.keys(globalkeys)

-- 桌面有效的鼠标按键
root.buttons(gears.table.join(
	root.buttons(),
	awful.button({}, 1, function()
		if mymainmenu and mymainmenu.wibox.visible then
			mymainmenu:hide()
		end
	end),
	awful.button({}, 3, function()
		if mymainmenu then
			mymainmenu:toggle()
		end
	end)
))

-- 窗口有效的鼠标按键
clientbuttons = gears.table.join(

	-- -----------------------------------
	--                   左键点击激活
	-- ----------------------------------
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end, { description = "mouse", group = "client1" }),

	-- -----------------------------------
	--                   mod+左键拖动窗口
	-- ----------------------------------
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),

	-- -----------------------------------
	--                   mod+右键缩放窗口
	-- ----------------------------------
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)
clientkeys = gears.table.join(
	-- -----------------------------------
	--                   toggle 全屏
	-- ----------------------------------
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),

	-- -----------------------------------
	--                   toggle 顶层
	-- ----------------------------------
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),

	-- -----------------------------------
	--                   toggle 最大化
	-- ----------------------------------
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),

	-- -----------------------------------
	--                   toggle 竖向最大化
	-- ----------------------------------
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),

	-- -----------------------------------
	--                   toggle 横向最大化
	-- ----------------------------------
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)
-- }}}
