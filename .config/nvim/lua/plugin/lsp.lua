local on_attach = function(client, bufnr) end

-- 禁用日志
-- vim.lsp.log.set_log_level("OFF")

require("lspconfig").clangd.setup({
	on_attach = on_attach,
	handlers = {
		["textDocument/publishDiagnostics"] = function(...) end, -- 忽略诊断
	},
	cmd = { "clangd", "--header-insertion=never" },
})
