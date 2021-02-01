nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> gt <Plug>(lcn-type-definition)
nmap <silent> gr <Plug>(lcn-references)
nmap <silent> gi <Plug>(lcn-implementation)
nmap <silent> gn <Plug>(lcn-diagnostics-next)
nmap <silent> gb <Plug>(lcn-diagnostics-prev)
nmap <silent> <F2> <Plug>(lcn-rename)
nmap <silent> <C-i> <Plug>(lcn-explain-error)

let g:LanguageClient_autoStart = 1
let g:LanguageClient_hoverPreview = 'Always'
let g:LanguageClient_preferredMarkupKind = ['markdown', 'plaintext']

let g:LanguageClient_diagnosticsDisplay =
      \    {
      \        1: {
      \            "name": "Error",
      \            "texthl": "ALEError",
      \            "signText": "",
      \            "signTexthl": "ALEErrorSign",
      \            "virtualTexthl": "Error",
      \        },
      \        2: {
      \            "name": "Warning",
      \            "texthl": "ALEWarning",
      \            "signText": "",
      \            "signTexthl": "ALEWarningSign",
      \            "virtualTexthl": "Todo",
      \        },
      \        3: {
      \            "name": "Information",
      \            "texthl": "ALEInfo",
      \            "signText": "",
      \            "signTexthl": "ALEInfoSign",
      \            "virtualTexthl": "Todo",
      \        },
      \        4: {
      \            "name": "Hint",
      \            "texthl": "ALEInfo",
      \            "signText": "",
      \            "signTexthl": "ALEInfoSign",
      \            "virtualTexthl": "Todo",
      \        },
      \    }
