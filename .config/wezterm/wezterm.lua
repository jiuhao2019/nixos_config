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
--===============================--
config.color_scheme = "Gruvbox Dark (Gogh)"
config.colors = {
	background = "#32302f",
}
return config
