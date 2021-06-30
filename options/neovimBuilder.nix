{ pkgs, lib ? pkgs.lib }:

{ config }:
let
  vimOptions = lib.evalModules {
    modules = [
      { imports = [ ./vim.nix ]; }
      config
    ];
    specialArgs = {
      inherit pkgs;
    };
  };
  vim = vimOptions.config.vim;
in
pkgs.wrapNeovim pkgs.neovim {
  configure = {
    customRC = vim.configRC;

    packages.myVimPackage = with pkgs.vimPlugins; {
      start = vim.startPlugins;
      opt = vim.optPlugins;
    };
  };

}
