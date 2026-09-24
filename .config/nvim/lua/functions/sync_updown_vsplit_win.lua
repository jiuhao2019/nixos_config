local M = {}

local sync = false

local function other_win()
	local current = vim.api.nvim_get_current_win()

	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if win ~= current and vim.api.nvim_win_is_valid(win) then
			return win
		end
	end
end

local function execute_both(keys)
	local target = other_win()

	if not target then
		return
	end

	local count = vim.v.count
	local command = (count > 0 and count .. " " or "") .. keys
	command = vim.keycode(command)

	vim.api.nvim_win_call(target, function()
		vim.cmd("normal! " .. command)
	end)

	vim.cmd("normal! " .. command)
end

local function toggle_sync()
	sync = not sync
	vim.notify("Scroll sync " .. (sync and "ON" or "OFF"))
end

function M.setup()
	vim.keymap.set("n", "<leader>ws", toggle_sync)

	for _, key in ipairs({
		"j",
		"k",
		"<C-d>",
		"<C-u>",
		"<C-f>",
		"<C-b>",
		"<C-e>",
		"<C-y>",
	}) do
		vim.keymap.set("n", key, function()
			if sync then
				execute_both(key)
			else
				local count = vim.v.count
				local command = (count > 0 and count .. " " or "") .. key
				vim.cmd("normal! " .. vim.keycode(command))
			end
		end, { silent = true })
	end
end

return M
