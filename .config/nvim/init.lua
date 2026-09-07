--diff -----------------------------基础的配置
require("base.options")

-- -----------------------------插件的配置

-- 文件浏览
require("plugin.mini_files")

-- 格式化代码
require("plugin.conform")

-- 输入时弹出提示自动完成
require("plugin.lsp")

-- improve quickfix ui
require("plugin.quicker")

-- improve tab
require("plugin.tabby").setup()

-- 自动补全括号的另一半
require("plugin.nvim-autopairs")

-- jump
require("plugin.hop")

-- workspace(project)
require("plugin.workspace")

-- 记住文件关闭前光标位置
require("plugin.remember")

-- startup ui
require("plugin.alpha")

-- breadcrum
require("plugin.dropbar")

-- 输入法自动切换
require("plugin.im-select")

-- gruvbox-flat
require("plugin.gruvbox-flat")

-- 侧边栏显示函数大纲
require("plugin.tagbar")

-- for locate open file
require("plugin.neo-tree")
---- ---------------------------------------- 自定义的功能函数
require("functions.quickfix_next").setup()
require("functions.multi_substitue").setup()
require("functions.buf_substitute").setup()
require("functions.dis_float_win_with_keybind_info")
---- 在函数上方增加描述
require("functions.add_doxy")
--- toggle_source_header(same folder)
require("functions.toggle_c_h")
require("functions.tab_to_space").setup({
	tab_width = 4,
})

require("functions.add_comment").setup()
---- --------------------------cmp靠后加载，方便其他插件已经加载
require("plugin.cmp")
require("plugin.telescope")
-- ------------------------确保base.keymaps靠后加载，才能显示其他的keybind
require("base.keymaps")
require("base.autocmds")

vim.lsp.log.set_level("OFF")
