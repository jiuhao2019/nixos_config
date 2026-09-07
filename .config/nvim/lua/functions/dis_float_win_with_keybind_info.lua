local float_win = nil

local function ShowFloat(opts_override)
	local buf = vim.api.nvim_create_buf(false, true)

	local lines = {
		"[按q或Esc关闭浮窗]",
		"☞ nvim-keybind",
		"leader K       show-keymap",
		"leader T       insert-time",
		'leader "       clip-history',
		"leader leader  保存,清除高亮和提示,format",
		"leader k       v: align-select-by-char",
		"leader l       locate-file",
		"leader f       find-file(cwd)",
		"leader o       old-file-recent-open",
		"leader q       quickfix-window",
		"leader s       subsititute-buffer",
		"leader S       subsititute-global",
		"leader j       hop-multi-window",
		"leader cl      clear log",
		"<F3>           tagbar",
		"<F4>           MiniFiles",
		" ",
		"leader dl      删除选中多行末尾一个字符",
		"leader dm      在选中多行的末尾添加字符串",
		" ",
		"leader i      插入函数描述",
		"leader I      清除函数描述",
		" ",
		"leader v      v: tab_to_space",
		"leader V      v: space_to_tab",
		" ",
		"leader ra       rg-cursor-any文件",
		"leader rc       rg-cursor-c文件",
		"leader rh       rg-cursor-h文件",
		" ",
		"leader rA       rg-manual-any文件",
		"leader rC       rg-manual-c文件",
		"leader rH       rg-manual-h文件",
		" ",
		"Tab            next-tabpage",
		"shit Tab       prev-tabpage",
		"leader te      新建tabpage",
		"leader tx      关闭当前 tabpage",
		"leader to      关闭其他 tabpage",
		"leader tr      重命名tabpage",
		"leader tj      jump tabpage",
		" ",
		"leader e       切换c/h",
		" ",
		"leader pe      new-workspace",
		"leader po      open-workspace",
		"leader pd      del-workspace",
		"leader pr      rename-workspace",
		-- 该dir里每个文件夹被当做一个workspace
		"leader pg      add-group-dir",
		"leader px      del-group-dir",
		"leader ps      sync-group-dir",
		"leader pl      list-group-dir",
		" ",
		"☞ awesomewm-keybind",
		"mod h          show help",
		"mod b          hide/show wibar",
		"mod o          libreoffice",
		"mod f          doublecmd",
		"mod y          v2rayN",
		"mod e          emacs",
		"mod enter      wezterm",
		"mod r          rofi",
		"mod j          focus next",
		"mod k          focus prev",
		"mod q          close window",
		"mod Tab        tag next",
		"mod Shift Tab  tag prev",
		"mod num        tag focus",
		"mod Shift num  tag move to num",
		"mod n          minimize current",
		"mod Ctr   n    unminimize next",
		"mod Ctr   r    restart awesome",
		"mod m          maximize toggle",
		"mod Shift m    横向maximize toggle",
		"mod Ctr   m    纵向maximize toggle",
		"mod c          窗口居中变小",
		"mod Shift c    窗口居中变大",
		"mod 左键       拖动窗口",
		"mod 右键       缩放窗口",
		"mod Shift f    full screen",
		"mod t          keep top",
		"mod i          保持比例右下角方向减小窗口",
		"mod Shift i    保持比例右下角加大窗口",
		"mod Ctr   h    增大窗口左边框方向",
		"mod Shift h    缩小窗口左边框方向",
		"mod Ctr   j            下边框",
		"mod Shift j                  ",
		"mod Ctr   k            上边框",
		"mod Shift k                  ",
		"mod Ctr   l            右边框",
		"mod Shift l                  ",
	}

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- 自动计算默认宽高
	local max_line_len = 0
	for _, line in ipairs(lines) do
		max_line_len = math.max(max_line_len, #line)
	end
	local default_width = max_line_len + 4
	local default_height = #lines + 2

	-- 默认浮窗参数
	local opts = {
		relative = "editor",
		width = default_width,
		height = default_height,
		row = math.floor((vim.o.lines - default_height) / 2),
		col = math.floor((vim.o.columns - default_width) / 2),
		style = "minimal",
		border = "rounded",
	}

	-- 合并用户覆盖参数
	if opts_override then
		for k, v in pairs(opts_override) do
			opts[k] = v
		end
	end

	-- 支持百分比模式
	local ui = vim.api.nvim_list_uis()[1]
	if opts.width and opts.width <= 1 then
		opts.width = math.floor(ui.width * opts.width)
	end
	if opts.height and opts.height <= 1 then
		opts.height = math.floor(ui.height * opts.height)
	end
	if opts.row and opts.row <= 1 then
		opts.row = math.floor(ui.height * opts.row)
	end
	if opts.col and opts.col <= 1 then
		opts.col = math.floor(ui.width * opts.col)
	end

	-- 关闭旧浮窗
	if float_win and vim.api.nvim_win_is_valid(float_win) then
		vim.api.nvim_win_close(float_win, true)
	end

	-- 打开新浮窗
	float_win = vim.api.nvim_open_win(buf, true, opts)

	-- 设置按键 q 和 Esc 关闭浮窗
	local keymap_opts = { nowait = true, noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>lua CloseFloat()<CR>", keymap_opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>lua CloseFloat()<CR>", keymap_opts)
end

-- 关闭浮窗
function CloseFloat()
	if float_win and vim.api.nvim_win_is_valid(float_win) then
		vim.api.nvim_win_close(float_win, true)
		float_win = nil
	end
end

-- 注册命令
vim.api.nvim_create_user_command("HelloFloat", function()
	-- 默认居中
	--	ShowFloat()
	--宽高占屏幕 30% / 80%，居中
	ShowFloat({ width = 0.3, height = 0.8, row = 0.3, col = 0.3 })
	--完全自定义绝对行列
	-- ShowFloat({ width = 80, height = 20, row = 5, col = 10 })
end, { nargs = 0 })
