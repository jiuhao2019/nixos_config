require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		fzf = {
			fuzzy = false, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
	defaults = {
		preview = false,
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.85, -- 整体窗口宽度为屏幕宽度的90%
			height = 0.5, -- 整体窗口宽度为屏幕宽度的90%
			preview_cutoff = 120, -- 小于这个宽度就不显示预览
			horizontal = {
				preview_width = 0.3, -- 预览窗口占比30%
			},
		},
	},
})

-- 加载 ui-select 扩展
require("telescope").load_extension("ui-select")
require("telescope").load_extension("workspaces")
