local M = {}

-- 对当前 buffer 替换字符串
local function buf_replace(from, to)
	if not from or from == "" then
		print("❌ [buffer]查找内容不能为空")
		return
	end

	if to == nil then
		return
	end

	-- 在当前 buffer 执行替换
	local cmd = string.format("%%s/%s/%s/gc", from, to)
	vim.cmd(cmd)
end

function M.setup()
	vim.api.nvim_create_user_command("BufReplace", function()
		vim.ui.input({ prompt = "[buffer]输入被替换字符：" }, function(from)
			vim.ui.input({ prompt = "[buffer]字符替换为：" }, function(to)
				buf_replace(from, to)
			end)
		end)
	end, {})
end

return M
