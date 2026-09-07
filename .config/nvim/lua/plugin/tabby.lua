local M = {}
function M.setup()
	local tabby = require("tabby.tabline")

	-- 定义配色
	local theme = {
		--fill = "TabLineFill",
		fill = { fg = "#f2e9de", bg = "#282828", style = "italic" },
		head = { fg = "#a9b665", bg = "#282828", style = "bold" },
		current_tab = { fg = "#a9b665", bg = "#32302f", style = NONE },
		tab = { fg = "#7c6f64", bg = "#32302f", style = "normal" },
		win = { fg = "#282828", bg = "#ff9900", style = NONE },
		tail = { fg = "#ff9900", bg = "#282828", style = NONE },
		jump = { fg = "#a9b665", bg = "#32302f", style = "bold" }, -- tab jump时index 颜色
		current_tab_number = { fg = "#a9b665", bg = "#32302f" },
		jump_hide = { fg = "#32302f", bg = "#32302f", style = NONE },
		jump_show = { fg = "#ff9900", bg = "#32302f", style = NONE },
	}
	tabby.set(function(line)
		return {
			-- { { "  ", hl = theme.fill }, line.sep("", theme.head, theme.fill) },

			line.tabs().foreach(function(tab, idx)
				local hl = tab.is_current() and theme.current_tab or theme.tab

				local number

				if tab.in_jump_mode() then
					number = { tab.jump_key(), hl = theme.jump_show }
				elseif tab.is_current() then
					-- number = { tab.number(), hl = theme.current_tab_number }
					number = { "◉", hl = theme.jump_hide }
				else
					-- number = tab.number()
					number = { "○", hl = theme.jump_hide }
				end

				local name = tab.name()
				local safe_name = type(name) == "string" and name or ""

				return {
					line.sep("", hl, theme.fill),
					{ number, " " .. safe_name },
					line.sep("", hl, theme.fill),
					hl = hl,
					margin = " ",
				}
			end),
			line.spacer(),
		}
	end)
end

return M
