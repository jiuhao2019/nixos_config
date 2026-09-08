local alpha = require("alpha")

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {}
dashboard.section.header.opts.hl = "Normal"

dashboard.section.buttons.val = {
	dashboard.button("w", "Workspaces", ":Telescope workspaces<cr>"),
	dashboard.button("r", "Recent", ":Telescope oldfiles<cr>"),
	dashboard.button("s", "Settings", ":e ~/Downloads/nixos/.config/nvim/init.lua | :cd %:p:h<cr>"),
	dashboard.button("q", "Quit NVIM", ":qa<cr>"),
}

dashboard.section.buttons.opts.spacing = 0

-- dashboard.section.footer.val = require("alpha.fortune")()
dashboard.section.footer.val = vim.fn.systemlist("fortune")
dashboard.section.footer.opts.hl = "SpecialKey"
alpha.setup(dashboard.opts)
