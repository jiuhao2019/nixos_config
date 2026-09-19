-- 加载 LuaSnip 的片段
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/pack/cmp/start/friendly-snippets" })

-- 补全核心配置
local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- ["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp.mapping.abort(),
	}),
	sources = cmp.config.sources({
		{ name = "buffer" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- 只显示图标和类型
			maxwidth = {
				menu = 50,
				abbr = 50,
			},
			ellipsis_char = "...",
			show_labelDetails = true,
			before = function(entry, vim_item)
				-- 先调用你自己的 menu 和 colorful-menu 处理
				vim_item.menu = ({
					buffer = "[Buf]",
					nvim_lsp = "[LSP]",
					path = "[Path]",
					luasnip = "[Snip]",
				})[entry.source.name]

				-- 返回修改后的 vim_item 交给 lspkind 处理 kind 图标
				return vim_item
			end,
		}),
	},
})
-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

require("lspconfig").pyright.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
