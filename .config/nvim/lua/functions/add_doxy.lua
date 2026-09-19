local M = {}
-- 插入函数注释模板
local function insert_func_header1()
	-- 读取当前行文本
	local line = vim.fn.getline(".")
	-- 尝试从当前行提取函数名（例如 int foo(int a) → foo）
	local func_name = line:match("[%w_]+%s*%(")
	func_name = func_name and func_name:match("[%w_]+") or vim.fn.input("函数名: ")

	local current_line = vim.fn.line(".")
	local lines = {
		"/***",
		" * @fn    " .. func_name .. "",
		" * @brief ",
		" * @param ",
		" * @return",
		" ***/",
	}
	vim.fn.append(current_line - 1, lines)
end

-- 删除上方注释块（/** ... */）
local function delete_docblock_above1()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	for i = row - 1, 1, -1 do
		local line = vim.fn.getline(i)
		if line:match("^%s*/%*%*") then
			local start_line = i
			-- 从起点向下找 */
			for j = i, row do
				local l2 = vim.fn.getline(j)
				if l2:match("%*/") then
					vim.cmd(string.format("%d,%dd", start_line, j))
					vim.notify("已删除函数注释块", vim.log.levels.INFO)
					return
				end
			end
		end
	end
	vim.notify("未找到上方注释块", vim.log.levels.WARN)
end

function M.insert_func_header()
	insert_func_header1()
end
function M.delete_docblock_above()
	delete_docblock_above1()
end
return M
