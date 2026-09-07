local wezterm = require("wezterm")

local font_size = 12
local bold = false
local font_family = ({
	"Iosevka Nerd Font Mono", -- [1]
	"JetBrainsMono Nerd Font", -- [2]
	"FiraCode Nerd Font Mono", -- [3]
	"Photonico Code", -- [4]
	"VictorMono Nerd Font", -- [5]
	"Hurmit Nerd Font Mono", -- [6]
	"Gintronic", -- [7]
	"Monocraft", -- [8]
	"Comic Mono", -- [9]
	"Input Mono", -- [10]
	"ComicCode Nerd Font Mono", -- [11]
	"Hack Nerd Font Mono", -- [12]
})[5]

local options = {
    weight = bold and "Bold" or "Regular",
}

local font = wezterm.font(font_family, options)

return {
	font = font,
	font_size = font_size,
}
