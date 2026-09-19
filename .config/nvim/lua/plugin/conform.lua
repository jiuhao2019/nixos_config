-- Lightweight yet powerful formatter plugin for Neovim
-- 首先确保已经加载 comform.nvim
require("conform").setup({
	format_on_save = false,
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "astyle_custom" },
		markdown = { "prettier" },
	},
	formatters = {
		astyle_custom = {
			command = "astyle",
			args = function()
				return { "--options=" .. vim.fn.expand("~/.astylerc") }
			end,
			stdin = true,
		},
	},
})
