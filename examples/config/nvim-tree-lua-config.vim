let g:nvim_tree_side = 'left'
let g:nvim_tree_width = 42
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_auto_open = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_hide_dotfiles = 0
let g:nvim_tree_git_hl = 1
let g:nvim_tree_root_folder_modifier = ':~'
let g:nvim_tree_tab_open = 1
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \}

"let g:nvim_tree_bindings = {
"    \ 'edit':            ['<CR>', 'o'],
"    \ 'edit_vsplit':     '<C-v>',
"    \ 'edit_split':      '<C-x>',
"    \ 'edit_tab':        '<C-t>',
"    \ 'toggle_ignored':  'I',
"    \ 'toggle_dotfiles': 'H',
"    \ 'refresh':         'R',
"    \ 'preview':         '<Tab>',
"    \ 'cd':              '<C-]>',
"    \ 'create':          'a',
"    \ 'remove':          'd',
"    \ 'rename':          'r',
"    \ 'cut':             'x',
"    \ 'copy':            'c',
"    \ 'paste':           'p',
"    \ 'prev_git_item':   '[c',
"    \ 'next_git_item':   ']c',
"    \}
"
"let g:nvim_tree_icons = {
"    \ 'default': '',
"    \ 'symlink': '',
"    \ 'git': {
"    \   'unstaged': "✗",
"    \   'staged': "✓",
"    \   'unmerged': "",
"    \   'renamed': "➜",
"    \   'untracked': "★"
"    \   },
"    \ 'folder': {
"    \   'default': "",
"    \   'open': ""
"    \   },
"    \}

set termguicolors

highlight NvimTreeFolderIcon guibg=blue

"autocmd FileType NvimTree setlocal signcolumn=no
"autocmd FileType NvimTree setlocal nocursorcolumn
