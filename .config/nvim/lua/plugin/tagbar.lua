vim.cmd([[
let g:tagbar_compact = 2
let g:tagbar_position = 'botright vertical'
let g:tagbar_sort = 0
let g:tagbar_autoclose = 1
let g:tagbar_width = max([25 * 2, (winwidth(0) / 5) * 2])
let g:tagbar_autofocus = 1
let g:tagbar_show_data_type = -1
let g:tagbar_show_linenumbers = 1
let g:tagbar_show_tag_linenumbers = 1
let g:tagbar_expand = 1
let g:tagbar_scopestrs = {
    \    'class': "\uf0e8",
    \    'const': "\uf8ff",
    \    'constant': "\uf8ff",
    \    'enum': "\uf702",
    \    'field': "\uf30b",
    \    'func': "\uf794",
    \    'function': "\uf794",
    \    'getter': "\ufab6",
    \    'implementation': "\uf776",
    \    'interface': "\uf7fe",
    \    'map': "\ufb44",
    \    'member': "\uf02b",
    \    'method': "\uf6a6",
    \    'setter': "\uf7a9",
    \    'variable': "\uf71b",
    \ }
]])
