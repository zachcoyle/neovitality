{ pkgs }: final: prev:
with pkgs;
with builtins;
let
  plugins = with pkgs.vitalityVimPlugins;  [
    { plugin = auto-pairs; }
    { plugin = barbar-nvim; }
    { plugin = colorizer; }
    { plugin = conjure; }
    { plugin = deoplete-nvim; config = readFile ./config/deoplete-nvim-config.vim; }
    { plugin = direnv-vim; config = readFile ./config/direnv-vim-config.vim; }
    { plugin = editorconfig-vim; }
    { plugin = emmet-vim; config = readFile ./config/emmet-vim-config.vim; }
    { plugin = formatter-nvim; config = wrapLuaConfig (import ./config/formatter-nvim-config.nix { inherit pkgs; }); }
    { plugin = fugitive; }
    { plugin = fzf-vim; config = readFile ./config/fzf-vim-config.vim; }
    { plugin = galaxyline-nvim; config = galaxyline-config; }
    { plugin = gitsigns-nvim; config = gitsignsConfig; }
    { plugin = gruvbox; config = readFile ./config/theme-config.vim; }
    { plugin = LanguageClient-neovim; config = (readFile ./config/LanguageClient-neovim-config.vim) + lspConfig; }
    { plugin = nvim-dap-virtual-text; }
    { plugin = nvim-dap; config = dapConfig + (readFile ./config/nvim-dap-config.vim); }
    { plugin = nvim-tree-lua; config = readFile ./config/nvim-tree-lua-config.vim; }
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
  ] ++ lib.optionals (pkgs.system == "x86_64-darwin") [
    #TODO: install treesitter grammars from nix
    { plugin = nvim-treesitter-context; }
    { plugin = nvim-treesitter-refactor; }
    { plugin = nvim-treesitter-textobjects; config = readFile ./config/nvim-treesitter-textobjects-config.vim; }
  ];

  # TODO: probably a lib function for this somewhere...
  getOrDefault = attribute: defaultValue: attrSet:
    if
      (builtins.hasAttr attribute attrSet)
    then
      (builtins.getAttr attribute attrSet)
    else defaultValue;

  configs =
    builtins.concatStringsSep ''
        ''
      (map
        (plugin: ''
          "{{{ ${plugin.plugin.name}

          ${getOrDefault "config" "" plugin }

          "}}}
        '')
        plugins);

  dapConfig = import ./config/nvim-dap-config.nix { inherit pkgs; };
  lspConfig = import ./config/LanguageClient-neovim-config.nix { inherit pkgs; };

  wrapLuaConfig = luaConfig: ''
    lua << EOF
    ${luaConfig}
    EOF
  '';

  gitsignsConfig = wrapLuaConfig (builtins.readFile ./config/gitsigns-nvim-config.lua);
  galaxyline-config = wrapLuaConfig (builtins.readFile ./config/galaxyline-nvim-config.lua);

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
