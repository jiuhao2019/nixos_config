vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_netrwSettings = 1

-- 设置 leader 键为 空格
vim.g.mapleader = " "

-- 启用语法高亮（等价于 :syntax on）
vim.cmd("syntax enable")

-- 启用文件类型识别、插件、缩进（等价于 filetype on / indent / plugin）
vim.cmd("filetype plugin indent on")

vim.o.laststatus = 2

vim.opt.statusline = table.concat({
	" %h%m%r%=",
	"%k[%{(&fenc=='' ? &enc : &fenc)}%{(&bomb ? ',BOM' : '')}]",
	-- 行号对齐
	" %{printf('%3d/%-3d', line('.'), line('$'))}:",
	-- 列号简单显示
	"%{printf('%3d/%-3d', col('.'), col('$')-1)}",
})
-- shada文件
--保存最近 20 个文件的 marks / 光标位置。
--保存全局 marks（file marks）。
--不保存搜索高亮状态。
vim.opt.shada = "'20,f1,h"

-- tab 栏始终显示
vim.o.showtabline = 2
vim.opt.ruler = false
-- 高亮搜索匹配项
vim.o.hlsearch = true

-- 增量搜索（输入时即时高亮）
vim.o.incsearch = true

-- 搜索时区分大小写
vim.o.ignorecase = false

-- 文件在外部被修改后自动重新加载
vim.o.autoread = true

-- 自动写入所有 buffer（退出前自动保存）
vim.o.autowriteall = true

-- 禁用鼠标支持（类似 set mouse-=a）
vim.o.mouse = ""

-- 设置窗口标题显示
vim.o.title = true

-- 禁用响铃（视觉或声音）
vim.o.visualbell = false
vim.o.errorbells = false

-- 启用“魔法模式”正则匹配（默认开启，保留以明确表达意图）
vim.o.magic = true

-- 配置退格键行为（删除 eol、缩进、插入起始点）
vim.o.backspace = "indent,eol,start"

-- 让光标左右移动可以跨行（例如按 h/l 到行尾/行首继续切换）
vim.opt.whichwrap:append("<,>,h,l")

-- 光标在括号上时高亮配对括号
vim.o.showmatch = true

-- 配对高亮时间（20 表示 2 秒）
vim.o.matchtime = 20

-- 显示正在输入的命令
vim.o.showcmd = true

-- 不显示当前 Vim 模式（例如 NORMAL、INSERT）提示（适合配合状态栏插件）
vim.o.showmode = false

-- Tab 设置
vim.o.expandtab = false -- 用空格代替 tab
vim.o.tabstop = 4 -- Tab 显示宽度
vim.o.shiftwidth = 4 -- 缩进宽度
vim.o.softtabstop = 4 -- 回退等价空格数
vim.o.smarttab = true -- 行首智能插入 tab
vim.o.shiftround = true -- 缩进对齐 shiftwidth 的倍数

-- 设置编码为 UTF-8
vim.o.encoding = "utf-8"
vim.o.fileencodings = "ucs-bom,utf-8,cp936,euc-jp,euc-kr,latin1"

-- 使用 Unix 作为默认换行符格式
vim.o.fileformats = "unix,dos,mac"

-- formatoptions 追加 'm' 和 'B'
vim.opt.formatoptions:append({ "m", "B" })

-- 忽略某些文件类型（文件补全忽略）
vim.o.wildignore = "*.o,*~,*.pyc,*.class,*.rtf,*.d"

-- 设置 tags 文件搜索路径
vim.o.tags = "./tags,tags;"

-- 启用命令行补全菜单和补全模式
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"

-- 启用补全来源（文件、缓冲区、未保存、tag）
vim.o.complete = ".,w,b,u,t"

-- 设置补全行为：显示菜单、不自动插入、不自动选中
vim.o.completeopt = "menu,menuone,noinsert,noselect"

-- 修改文件时确认保存
vim.o.confirm = true

-- 自动缩进
vim.o.autoindent = true

-- 显示不可见字符
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ", -- tab 显示为 »（注意空格），可选 ▸
	nbsp = "_", -- 不可换空格显示为 _
	trail = "·", -- 如果想显示行尾空格，可取消注释
}

-- 命令历史条数
vim.o.history = 300

-- 搜索不循环
vim.o.wrapscan = false

-- 不自动换行显示
vim.o.wrap = false

-- 不自动切换当前目录为当前文件所在目录
vim.o.autochdir = false

-- 禁用交换文件和备份文件
vim.o.swapfile = false
vim.o.backup = false

-- 垂直滚动边距为 1 行
vim.o.scrolloff = 0

-- 水平滚动边距
vim.o.sidescrolloff = 19
vim.o.sidescroll = 1

-- 分屏默认行为：右侧、下方打开
vim.o.splitright = true
vim.o.splitbelow = true

-- 启用超时（timeout）
vim.o.timeout = true

-- 设置按键等待超时时间
vim.o.timeoutlen = 30000

-- 启用终端模式的超时
vim.o.ttimeout = true

-- 设置 ttimeoutlen 为 10 毫秒
vim.o.ttimeoutlen = 10

-- 设置剪贴板为共享系统剪贴板
-- * as clipboard
-- vim.o.clipboard = "unnamed"
-- + as clipboard
vim.o.clipboard = "unnamedplus"

-- 禁用错误响铃（视觉或声音）
vim.o.errorbells = false

-- 移动光标时不自动将光标重置到行首
vim.o.startofline = false

-- 不解析运行 Vim 脚本的行（增加系统安全性）
vim.o.modelines = 0

-- 启用 hidden 选项，允许切换文件时不保存未保存的缓冲区
vim.o.hidden = true

-- 关闭 signcolumn（标志列）
vim.o.signcolumn = "no"

-- 设置 viewoptions（保存视图选项）
vim.o.viewoptions = "cursor,folds,slash,unix"

-- save and restore sessions
vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

-- 删除注释行时合并行的注释字符
vim.o.formatoptions = vim.o.formatoptions .. "j"

-- 设置空白行首波浪符号（~）改为空格
vim.o.fillchars = "eob: " -- 这里是两个空格

-- 设置 viminfo 选项
vim.o.viminfo = "'10,<100,s5000,h"

-- 设置背景色为暗色
vim.o.background = "dark"

vim.opt.conceallevel = 0
vim.opt.concealcursor = "nc"

-- 启动时不显示欢迎页
vim.o.shortmess = "aIt"
-- I    " 启动时不显示欢迎信息
-- F    " 不显示文件名加载信息
vim.opt.shortmess:append("IF")

vim.o.foldcolumn = "1" -- 左边显示折叠标记
vim.o.foldlevel = 99 -- 默认展开所有
vim.o.foldlevelstart = 99 -- 打开文件时从这个层级开始展开
vim.o.foldenable = false
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- 告诉 Neovim 使用这个 Python
vim.g.python3_host_prog = os.getenv("HOME") .. "/.venvs/nvim/bin/python"

vim.opt.undofile = false -- Enable persistent undo
vim.opt.undodir = vim.fn.expand("~/.undodir_nvim") -- Set custom undo directory
vim.o.cmdheight = 1

vim.o.equalalways = false
-- vim.o.winfixheight = true
-- vim.o.winfixwidth = true

-- vim.o.guicursor = "n-v-c-sm:underline,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
vim.o.guicursor = "n-v-c-sm:hor20,i-ci-ve:ver25,r-cr-o:block,t:hor20"
-- vim.o.guicursor = "a:hor20"

-- vim.cmd("set nomore")

vim.keymap.del("n", "gc")
vim.keymap.del("n", "gcc")
vim.keymap.del("x", "gc")

-- 启用 24-bit 颜色
vim.o.termguicolors = true

-- 显示行号和相对行号
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

-- default updatetime 4000ms is not good for async update
vim.o.updatetime = 100

-- support using the mouse in normal and visual mode
vim.o.mouse = "nv"

-- limit completion popup to height of 10
vim.o.pumheight = 10
-- vim.cmd("colorscheme retrobox")
