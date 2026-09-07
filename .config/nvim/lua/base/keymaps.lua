local map = function(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

map("i", "jk", "<Esc>")
map("n", "<leader>K", ":HelloFloat<CR>")

map("n", "<A-j>", ":resize +5<CR>")
map("n", "<A-k>", ":resize -5<CR>")
map("n", "<A-h>", ":vertical resize -5<CR>")
map("n", "<A-l>", ":vertical resize +5<CR>")

map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- 连续执行多个cmd
map("n", "<leader><leader>", function()
	-- 异步格式化
	require("conform").format({ async = false, lsp_fallback = false })
	-- 保存，清除高亮，底部信息清除
	vim.cmd("noh | echo ''")
end)

local function vsplit_ratio()
	vim.cmd("vsplit")

	local function resize()
		local total = vim.o.columns
		local right = math.floor(total * 1 / 2)

		vim.cmd("wincmd l")
		vim.cmd("vertical resize " .. right)
	end

	resize()

	vim.api.nvim_create_autocmd("VimResized", {
		callback = resize,
	})
end
map("n", "<Leader>|", vsplit_ratio)

map("n", "<Leader>-", ":split<CR>")
map("x", "<leader>k", function()
	require("align").align_to_char({ length = 1 })
end)

map("n", "<F4>", ":lua MiniFiles.open()<cr>")
map("n", "<leader>ra", function()
	require("functions.rg_cursor").search_cursorword_a()
end)
map("n", "<leader>rb", function()
	require("functions.rg_cursor").search_cursorword_b()
end)
map("n", "<leader>rc", function()
	require("functions.rg_cursor").search_cursorword_c()
end)
map("n", "<leader>rh", function()
	require("functions.rg_cursor").search_cursorword_h()
end)
map("n", "<leader>rm", function()
	require("functions.rg_cursor").search_cursorword_m()
end)

map("n", "<leader>rA", function()
	require("functions.rg_manual").search_with_rg_a()
end)

map("n", "<leader>rB", function()
	require("functions.rg_manual").search_with_rg_b()
end)
map("n", "<leader>rC", function()
	require("functions.rg_manual").search_with_rg_c()
end)
map("n", "<leader>rH", function()
	require("functions.rg_manual").search_with_rg_h()
end)
map("n", "<leader>rM", function()
	require("functions.rg_manual").search_with_rg_m()
end)

-- -------------------------------------------substitute
map("n", "<Leader>s", "<cmd>BufReplace<cr>")
map("n", "<Leader>S", "<cmd>RgReplace<CR>")

-- ------------------------------------------tabby.nvim
map("n", "<Tab>", ":tabn<cr>")
map("n", "<S-Tab>", ":tabp<cr>")
map("n", "<leader>te", ":tabnew<cr>")
map("n", "<leader>to", ":tabonly<cr>")
map("n", "<leader>tx", ":tabclose<cr>")
map("n", "<leader>tj", ":Tabby jump_to_tab<cr>")
map("n", "<leader>tr", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":TabRename ", true, false, true), "t", false)
	vim.cmd("redraw!")
end)

map("n", "<leader>f", function()
	require("telescope.builtin").find_files()
end)
map("n", "<F3>", ":TagbarToggle<CR>")
map("n", "<F5>", ":Neotree<CR>")
map("n", "<leader>o", function()
	require("telescope.builtin").oldfiles()
end)
map("n", "<leader>q", function()
	require("functions.quickfix_toggle").toggle_quickfix()
end)

-- 光标处插入当前日期时间
map("n", "<leader>T", 'i<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>')

-- hop(cursor jump) multi window
map("n", "<leader>j", ":HopChar1MW<CR>")
map({ "n", "v" }, "f", function()
	require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true })
end)
map({ "n", "v" }, "F", function()
	require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true })
end)
map({ "n", "v" }, "t", function()
	require("hop").hint_char1({
		direction = require("hop.hint").HintDirection.AFTER_CURSOR,
		current_line_only = true,
		hint_offset = -1,
	})
end)
map({ "n", "v" }, "T", function()
	require("hop").hint_char1({
		direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
		current_line_only = true,
		hint_offset = -1,
	})
end)

-- insert function_desc
map("n", "<leader>i", function()
	require("functions.add_doxy").insert_func_header()
end)
-- clear function_desc
map("n", "<leader>I", function()
	require("functions.add_doxy").delete_docblock_above()
end)

-- workspace
--
-- 这样可以按下keybind后底部信息不显示，得再输入一个字符才显示
map("n", "<leader>pe", ":call feedkeys(':WorkspacesAdd ', 'in')<CR>")
map("n", "<leader>po", ":WorkspacesOpen<CR>")
map("n", "<leader>pd", ":call feedkeys(':WorkspacesRemove ', 'in')<CR>")
map("n", "<leader>pr", ":call feedkeys(':WorkspacesRename ', 'in')<CR>")
map("n", "<leader>px", ":call feedkeys(':WorkspacesRemoveDir ', 'in')<CR>")
map("n", "<leader>ps", ":WorkspacesSyncDirs<CR>")
map("n", "<leader>pg", ":call feedkeys(':WorkspacesAddDir ', 'in')<CR>")
map("n", "<leader>pl", ":WorkspacesListDirs<CR>")
-- c-o   c-i  分别是光标后退前进，但终端通常不识别c-i
-- 所以改alt-o   alt-i
map("n", "<A-o>", "<C-o>")
map("n", "<A-i>", "<C-i>")

map("n", "<leader>e", function()
	require("functions.toggle_c_h").toggle()
end, { desc = "Toggle .c/.h (same dir only)" })

-- 删除选中的多行的末尾字符
map("v", "<leader>dl", ":<C-U>'<,'>s/.$//<CR>gv")

-- locate open file
vim.keymap.set("n", "<leader>l", "<cmd>Neotree reveal<cr>")

-- 在选中的多行末尾添加字符串
vim.api.nvim_set_keymap("v", "<leader>dm", [[:lua AppendCharAtLineEnd()<CR>]], { noremap = true, silent = false })
function AppendCharAtLineEnd()
	local char = vim.fn.input("输入要添加的字符: ")
	if char ~= "" then
		vim.cmd("'<,'>s/$/" .. char .. "/")
		-- 异步格式化
		require("conform").format({ async = false, lsp_fallback = true })
		-- 保存，清除高亮，底部信息清除
		vim.cmd("w | noh | echo ''")
	end
end

