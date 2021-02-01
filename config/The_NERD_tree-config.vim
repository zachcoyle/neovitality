if exists('g:vscode') " hide if inside vscode
else

autocmd vimenter * NERDTree

autocmd VimEnter * wincmd p

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
function! OnlyAndNerdtree()
  let currentWindowID = win_getid()
  windo if win_getid() != currentWindowID && &filetype != 'nerdtree' | close | endif
endfunction

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName != -1))
endfunction

function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

autocmd BufEnter * call SyncTree()

command! Only call OnlyAndNerdtree()

endif
