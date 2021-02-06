{ config, lib, pkgs, ... }:

with lib;
with builtins;

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


    nnoremap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Normal mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    inoremap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Insert and Replace mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    vnoremap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Visual and Select mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    xnoremap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Visual mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    snoremap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Select mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    cnoremap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Command-line mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    onoremap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Operator pending mode' mappings";
      type = with types; attrsOf (nullOr str);
    };



    nmap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Normal mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    imap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Insert and Replace mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    vmap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Visual and Select mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    xmap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Visual mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    smap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Select mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    cmap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Command-line mode' mappings";
      type = with types; attrsOf (nullOr str);
    };

    omap = mkOption {
      example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; };
      description = "Defines 'Operator pending mode' mappings";
      type = with types; attrsOf (nullOr str);
    };
  };

  config =
    let
      matchCtrl = it: match "Ctrl-(.)(.*)" it;
      filterMappings = mappings: filterAttrs (name: value: value != null) mappings;
      mapKeybinding = it:
        let groups = matchCtrl it; in if groups == null then it else "<C-${toUpper (head groups)}>${head (tail groups)}";
      mapVimBinding = prefix: mappings: mapAttrsFlatten (name: value: "${prefix} ${mapKeybinding name} ${value}") (filterMappings mappings);

      nmap = mapVimBinding "nmap" config.vim.nmap;
      imap = mapVimBinding "imap" config.vim.imap;
      vmap = mapVimBinding "vmap" config.vim.vmap;
      xmap = mapVimBinding "xmap" config.vim.xmap;
      smap = mapVimBinding "smap" config.vim.smap;
      cmap = mapVimBinding "cmap" config.vim.cmap;
      omap = mapVimBinding "omap" config.vim.omap;

      nnoremap = mapVimBinding "nmap" config.vim.nmap;
      inoremap = mapVimBinding "inoremap" config.vim.inoremap;
      vnoremap = mapVimBinding "vnoremap" config.vim.vnoremap;
      xnoremap = mapVimBinding "xnoremap" config.vim.xnoremap;
      snoremap = mapVimBinding "snoremap" config.vim.snoremap;
      cnoremap = mapVimBinding "cnoremap" config.vim.cnoremap;
      onoremap = mapVimBinding "onoremap" config.vim.onoremap;

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

        ${builtins.concatStringsSep "\n" nnoremap}
        ${builtins.concatStringsSep "\n" inoremap}
        ${builtins.concatStringsSep "\n" vnoremap}
        ${builtins.concatStringsSep "\n" xnoremap}
        ${builtins.concatStringsSep "\n" snoremap}
        ${builtins.concatStringsSep "\n" cnoremap}
        ${builtins.concatStringsSep "\n" onoremap}
      '';
    };
}
