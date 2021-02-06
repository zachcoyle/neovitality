{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    enable = mkEnableOption "vitality vim package";

    startPlugins = mkOption {
      type = with types; listOf package;
      default = [ ];
      description = "";
      example = [ pkgs.vim-clap ];
    };

    optPlugins = mkOption {
      type = with types; listOf package;
      default = [ ];
      description = "";
      example = [ pkgs.vim-clap ];
    };

    plugins = mkOption {
      type = with types; listOf attrs; # Probably some legit type should be set
      default = [ ];
      description = "";
      example = [{ plugin = pkgs.vim-clap; config = "abc"; }];
    };

    vimScript = mkOption {
      default = "";
      description = ''VimScript config'';
      type = types.lines;
    };

  };

  config =
    let
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
            config.vim.plugins);
      start = map (plugin: plugin.plugin) config.vim.plugins;
    in
    {
      vim.startPlugins = start;
      vim.vimScript = configs;
    };
}
