local M = {}

local enabled = {}

local function get_pair()
    local wins = vim.api.nvim_tabpage_list_wins(0)

    if #wins ~= 2 then
        return nil
    end

    return wins[1], wins[2]
end

local function is_enabled()
    local tab = vim.api.nvim_get_current_tabpage()
    return enabled[tab] == true
end

local function toggle()
    local tab = vim.api.nvim_get_current_tabpage()
    local win1, win2 = get_pair()

    if not win1 or not win2 then
        vim.notify("Scroll sync requires exactly 2 windows")
        return
    end

    enabled[tab] = not enabled[tab]

    vim.notify("Scroll sync " .. (enabled[tab] and "ON" or "OFF"))
end

local function execute_both(keys)
    local current = vim.api.nvim_get_current_win()
    local win1, win2 = get_pair()

    if not win1 or not win2 then
        return
    end

    local target = current == win1 and win2 or win1

    local count = vim.v.count
    local command = (count > 0 and count .. " " or "") .. keys
    command = vim.keycode(command)

    -- 另一个窗口
    vim.api.nvim_win_call(target, function()
        vim.cmd("normal! " .. command)
    end)

    -- 当前窗口
    vim.cmd("normal! " .. command)
end

function M.setup()
    vim.keymap.set("n", "<leader>ws", toggle, {
        silent = true,
    })

    local keys = {
        "j",
        "k",
        "<C-d>",
        "<C-u>",
        "<C-f>",
        "<C-b>",
        "<C-e>",
        "<C-y>",
    }

    for _, key in ipairs(keys) do
        vim.keymap.set("n", key, function()
            if is_enabled() then
                execute_both(key)
            else
                local count = vim.v.count
                local command = (count > 0 and count .. " " or "") .. key

                vim.cmd("normal! " .. vim.keycode(command))
            end
        end, {
            silent = true,
        })
    end
end

return M
