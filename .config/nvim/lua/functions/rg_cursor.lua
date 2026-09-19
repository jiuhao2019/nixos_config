local M = {}

local function search_cursor_word_with_rg(file_globs, title)
	local word = vim.fn.expand("<cword>")
	if word == "" then
		print("No word under cursor")
		return
	end

	vim.fn.setqflist({})

	local command = "rg --vimgrep --smart-case --trim"
	for _, glob in ipairs(file_globs) do
		command = command .. " -g " .. vim.fn.shellescape(glob)
	end
	command = command .. " " .. vim.fn.shellescape(word)

	local result = vim.fn.systemlist(command)

	if vim.v.shell_error ~= 0 then
		print("rg returned non-zero exit code")
		return
	end

	local items = {}
	for _, line in ipairs(result) do
		line = string.gsub(line, "\r$", "") -- ✅ 就是这里，去掉 ^M
		local _, _, filename, lnum, col, text = string.find(line, "([^:]+):([^:]+):([^:]+):(.*)")
		if filename and lnum and col and text then
			table.insert(items, {
				filename = filename,
				lnum = tonumber(lnum),
				col = tonumber(col),
				text = text,
			})
		end
	end

	if #items == 0 then
		print("No matches found for [" .. word .. "]")
		return
	end

	vim.fn.setqflist({}, "r", {
		title = title,
		items = items,
	})

	vim.cmd("copen")
	-- vim.cmd("set hlsearch")
	vim.fn.setreg("/", word)
end

function M.search_cursorword_c()
	search_cursor_word_with_rg({ "*.c" }, "Search .c files")
end

function M.search_cursorword_h()
	search_cursor_word_with_rg({ "*.h" }, "Search .h files")
end

function M.search_cursorword_b()
	search_cursor_word_with_rg({ "*.c", "*.h" }, "Search both source files")
end

function M.search_cursorword_a()
	search_cursor_word_with_rg({ "*.c", "*.h", "*.s", "*.S" }, "Search all source files")
end

function M.search_cursorword_m()
	search_cursor_word_with_rg({ "*.*" }, "Search any files")
end
return M
