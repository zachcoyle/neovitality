{ pkgs }:
with pkgs;
let
  pyls = python3Packages.python-language-server.overrideAttrs
    (oldAttrs: {
      doInstallCheck = false;
    });
in
# TODO: needs overlayed
  # \ 'java'            : ['${jdtls}/bin/jdt-language-server'], 

  #lsHelpers = [ ocamlPackages.merlin ];

''
  let g:LanguageClient_serverCommands = {
        \ 'c'               : ['${ccls}/bin/ccls'],
        \ 'clojure'         : ['${clojure-lsp}/bin/clojure-lsp'],
        \ 'cpp'             : ['${ccls}/bin/ccls'],
        \ 'dockerfile'      : ['${nodePackages.dockerfile-language-server-nodejs}/bin/docker-langserver', '--stdio'],
        \ 'go'              : ['${gopls}/bin/gopls'],
        \ 'haskell'         : ['${haskellPackages.haskell-language-server}/bin/haskell-language-server', '--lsp'],
        \ 'javascript'      : ['${nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio', '--tsserver-path', 'tsserver'],
        \ 'javascriptreact' : ['${nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio', '--tsserver-path', 'tsserver'],
        \ 'json'            : ['${nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio', '--tsserver-path', 'tsserver'],
        \ 'kotlin'          : ['${nur.repos.zachcoyle.kotlin-language-server}/bin/kotlin-language-server'],
        \ 'lua'             : ['${lua53Packages.lua-lsp}/bin/lua-lsp'],
        \ 'nix'             : ['${rnix-lsp}/bin/rnix-lsp'],
        \ 'objc'            : ['${ccls}/bin/ccls'],
        \ 'ocaml'           : ['${nodePackages.ocaml-language-server}/bin/ocaml-language-server', '--stdio'],
        \ 'python'          : ['${pyls}/bin/pyls'],
        \ 'ruby'            : ['${solargraph}/bin/solargraph', 'stdio'],
        \ 'rust'            : ['${rust-analyzer}/bin/rust-analyzer'],
        \ 'scala'           : ['${metals}/bin/metals'],
        \ 'sh'              : ['${nodePackages.bash-language-server}/bin/bash-language-server', 'start'],
        \ 'swift'           : ['xcrun', '--toolchain', 'swift', 'sourcekit-lsp'],
        \ 'typescript'      : ['${nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio', '--tsserver-path', 'tsserver'],
        \ 'typescriptreact' : ['${nodePackages.typescript-language-server}/bin/typescript-language-server', '--stdio', '--tsserver-path', 'tsserver'],
        \ 'vim'             : ['${nodePackages.vim-language-server}/bin/vim-language-server', '--stdio'],
        \ 'yaml'            : ['${nodePackages.yaml-language-server}/bin/yaml-language-server', '--stdio'],
        \ }
''
