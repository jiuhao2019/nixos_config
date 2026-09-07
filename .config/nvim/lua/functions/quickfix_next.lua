----------------------------------------------------------------------
--      👇 打开 Quickfix 窗口时：
--          绑定 <C-n> 为 :cnext
--          绑定 <C-p> 为 :cprev
--          全局有效（比如跳到别的 buffer 后还能继续按）
--      👆 关闭 Quickfix 窗口时：
--          取消这两个映射（全局解绑）
local M = {}

local quickfix_keys_bound = false

local function bind_quickfix_keys()
	if not quickfix_keys_bound then
		vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>", { noremap = true, silent = true })
		quickfix_keys_bound = true
	end
end

local function unbind_quickfix_keys()
	if quickfix_keys_bound then
		vim.keymap.del("n", "<C-n>")
		vim.keymap.del("n", "<C-p>")
		quickfix_keys_bound = false
	end
end

function M.setup()
	vim.api.nvim_create_autocmd("BufWinEnter", {
		pattern = "*",
		callback = function()
			if vim.bo.buftype == "quickfix" then
				bind_quickfix_keys()
			end
		end,
	})

	vim.api.nvim_create_autocmd("BufWinLeave", {
		pattern = "*",
		callback = function()
			if vim.bo.buftype == "quickfix" then
				unbind_quickfix_keys()
			end
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "qf",
		callback = function()
			vim.keymap.set("n", "<CR>", function()
				-- 强制选中光标那行
				vim.cmd("execute 'cc ' . line('.')") -- line('.') 是 quickfix 行号
				vim.cmd("cclose")
				vim.cmd("nohlsearch")
			end, { buffer = true, silent = true })
		end,
	})
end

return M
