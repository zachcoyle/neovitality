function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg -S --column --line-number --no-heading --color=always -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

let $FZF_DEFAULT_COMMAND = 'fd -t f'

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <C-_> :RG<CR>
nnoremap <C-P> :FZF<CR>
