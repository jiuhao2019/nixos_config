local M = {}

local function get_content()
	return vim.fn.input("Content : ")
end

local function get_comment_string()
	local commentstring = vim.bo.commentstring

	if commentstring == "" then
		print("Comment format not found for current filetype")
		return nil, nil
	end

	local start_comment, end_comment = commentstring:match("^(.*)%%s(.*)$")
	if not end_comment or end_comment == "" then
		end_comment = start_comment
	end
	return start_comment, end_comment
end

function M.add_comment()
	local content = get_content()
	local start_comment, end_comment = get_comment_string()
	local filler = string.rep("=", string.len(content) + 4)

	if start_comment == nil then
		return
	elseif start_comment == end_comment or end_comment == "" or not end_comment then
		end_comment = start_comment
	end

	local line_start_filler = string.rep(start_comment:sub(1, 1), 2)

	if content == "" or start_comment == nil then
		return
	end

	local header_lines = {
		"",
		start_comment .. filler .. line_start_filler,
		line_start_filler .. string.format("%s", content) .. line_start_filler,
		line_start_filler .. filler .. end_comment,
		"",
	}
	local row = vim.api.nvim_win_get_cursor(0)[1]

	vim.api.nvim_buf_set_lines(0, row, row, false, header_lines)
end

function M.setup(_)
	vim.keymap.set("n", "<leader>ac", M.add_comment, { desc = "epitech header creation" })
end

return M
