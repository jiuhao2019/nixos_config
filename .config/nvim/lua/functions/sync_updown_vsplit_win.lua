local M = {}

local enabled = {}

local function get_pair()
    local wins = vim.api.nvim_tabpage_list_wins(0)

    if #wins ~= 2 then
        return nil
    end

    return wins[1], wins[2]
end

local function toggle()
    local tab = vim.api.nvim_get_current_tabpage()
    local win1, win2 = get_pair()

    if not win1 or not win2 then
        vim.notify("Scroll sync requires exactly 2 windows")
        return
    end

    enabled[tab] = not enabled[tab]

    if enabled[tab] then
        vim.api.nvim_win_call(win1, function()
            vim.cmd("setlocal scrollbind")
        end)

        vim.api.nvim_win_call(win2, function()
            vim.cmd("setlocal scrollbind")
        end)
    else
        vim.api.nvim_win_call(win1, function()
            vim.cmd("setlocal noscrollbind")
        end)

        vim.api.nvim_win_call(win2, function()
            vim.cmd("setlocal noscrollbind")
        end)
    end

    vim.notify("Scroll sync " .. (enabled[tab] and "ON" or "OFF"))
end

function M.setup()
    vim.keymap.set("n", "<leader>ws", toggle, {
        silent = true,
    })
end

return M
