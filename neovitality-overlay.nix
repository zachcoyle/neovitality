{ pkgs }: final: prev:
with pkgs;
let
  plugins = with pkgs.bleedingEdge.vimPlugins; with pkgs.vitalityVimPlugins; with builtins; [
    { plugin = auto-pairs; }
    { plugin = barbar-nvim; }
    { plugin = colorizer; }
    { plugin = conjure; }
    { plugin = deoplete-nvim; config = readFile ./config/deoplete-nvim-config.vim; }
    { plugin = direnv-vim; config = readFile ./config/direnv-vim-config.vim; }
    { plugin = editorconfig-vim; }
    { plugin = emmet-vim; config = readFile ./config/emmet-vim-config.vim; }
    { plugin = fugitive; }
    { plugin = fzf-vim; config = readFile ./config/fzf-vim-config.vim; }
    { plugin = galaxyline-nvim; config = galaxyline-config; }
    { plugin = gitsigns-nvim; config = gitsignsConfig; }
    { plugin = gruvbox; config = readFile ./config/theme-config.vim; }
    { plugin = LanguageClient-neovim; config = (readFile ./config/LanguageClient-neovim-config.vim) + lspConfig; }
    { plugin = neoformat; config = readFile ./config/neoformat-config.vim; }
    { plugin = nvim-dap-virtual-text; }
    { plugin = nvim-dap; config = dapConfig + (readFile ./config/nvim-dap-config.vim); }
    { plugin = nvim-tree-lua; config = readFile ./config/nvim-tree-lua-config.vim; }
    { plugin = nvim-treesitter-context; }
    { plugin = nvim-treesitter-refactor; }
    { plugin = nvim-treesitter-textobjects; config = readFile ./config/nvim-treesitter-textobjects-config.vim; }
    { plugin = nvim-treesitter; config = readFile ./config/nvim-treesitter-config.vim; }
    { plugin = nvim-web-devicons; }
    { plugin = plenary-nvim; }
    { plugin = scrollbar-nvim; config = readFile ./config/scrollbar-nvim-config.vim; }
    { plugin = surround; }
    { plugin = tabular; }
    { plugin = vim-closetag; config = readFile ./config/vim-closetag-config.vim; }
    { plugin = vim-commentary; }
    { plugin = vim-cursorword; }
    { plugin = vim-dadbod-ui; }
    { plugin = vim-dadbod; }
    { plugin = vim-devicons; }
    { plugin = vim-dispatch; }
    { plugin = vim-polyglot; }
    { plugin = vim-prisma; }
    { plugin = vim-repeat; }
    { plugin = vim-sensible; }
    { plugin = vim-tmux-navigator; }
    { plugin = vimagit; }
  ];

  configs =
    builtins.concatStringsSep ''
        ''
      (map
        (plugin: ''
          "{{{ ${plugin.plugin.name}
            ${if (builtins.hasAttr "config" plugin) then builtins.getAttr "config" plugin else ""}
          "}}} 
        '')
        plugins);


  #TODO:

  #prettierPkgs = yarn2nix-moretea.mkYarnPackage {
  #  name = "prettierPkgs";
  #  src = ../../pkgs/node_packages/prettierPkgs;
  #  packageJSON = ../../pkgs/node_packages/prettierPkgs/package.json;
  #  yarnLock = ../../pkgs/node_packages/prettierPkgs/yarn.lock;
  #  publishBinsFor = [ "prettier" ];
  #};

  pyls = python3Packages.python-language-server.overrideAttrs
    (oldAttrs: {
      doInstallCheck = false;
    });

  formatters = [
    gofumpt
    ktlint
    nixpkgs-fmt
    ocamlformat
    ormolu
    nodePackages.prettier
    #prettierPkgs
    python3Packages.black
    python3Packages.isort
    rubocop
    rustfmt
    scalafmt
    terraform
    uncrustify
  ];

  lsHelpers = [ ocamlPackages.merlin ];

  # TODO: needs overlayed
  # \ 'java'            : ['${jdtls}/bin/jdt-language-server'], 

  lspConfig = ''
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
  '';

  dapConfig = ''
    packadd nvim-dap
    lua << EOF

    local dap = require('dap')
    dap.adapters.python = {
      type = 'executable',
      command = '${python3.withPackages (ps: [ ps.debugpy ])}/bin/python',
      args = { '-m', 'debugpy.adapter' }
    }

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = "Launch File",
        program = "''${file}",
        pythonPath = function(adapter)
          return '${python3}/bin/python'
        end
      }
    }

    EOF
  '';

  galaxyline-config = ''
    lua << EOF
      ${builtins.readFile ./config/galaxyline-nvim-config.lua}
    EOF
  '';

  gitsignsConfig = ''
    lua << EOF
      ${builtins.readFile ./config/gitsigns-nvim-config.lua} 
    EOF
  '';


in
{
  neovitality = pkgs.wrapNeovim pkgs.neovim-nightly {
    configure = {
      customRC = ''
        ${builtins.readFile ./config/init.vim}
      '' + configs;

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = map (plugin: plugin.plugin) plugins;
        opt = [ ];
      };
    };

  };
}
