local M = {}

local function exists(path)
	return vim.loop.fs_stat(path) ~= nil
end

function M.toggle()
	local buf = vim.api.nvim_buf_get_name(0)
	if buf == "" then
		vim.notify("当前 buffer 没有关联文件", vim.log.levels.WARN)
		return
	end

	local dir = vim.fn.fnamemodify(buf, ":h")
	local file = vim.fn.fnamemodify(buf, ":t")

	local cur_dir = vim.fn.fnamemodify(dir, ":t")
	local parent = vim.fn.fnamemodify(dir, ":h")

	local target_dir, target_name

	-- src/fun.c → inc/fun.h
	if cur_dir == "src" and file:sub(-2) == ".c" then
		target_dir = parent .. "/inc"
		target_name = file:gsub("%.c$", ".h")

	-- inc/fun.h → inc/fun_def.h
	elseif cur_dir == "inc" and file:sub(-2) == ".h" and file:sub(-6) ~= "_def.h" then
		target_dir = dir
		target_name = file:gsub("%.h$", "_def.h")

	-- inc/fun_def.h → src/fun.c
	elseif cur_dir == "inc" and file:sub(-6) == "_def.h" then
		target_dir = parent .. "/src"
		target_name = file:gsub("_def%.h$", ".c")
	else
		vim.notify("仅支持 src/*.c ↔ inc/*.h ↔ inc/*_def.h", vim.log.levels.INFO)
		return
	end

	if not exists(target_dir) then
		vim.notify("未找到目录: " .. target_dir, vim.log.levels.ERROR)
		return
	end

	local target = target_dir .. "/" .. target_name

	if not exists(target) then
		vim.notify("未找到对应文件: " .. target, vim.log.levels.ERROR)
		return
	end

	vim.cmd("edit " .. vim.fn.fnameescape(target))
end

return M
