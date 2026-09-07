local tab_jumper = {
	line = nil,
	char_to_tabid = {}, ---@type table<string,number>
	tabid_to_char = {}, ---@type table<number,string>
	is_start = false,
}

-- local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local alphabet = "etovxqpdygfblzhckisuran123"

---@param line TabbyLine
function tab_jumper.pre_render(line)
	tab_jumper.line = line
end

function tab_jumper.reset()
	tab_jumper.char_to_tabid = {}
	tab_jumper.tabid_to_char = {}
end

function tab_jumper.build_indexes()
	if tab_jumper.line == nil then
		return
	end
	local tabs = tab_jumper.line.tabs().tabs

	for i, tab in ipairs(tabs) do
		local char = alphabet:sub(i, i)
		if char then
			tab_jumper.char_to_tabid[char] = tab.id
			tab_jumper.tabid_to_char[tostring(tab.id)] = char
		end
	end
end

function tab_jumper.get_char(tabid)
	local char = tab_jumper.tabid_to_char[tostring(tabid)] or "??"
	return char
end

function tab_jumper.start()
	tab_jumper.build_indexes()
	tab_jumper.is_start = true

	vim.cmd.redrawtabline()
	local ok, tabid = pcall(function()
		local c = string.char(vim.fn.getchar()):lower()
		return tab_jumper.char_to_tabid[c]
	end)

	tab_jumper.is_start = false
	tab_jumper.reset()
	if ok and tabid then
		vim.api.nvim_set_current_tabpage(tabid)
	else
		vim.cmd.redrawtabline()
	end
end

return tab_jumper
