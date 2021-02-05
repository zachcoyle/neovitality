set cursorline
set cursorcolumn
set expandtab
set hidden
set incsearch
set mouse=a
set number
set relativenumber
set shiftwidth=2
set splitbelow
set splitright
set signcolumn=yes
set tabstop=2
let g:mapleader = ';'
set exrc
syntax on

"set nobackup
"set nowritebackup
"set noswapfile

set t_Co=256

" overflow column guide
highlight ColorColumn ctermbg=235 guibg=#2c2d27
execute "set colorcolumn=" . join(range(121,99999), ',')

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

"true color
execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"
