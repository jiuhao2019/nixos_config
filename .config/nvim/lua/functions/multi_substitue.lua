local M = {}

-- 用 ripgrep 查找并替换 .c/.h 文件中的字符串
local function rg_replace(from, to)
	local rg_cmd = {
		"rg",
		"-l",
		"-g",
		"*.c",
		"-g",
		"*.h",
		from,
	}

	local result = vim.system(rg_cmd, { text = true }):wait()
	if result.code ~= 0 then
		print("❌ ripgrep 执行失败或未找到结果")
		return
	end

	-- 转换为文件列表
	local files = {}
	for file in result.stdout:gmatch("[^\r\n]+") do
		table.insert(files, file)
	end

	if #files == 0 then
		print("🔍 未找到包含 '" .. from .. "' 的 .c/.h 文件")
		return
	end

	-- 设置 args 并执行替换
	vim.cmd("args " .. table.concat(files, " "))
	local cmd = string.format("argdo %%s/%s/%s/gc | update", from, to)
	vim.cmd(cmd)
end

function M.setup()
	vim.api.nvim_create_user_command("RgReplace", function()
		vim.ui.input({ prompt = "全局查找字符：" }, function(from)
			if not from or from == "" then
				return
			end
			vim.ui.input({ prompt = "全局替换字符为：" }, function(to)
				if not to then
					return
				end
				rg_replace(from, to)
			end)
		end)
	end, {})
end

return M
