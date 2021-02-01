augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

let g:neoformat_enabled_c               = ['clangformat']
let g:neoformat_enabled_cpp             = ['uncrustify']
let g:neoformat_enabled_go              = ['gofumports', 'gofumpt']
let g:neoformat_enabled_graphql         = ['prettier']
let g:neoformat_enabled_haskell         = ['ormolu']
let g:neoformat_enabled_javascript      = ['prettier']
let g:neoformat_enabled_javascriptreact = ['prettier']
let g:neoformat_enabled_json            = ['prettier']
let g:neoformat_enabled_kotlin          = ['ktlint']
let g:neoformat_enabled_nix             = ['nixpkgsfmt']
let g:neoformat_enabled_objc            = ['uncrustify']
let g:neoformat_enabled_ocaml           = ['ocamlformat']
let g:neoformat_enabled_python          = ['isort' , 'black']
let g:neoformat_enabled_ruby            = ['rubocop']
let g:neoformat_enabled_rust            = ['rustfmt']
let g:neoformat_enabled_scala           = ['scalafmt']
let g:neoformat_enabled_sh              = ['shfmt']
let g:neoformat_enabled_terraform       = ['terraform']
let g:neoformat_enabled_typescript      = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']

let g:neoformat_run_all_formatters = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_only_msg_on_error = 1
