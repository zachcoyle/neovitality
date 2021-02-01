{ pkgs }: final: prev:

{
  neovitality = pkgs.wrapNeovim pkgs.neovim-nightly {
    configure = {
      customRC = '' 
        '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ ];
        opt = [ ];
      };
    };

  };
}
