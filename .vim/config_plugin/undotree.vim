"----------------------------------------undotree
if has("persistent_undo")
  let target_path = expand('~/.undodir_vim')
  if !isdirectory(target_path)
    call mkdir(target_path, "p", 0700)
  endif
  let &undodir=target_path
  set undofile
endif
let g:undotree_WindowLayout = 2

