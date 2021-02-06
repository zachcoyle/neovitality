{ pkgs, lib ? pkgs.lib }:
with builtins;
with lib;
let
  wrapLuaConfig = luaConfig: ''
    lua << EOF
    ${luaConfig}
    EOF
  '';

  lspConfigs =
    wrapLuaConfig (import ./config/nvim-lspconfig-config.nix { inherit pkgs; }) +
    wrapLuaConfig (readFile ./config/nvim-lspconfig-config.lua);

  dapConfig = import ./config/nvim-dap-config.nix { inherit pkgs; };

  gitsignsConfig = wrapLuaConfig (builtins.readFile ./config/gitsigns-nvim-config.lua);
  galaxyline-config = wrapLuaConfig (builtins.readFile ./config/galaxyline-nvim-config.lua);

in
{
  plugins = with pkgs.vimPlugins; with pkgs.vitalityVimPlugins;  [
    { plugin = auto-pairs; }
    { plugin = barbar-nvim; }
    { plugin = colorizer; }
    { plugin = conjure; }
    { plugin = direnv-vim; config = readFile ./config/direnv-vim-config.vim; }
    { plugin = editorconfig-vim; }
    { plugin = emmet-vim; config = readFile ./config/emmet-vim-config.vim; }
    { plugin = formatter-nvim; config = wrapLuaConfig (import ./config/formatter-nvim-config.nix { inherit pkgs; }); }
    { plugin = fugitive; }
    { plugin = fzf-vim; config = readFile ./config/fzf-vim-config.vim; }
    { plugin = galaxyline-nvim; config = galaxyline-config; }
    { plugin = gitsigns-nvim; config = gitsignsConfig; }
    { plugin = gruvbox; config = readFile ./config/theme-config.vim; }
    { plugin = lspkind-nvim; config = "lua require('lspkind').init()"; }
    #{ plugin = lush-nvim; config = wrapLuaConfig (import ./config/lush-nvim-config.nix { inherit pkgs; }); }
    { plugin = nvim-compe; config = wrapLuaConfig (readFile ./config/nvim-compe-config.lua); }
    { plugin = nvim-dap-virtual-text; }
    { plugin = nvim-dap; config = dapConfig + (readFile ./config/nvim-dap-config.vim); }
    { plugin = nvim-tree-lua; config = readFile ./config/nvim-tree-lua-config.vim; }
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
    { plugin = vim-parinfer; }
    { plugin = vim-polyglot; }
    { plugin = vim-prisma; }
    { plugin = vim-repeat; }
    { plugin = vim-sensible; }
    { plugin = vim-startify; config = readFile ./config/vim-startify-config.vim; }
    { plugin = vim-tmux-navigator; }
    { plugin = vimagit; }
    { plugin = nvim-lspconfig; config = lspConfigs; }
    { plugin = vim-vsnip; }
  ] ++ optionals (pkgs.system == "x86_64-darwin") [
    #TODO: install treesitter grammars from nix
    { plugin = nvim-treesitter; config = readFile ./config/nvim-treesitter-config.vim; }
    { plugin = nvim-treesitter-context; }
    { plugin = nvim-treesitter-refactor; }
    { plugin = nvim-treesitter-textobjects; config = readFile ./config/nvim-treesitter-textobjects-config.vim; }
  ];

  configRC = ''
    ${builtins.readFile ./config/init.vim}
  '';
}
