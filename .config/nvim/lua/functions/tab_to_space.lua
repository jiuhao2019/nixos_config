-- functions/tab_to_spaces.lua
local M = {}

-- 配置选项
M.config = {
	tab_width = 4, -- 每个tab转换为的空格数
	use_spaces = true, -- 是否使用空格替代tab
}

-- 设置配置
M.setup = function(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

-- 将tab转换为空格
local function convert_tabs_to_spaces(lines, tab_width)
	local converted = {}
	for _, line in ipairs(lines) do
		-- 替换tab为指定数量的空格
		local converted_line = string.gsub(line, "\t", string.rep(" ", tab_width))
		table.insert(converted, converted_line)
	end
	return converted
end

-- 将空格转换为tab
local function convert_spaces_to_tabs(lines, tab_width)
	local converted = {}
	local pattern = string.rep(" ", tab_width)

	for _, line in ipairs(lines) do
		local converted_line = line

		-- 从行首开始，将每tab_width个空格替换为一个tab
		-- 首先处理行首的空格
		local start_spaces = string.match(line, "^(%s*)")
		if start_spaces then
			local tab_count = math.floor(#start_spaces / tab_width)
			local remaining_spaces = #start_spaces % tab_width
			local replacement = string.rep("\t", tab_count) .. string.rep(" ", remaining_spaces)
			converted_line = string.gsub(converted_line, "^(%s*)", replacement, 1)
		end

		-- 替换行中的空格（但需要小心，不要替换非缩进部分的空格）
		-- 这是一个简化版本，只处理缩进
		table.insert(converted, converted_line)
	end
	return converted
end

-- 获取当前选择的范围（改进版）
local function get_selection_range()
	local mode = vim.api.nvim_get_mode().mode

	-- 检查是否在visual模式
	if not string.find(mode, "[vV]") then
		-- 检查是否有视觉选择的标记
		local start_line = vim.fn.line("'<")
		local end_line = vim.fn.line("'>")

		-- 如果没有选择，则使用当前行
		if start_line == 0 and end_line == 0 then
			local current_line = vim.fn.line(".")
			return current_line, current_line
		end

		return start_line, end_line
	else
		-- 在视觉模式下，直接获取选择范围
		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")
		return start_pos[2], end_pos[2]
	end
end

-- 主转换函数（改进版）
M.convert_selection = function(to_spaces)
	local config = M.config
	local tab_width = config.tab_width
	local use_spaces = to_spaces or config.use_spaces

	-- 获取选中的行范围
	local start_line, end_line = get_selection_range()

	-- 确保 start_line <= end_line
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	-- 获取选中行的内容
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	if #lines == 0 then
		-- 如果没有内容，使用当前行
		local current_line = vim.fn.line(".")
		lines = vim.api.nvim_buf_get_lines(0, current_line - 1, current_line, false)
		start_line = current_line
		end_line = current_line
	end

	if #lines == 0 then
		vim.notify("没有选中的内容", vim.log.levels.WARN)
		return
	end

	-- 根据方向转换
	local converted_lines
	if use_spaces then
		converted_lines = convert_tabs_to_spaces(lines, tab_width)
	else
		converted_lines = convert_spaces_to_tabs(lines, tab_width)
	end

	-- 保存当前模式
	local current_mode = vim.api.nvim_get_mode().mode

	-- 替换原始行
	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, converted_lines)

	-- 如果是视觉模式，恢复选择状态
	if string.find(current_mode, "[vV]") then
		-- 使用延迟来确保命令执行完成后再恢复选择
		vim.defer_fn(function()
			-- 重新选择相同的行范围
			vim.cmd("normal! " .. start_line .. "GV" .. end_line .. "G")
		end, 10)
	else
		-- 如果不是视觉模式，移动光标到最后修改的行
		vim.api.nvim_win_set_cursor(0, { end_line, 0 })
	end

	-- 显示通知
	local action = use_spaces and "空格" or "制表符"
	vim.notify(string.format("已将选中的 %d 行转换为 %s", #lines, action), vim.log.levels.INFO)
end

-- 创建命令（带范围处理）
vim.api.nvim_create_user_command("TabToSpaces", function(opts)
	-- 如果有范围参数，使用范围
	if opts.range > 0 then
		local start_line = opts.line1
		local end_line = opts.line2

		-- 获取选中行的内容
		local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

		if #lines > 0 then
			-- 转换为空格
			local converted_lines = convert_tabs_to_spaces(lines, M.config.tab_width)
			vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, converted_lines)
			vim.notify(string.format("已将 %d-%d 行转换为空格", start_line, end_line), vim.log.levels.INFO)
		end
	else
		-- 没有范围参数，使用当前选择
		M.convert_selection(true)
	end
end, { range = true, desc = "将选中行的tab转换为空格" })

vim.api.nvim_create_user_command("SpacesToTab", function(opts)
	-- 如果有范围参数，使用范围
	if opts.range > 0 then
		local start_line = opts.line1
		local end_line = opts.line2

		-- 获取选中行的内容
		local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

		if #lines > 0 then
			-- 转换为tab
			local converted_lines = convert_spaces_to_tabs(lines, M.config.tab_width)
			vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, converted_lines)
			vim.notify(string.format("已将 %d-%d 行转换为制表符", start_line, end_line), vim.log.levels.INFO)
		end
	else
		-- 没有范围参数，使用当前选择
		M.convert_selection(false)
	end
end, { range = true, desc = "将选中行的空格转换为tab" })

-- 设置键盘映射（改进版）
local function setup_keymaps()
	local opts = { noremap = true, silent = true }

	-- 在视觉模式下按 leader + ts 转换tab为空格
	vim.keymap.set("v", "<leader>v", function()
		-- 保存当前选择范围
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")

		-- 确保顺序正确
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end

		-- 获取内容
		local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

		if #lines > 0 then
			-- 转换为空格
			local converted_lines = convert_tabs_to_spaces(lines, M.config.tab_width)
			vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, converted_lines)

			-- 重新选择
			vim.cmd("normal! " .. start_line .. "GV" .. end_line .. "G")
			vim.notify(string.format("已将 %d-%d 行转换为空格", start_line, end_line), vim.log.levels.INFO)
		end
	end, opts)

	-- 在视觉模式下按 leader + st 转换空格为tab
	vim.keymap.set("v", "<leader>V", function()
		-- 保存当前选择范围
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")

		-- 确保顺序正确
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end

		-- 获取内容
		local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

		if #lines > 0 then
			-- 转换为tab
			local converted_lines = convert_spaces_to_tabs(lines, M.config.tab_width)
			vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, converted_lines)

			-- 重新选择
			vim.cmd("normal! " .. start_line .. "GV" .. end_line .. "G")
			vim.notify(string.format("已将 %d-%d 行转换为制表符", start_line, end_line), vim.log.levels.INFO)
		end
	end, opts)
end

-- 初始化
M.init = function()
	setup_keymaps()
end

-- 自动初始化
M.init()

return M
