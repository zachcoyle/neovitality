set expandtab
set hidden
set incsearch
set mouse=a
set number
set relativenumber
set shiftwidth=2
set splitbelow
set splitright
set signcolumn=yes:3
set tabstop=2
set nowrap
set exrc
syntax on
set t_Co=256
set clipboard=unnamedplus

" compe
" TODO: move to inoremap nix mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
