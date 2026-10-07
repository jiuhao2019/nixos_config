require("scroll-it").setup({

	enabled = false, -- Enable the plugin on startup
	reversed = false, -- Reverse the continuous direction (default: left-to-right, top-to-bottom)
	hide_line_number = "others", -- Options: "all" | "others" | "none"
	-- "all": Show line numbers in all windows
	-- "none": Hide line numbers in all synchronized windows
	-- "others": Hide line numbers in all but the focused window
	overlap_lines = 0, -- Number of lines to overlap between adjacent windows
})
