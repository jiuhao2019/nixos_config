local path = require("path")
local use_background_image = false
local window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

local M = {
	window_padding = window_padding,
	window_background_image_hsb = {
		brightness = 0.013,
	},
	adjust_window_size_when_changing_font_size = false,
	-- How many lines of scrollback you want to retain per tab
	scrollback_lines = 30000,
}

if use_background_image then
	M.window_background_image = path.config .. "/od_tux.png"
end
return M
