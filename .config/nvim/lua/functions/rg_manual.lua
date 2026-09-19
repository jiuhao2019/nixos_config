local M = {}

local function search_with_rg(globs, title)
	local query = vim.fn.input("Search: ")
	if query == "" then
		return
	end

	local glob_args = ""
	for _, g in ipairs(globs) do
		glob_args = glob_args .. string.format(' -g "%s"', g)
	end

	local command =
		string.format("rg --vimgrep --smart-case --trim%s %s 2>/dev/null", glob_args, vim.fn.shellescape(query))

	local result = vim.fn.systemlist(command)

	if vim.v.shell_error ~= 0 then
		print("rg error")
		return
	end

	local items = {}
	for _, line in ipairs(result) do
		-- 先去掉行末 ^M（也就是 \r）
		line = string.gsub(line, "\r$", "")

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
		print("No matches found for [" .. query .. "]")
		return
	end

	vim.fn.setqflist({}, "r", {
		title = title or "Search Results",
		items = items,
	})

	vim.cmd("copen")
	-- vim.cmd("set hlsearch")
	vim.fn.setreg("/", query)
end

function M.search_with_rg_c()
	search_with_rg({ "*.c" }, "Search *.c")
end

function M.search_with_rg_h()
	search_with_rg({ "*.h" }, "Search *.h")
end

function M.search_with_rg_b()
	search_with_rg({ "*.c", "*.h" }, "Search both c, h")
end

function M.search_with_rg_a()
	search_with_rg({ "*.c", "*.h", "*.s", "*.S" }, "Search any")
end

function M.search_with_rg_m()
	search_with_rg({ "*.*" }, "Search any file")
end
return M
