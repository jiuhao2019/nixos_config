-- ======================--
-- 定义全局变量--
-- ======================--

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

local M = {}

M.tag_last_focus = {}
M.my_text_clock = {}
M.my_net_speed = {}
M.my_keybind = {}

return M
