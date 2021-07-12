inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': [ 'lsp', 'tabnine' ]},
    \    {'complete_items': ['snippet', 'ts', 'buffers']},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
\}

imap <c-j> <Plug>(completion_next_source)
imap <c-k> <Plug>(completion_prev_source)
let g:completion_auto_change_source = 1


autocmd BufEnter * if &buftype != "nofile" | lua require'completion'.on_attach()
