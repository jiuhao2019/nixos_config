--❗️ configuration needs to be set BEFORE loading the color scheme with colorscheme gruvbox-flat

-- Option	                         Default	   Description
--
-- gruvbox_terminal_colors	         true	       Configure the colors used when opening a :terminal in Neovim
-- gruvbox_italic_comments	         true	       Make comments italic
-- gruvbox_italic_keywords	         true	       Make keywords italic
-- gruvbox_italic_functions	         false	       Make functions italic
-- gruvbox_italic_variables	         false	       Make variables and identifiers italic
-- gruvbox_transparent	             false	       Enable this to disable setting the background color
-- gruvbox_hide_inactive_statusline	 false	       Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard StatusLine and LuaLine.
-- gruvbox_sidebars	                 {}	           Set a darker background on sidebar-like windows. For example: ["qf", "vista_kind", "terminal", "packer"]
-- gruvbox_dark_sidebar	             true	       Sidebar like windows like NvimTree get a darker background
-- gruvbox_dark_float	             true	       Float windows like the lsp diagnostics windows get a darker background.
-- gruvbox_colors	                 {}	           You can override specific color groups to use other groups or a hex color
-- gruvbox_theme	                 {}	           You can override specific highlight groups to use other color groups or a hex color

-- vim.g.gruvbox_flat_style = "hard"
-- vim.g.gruvbox_flat_style = "dark"
vim.g.gruvbox_dark_sidebar = false
vim.g.gruvbox_dark_float = false

vim.cmd([[
  colorscheme gruvbox-flat
]])
