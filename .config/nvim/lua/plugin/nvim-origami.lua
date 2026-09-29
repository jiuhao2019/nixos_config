require("origami").setup({
	useLspFoldsWithTreesitterFallback = {
		enabled = true,
		foldmethodIfNeitherIsAvailable = "indent", ---@type string|fun(bufnr: number): string
	},
	pauseFoldsOnSearch = true,
	foldtext = {
		enabled = true,
		padding = {
			character = " ",
			width = 3, ---@type number|fun(win: number, foldstart: number, currentVirtualTextLength: number): number
			hlgroup = nil,
		},
		lineCount = {
			template = "%d lines", -- `%d` is replaced with the number of folded lines
			hlgroup = "Comment",
		},
		diagnosticsCount = false, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
		gitsignsCount = false, -- requires `gitsigns.nvim` or `mini.diff`
		disableOnFt = { "snacks_picker_input" }, ---@type string[]
	},
	autoFold = {
		enabled = false,
		kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
	},
	foldKeymaps = {
		setup = false, -- modifies `h`, `l`, `^`, and `$`
		closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
		scrollLeftOnCaret = false, -- `^` should scroll left (basically mapped to `0^`)
	},
})
