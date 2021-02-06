{ pkgs, lib ? pkgs.lib }:

{ config }:
let
  vimOptions = lib.evalModules {
    modules = [
      { imports = [ ./default.nix ]; }
      config
    ];
  };
  vim = vimOptions.config.vim;
in
pkgs.wrapNeovim pkgs.neovim-nightly {
  configure = {
    customRC = ''
      ${vim.vimScript}
    '';

    packages.myVimPackage = with pkgs.vimPlugins; {
      start = vim.startPlugins;
      opt = vim.optPlugins;
    };
  };

}
