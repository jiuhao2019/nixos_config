require("dropbar").setup({
	-- 显示文件名
	show_file = true,

	-- winbar 位置
	bar_at_top = true,

	-- 显示图标
	icons = {
		separator = "", -- 可自定义分隔符
		kinds = {
			File = "",
			Module = "",
			Namespace = "",
			Package = "",
			Class = "",
			Method = "",
			Property = "",
			Field = "",
			Constructor = "",
			Enum = "",
			Interface = "",
			Function = "",
			Variable = "",
			Constant = "",
			String = "",
			Number = "",
			Boolean = "◩",
			Array = "",
			Object = "",
			Key = "",
			Null = "ﳠ",
			EnumMember = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
	},

	-- 可选：设置显示深度，避免太长
	max_depth = 3,
})

-- 3️⃣ 自动刷新 winbar
-- Treesitter 或 LSP 更新时自动刷新 dropbar
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorMoved", "WinScrolled" }, {
	callback = function()
		if vim.fn.exists(":DropbarRefresh") == 2 then
			vim.cmd("DropbarRefresh")
		end
	end,
})
