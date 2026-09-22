local utils = require("utils")

require("status").enable()

local modules = utils.map({
	"window",
	"font",
	-- "theme",
	"tab",
	"keybind",
	"cursor",
}, utils.req)

local config = utils.merge(table.unpack(modules))

-- ===============================--
--以便单独设置背景色--
--
--yellow        #D79921
--bright_yellow #FABD2F
--淡蓝色        #83a598
--===============================--
config.color_scheme = "Gruvbox Dark (Gogh)"
config.colors = {
	background = "#32302f",

	-- 光标
	cursor_fg = "#000000", -- 光标框中文字颜色
	cursor_bg = "#FABD2F", -- 光标块颜色
	cursor_border = "#FABD2F", -- 光标边框颜色
}
return config
