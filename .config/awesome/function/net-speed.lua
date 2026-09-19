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

local net_speed = require("net-speed-widget")
local tables = require("function.table")

tables.my_net_speed = net_speed({
    interface = "ens33",   -- 所有网卡
    timeout = 1,       -- 1秒刷新
    width = 105,        -- 文本宽度
})
