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

local tables = require("function.table")
tables.my_keybind = require("keybind-widget")

-- right_layout:add(tables.my_keybind.widget)
-- 自定义内容（完全你自己控制）
tables.my_keybind.set_items({
	"mod + shift + i -------保持比例放大窗口",
	"mod + i ---------------保持比例缩小窗口",
	"mod + ctr   + l -------增大窗口右边框方向",
	"mod + shift + l -------减小",
	"mod + ctr   + j -------增大窗口下边框方向",
	"mod + shift + j -------减小",
	"mod + ctr   + h -------增大窗口左边框方向",
	"mod + shift + h -------减小",
	"mod + ctr   + k -------增大窗口上边框方向 ",
	"mod + shift + k -------减小 ",
	"mod + b ---------------显示/隐藏顶部bar ",
	"mod + o ---------------打开libreoffice ",
	"mod + f ---------------打开double-cmd (file explorer) ",
	"mod + y ---------------打开v2rayN ",
	"mod + e ---------------打开emacs ",
	"mod + shift + e  ------打开ungoogled-chromium ",
	"mod + return ----------打开wezterm ",
	"mod + r ---------------打开rofi ",
	"mod + j ---------------prev win ",
	"mod + k ---------------next win ",
	"mod + q ---------------close win ",
	"mod + tab -------------next tag ",
	"mod + shift + tab------prev tag ",
	"mod + ctr + n ---------恢复最小化的窗口 ",
	"mod + n ---------------窗口最小化 ",
	"mod + ctr + r ---------重启awesome ",
	"mod + 1 ~ 9 -----------聚焦到tag1 ~ 9 ",
	"mod + shift + 1 ~ 9 ---移动当前窗口到tag1 ~ 9 ",
	"mod + 鼠标左键 --------拖动窗口 ",
	"mod + 鼠标右键 --------缩放窗口 ",
	"mod + c ---------------先设置窗口为较小，再居中 ",
	"mod + shift + c -------先设置窗口为较大，再居中 ",
	"mod + shift + f -------切换全屏 ",
	"mod + t ---------------切换窗口置顶 ",
	"mod + m ---------------切换窗口最大化 ",
	"mod + ctr   + m -------切换窗口竖向最大化 ",
	"mod + shift + m -------切换窗口横向最大化 ",
})
