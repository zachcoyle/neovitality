{ config, lib, pkgs, ... }:

with lib;
with builtins;
let
  mkMappingOption = it: mkOption ({
    example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; }; # Probably should be overwritten per option basis
    default = { };
    type = with types; attrsOf (nullOr str);
  } // it);
in
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

    configRC = mkOption {
      default = "";
      description = ''VimScript config'';
      type = types.lines;
    };



    globals = mkOption {
      example = { some_fancy_varialbe = 1; };
      default = { };
      type = types.attrs;
    };

    nnoremap = mkMappingOption {
      description = "Defines 'Normal mode' mappings";
    };

    inoremap = mkMappingOption {
      description = "Defines 'Insert and Replace mode' mappings";
    };

    vnoremap = mkMappingOption {
      description = "Defines 'Visual and Select mode' mappings";
    };

    xnoremap = mkMappingOption {
      description = "Defines 'Visual mode' mappings";
    };

    snoremap = mkMappingOption {
      description = "Defines 'Select mode' mappings";
    };

    cnoremap = mkMappingOption {
      description = "Defines 'Command-line mode' mappings";
    };

    onoremap = mkMappingOption {
      description = "Defines 'Operator pending mode' mappings";
    };

    tnoremap = mkMappingOption {
      description = "Defines 'Terminal mode' mappings";
    };



    nmap = mkMappingOption {
      description = "Defines 'Normal mode' mappings";
    };

    imap = mkMappingOption {
      description = "Defines 'Insert and Replace mode' mappings";
    };

    vmap = mkMappingOption {
      description = "Defines 'Visual and Select mode' mappings";
    };

    xmap = mkMappingOption {
      description = "Defines 'Visual mode' mappings";
    };

    smap = mkMappingOption {
      description = "Defines 'Select mode' mappings";
    };

    cmap = mkMappingOption {
      description = "Defines 'Command-line mode' mappings";
    };

    omap = mkMappingOption {
      description = "Defines 'Operator pending mode' mappings";
    };

    tmap = mkMappingOption {
      description = "Defines 'Terminal mode' mappings";
    };
  };

  config =
    let
      matchCtrl = it: match "Ctrl-(.)(.*)" it;
      filterNonNull = mappings: filterAttrs (name: value: value != null) mappings;

      mapKeybinding = it:
        let groups = matchCtrl it; in if groups == null then it else "<C-${toUpper (head groups)}>${head (tail groups)}";
      mapVimBinding = prefix: mappings: mapAttrsFlatten (name: value: "${prefix} ${mapKeybinding name} ${value}") (filterNonNull mappings);

      globalsVimscript = mapAttrsFlatten (name: value: "let g:${name}=${toJSON value}") (filterNonNull config.vim.globals);

      nmap = mapVimBinding "nmap" config.vim.nmap;
      imap = mapVimBinding "imap" config.vim.imap;
      vmap = mapVimBinding "vmap" config.vim.vmap;
      xmap = mapVimBinding "xmap" config.vim.xmap;
      smap = mapVimBinding "smap" config.vim.smap;
      cmap = mapVimBinding "cmap" config.vim.cmap;
      omap = mapVimBinding "omap" config.vim.omap;
      tmap = mapVimBinding "tmap" config.vim.tmap;

      nnoremap = mapVimBinding "nnoremap" config.vim.nnoremap;
      inoremap = mapVimBinding "inoremap" config.vim.inoremap;
      vnoremap = mapVimBinding "vnoremap" config.vim.vnoremap;
      xnoremap = mapVimBinding "xnoremap" config.vim.xnoremap;
      snoremap = mapVimBinding "snoremap" config.vim.snoremap;
      cnoremap = mapVimBinding "cnoremap" config.vim.cnoremap;
      onoremap = mapVimBinding "onoremap" config.vim.onoremap;
      tnoremap = mapVimBinding "tnoremap" config.vim.tnoremap;

      attrsWithConfig = filter (it: it ? config) config.vim.plugins;
      configs = builtins.concatStringsSep " " (map
        (plugin: ''

        "{{{ ${plugin.plugin.name}
        ${plugin.config}
        "}}}
      '')
        (attrsWithConfig));
      start = map (plugin: plugin.plugin) config.vim.plugins;
    in
    {
      vim.startPlugins = start;
      vim.configRC = ''
        ${configs}
        ${builtins.concatStringsSep "\n" nmap}
        ${builtins.concatStringsSep "\n" imap}
        ${builtins.concatStringsSep "\n" vmap}
        ${builtins.concatStringsSep "\n" xmap}
        ${builtins.concatStringsSep "\n" smap}
        ${builtins.concatStringsSep "\n" cmap}
        ${builtins.concatStringsSep "\n" omap}
        ${builtins.concatStringsSep "\n" tmap}

        ${builtins.concatStringsSep "\n" nnoremap}
        ${builtins.concatStringsSep "\n" inoremap}
        ${builtins.concatStringsSep "\n" vnoremap}
        ${builtins.concatStringsSep "\n" xnoremap}
        ${builtins.concatStringsSep "\n" snoremap}
        ${builtins.concatStringsSep "\n" cnoremap}
        ${builtins.concatStringsSep "\n" onoremap}
        ${builtins.concatStringsSep "\n" tnoremap}
        ${builtins.concatStringsSep "\n" globalsVimscript}
      '';
    };
}
