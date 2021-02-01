{ pkgs }: final: prev:
let
  plugins = [ ];
in
{
  neovitality = pkgs.wrapNeovim pkgs.neovim-nightly {
    configure = {
      customRC = ''
        ${builtins.readFile ./config/init.vim}
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = plugins;
        opt = [ ];
      };
    };

  };
}
