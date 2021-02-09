inputs: final: prev:
let
  inherit (prev.vimUtils) buildVimPluginFrom2Nix;

  buildVitalityPlugin = name: buildVimPluginFrom2Nix {
    pname = name;
    version = "master";
    src = builtins.getAttr name inputs;
  };

  plugins = [
    "formatter-nvim"
    "fzf-lsp-nvim"
    "galaxyline-nvim"
    "lspkind-nvim"
    "lush-nvim"
    "nvim-compe"
    "nvim-lspconfig"
    "scrollbar-nvim"
    "snippets-nvim"
    "vim-dadbod-ui"
    "vim-prisma"
    "vim-vsnip"
  ];
in
{
  vitalityVimPlugins = builtins.listToAttrs
    (map
      (name:
        { inherit name; value = buildVitalityPlugin name; })
      plugins);

}
