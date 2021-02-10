{ config ? { }, lib, pkgs, ... }:
let
  buildConfig = import ./buildConfig.nix { inherit lib pkgs; };
  vimOptions = import ./vim.nix { inherit pkgs lib config; };
in
{
  options = {
    vim = vimOptions.options;
  };
  config = vimOptions.config;
}
