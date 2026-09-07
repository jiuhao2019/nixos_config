require("workspaces").setup({
	-- path to a file to store workspaces data in
	-- on a unix system this would be ~/.local/share/nvim/workspaces
	path = vim.fn.stdpath("data") .. "/workspaces",

	-- to change directory for nvim (:cd), or only for window (:lcd)
	-- deprecated, use cd_type instead
	-- global_cd = true,

	-- controls how the directory is changed. valid options are "global", "local", and "tab"
	--   "global" changes directory for the neovim process. same as the :cd command
	--   "local" changes directory for the current window. same as the :lcd command
	--   "tab" changes directory for the current tab. same as the :tcd command
	--
	-- if set, overrides the value of global_cd
	cd_type = "global",

	-- sort the list of workspaces by name after loading from the workspaces path.
	sort = true,

	-- sort by recent use rather than by name. requires sort to be true
	mru_sort = true,

	-- option to automatically activate workspace when opening neovim in a workspace directory
	auto_open = false,

	-- option to automatically activate workspace when changing directory not via this plugin
	-- set to "autochdir" to enable auto_dir when using :e and vim.opt.autochdir
	-- valid options are false, true, and "autochdir"
	auto_dir = false,

	-- enable info-level notifications after adding or removing a workspace
	notify_info = false,

	-- lists of hooks to run after specific actions
	-- hooks can be a lua function or a vim command (string)
	-- lua hooks take a name, a path, and an optional state table
	-- if only one hook is needed, the list may be omitted
	hooks = {
		-- add = {},
		-- remove = {},
		-- rename = {},
		-- open_pre = {},
		-- open = {"NvimTreeOpen","wincmd l"},
	},
})

-- 下面这段话意思是解释此插件的名词
-- workspace 和 dir区别
-- 比如cd进一个文件夹，workspace add 意思是将当前文件夹作为一个workspace，下次就可以打开该workspace，当前的cwd可能任意，但打开workspace后就会在nvim里自动设置cwd为打开的workspace的文件夹路径
-- dir 则是一个文件夹，里面所有的一级别子文件夹都被当做workspace,因此add dir为某个文件夹，然后running `:WorkspacesSyncDirs`
-- 则会将该dir里的所有一级子文件夹当做workspace 添加进workspace list, 再打开命令时会看到这些workspace
--
-- -- Because naming could be confusing, here are some definitions:
-- * **Workspaces**: as described above, are project directories.
-- The purpose of this plugin being to switch easily between these project directories.
--
-- * **Dirs**: These are directories that contain workspaces. It allows to easily sync multiple workspaces contained in a directory.
-- For example, you might have a directory called `projects` on your machine, that contains all your projects.
-- Just register this directory as a `dir` with `:WorkspacesAddDir` and all the workspaces contained in
-- it will be automatically added to the list of workspaces when running `:WorkspacesSyncDirs`.
