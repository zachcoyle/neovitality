inputs: final: prev:
let
  inherit (prev.vimUtils) buildVimPluginFrom2Nix;
in
{
  myVimPlugins = {
    galaxyline-nvim = buildVimPluginFrom2Nix {
      pname = "galaxyline-nvim";
      version = "master";
      src = inputs.galaxyline-nvim;
    };
    scrollbar-nvim = buildVimPluginFrom2Nix {
      pname = "scrollbar-nvim";
      version = "master";
      src = inputs.scrollbar-nvim;
    };
    vim-dadbod-ui = buildVimPluginFrom2Nix {
      pname = "vim-dadbod-ui";
      version = "master";
      src = inputs.vim-dadbod-ui;
    };
    vim-prisma = buildVimPluginFrom2Nix {
      pname = "vim-prisma";
      version = "master";
      src = inputs.vim-prisma;
    };
  };
}
