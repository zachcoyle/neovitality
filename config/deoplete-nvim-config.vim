let g:deoplete#enable_at_startup = 1
autocmd BufEnter * call deoplete#custom#option('ignore_case', v:true)
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
