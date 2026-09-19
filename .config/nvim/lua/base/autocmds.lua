-- 在 quickfix 窗口打开时自动设置高度
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.cmd("wincmd J")
		vim.cmd("resize 7")
	end,
})

-- tab不要自动用4个空格代替
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})

-- 打开的buffrer被外部修改，自动更新buffer
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
	pattern = "*",
	command = "silent! checktime",
})
-- 保存时，清除行尾空格
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.c", "*.h", "*.cpp", "*.hpp" },

	callback = function()
		local pos = vim.api.nvim_win_get_cursor(0)

		vim.cmd([[%s/\s\+$//e]])

		vim.api.nvim_win_set_cursor(0, pos)
	end,
})
