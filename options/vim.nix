{ config, lib, pkgs, ... }:

with lib;
with builtins;
let
  wrapLuaConfig = luaConfig: ''
    lua << EOF
    ${luaConfig}
    EOF
  '';
  mkMappingOption = it: mkOption ({
    example = { abc = ":FZF<CR>"; Ctrl-p = ":FZF<CR>"; }; # Probably should be overwritten per option basis
    default = { };
    type = with types; attrsOf (nullOr str);
  } // it);
  languagesOpts = { name, config, ... }: {
    options = {
      lspConfig = {

        cmd = mkOption {
          default = [ ];
          type = with types; listOf str;
        };

        filetypes = mkOption {
          default = [ ];
          type = with types; listOf str;
        };
      };
    };
  };
in
{
  options = {
    vim.enable = mkEnableOption "vitality vim package";

    vim.languages = mkOption {
      default = { };
      type = with types; attrsOf (submodule languagesOpts);
    };

    vim.startPlugins = mkOption {
      type = with types; listOf package;
      default = [ ];
      description = "";
      example = [ pkgs.vim-clap ];
    };

    vim.optPlugins = mkOption {
      type = with types; listOf package;
      default = [ ];
      description = "";
      example = [ pkgs.vim-clap ];
    };

    vim.plugins = mkOption {
      type = with types; listOf attrs; # Probably some legit type should be set
      default = [ ];
      description = "";
      example = [{ plugin = pkgs.vim-clap; config = "abc"; }];
    };

    vim.configRC = mkOption {
      default = "";
      description = ''VimScript config'';
      type = types.lines;
    };



    vim.globals = mkOption {
      example = { some_fancy_varialbe = 1; };
      default = { };
      type = types.attrs;
    };

    vim.nnoremap = mkMappingOption {
      description = "Defines 'Normal mode' mappings";
    };

    vim.inoremap = mkMappingOption {
      description = "Defines 'Insert and Replace mode' mappings";
    };

    vim.vnoremap = mkMappingOption {
      description = "Defines 'Visual and Select mode' mappings";
    };

    vim.xnoremap = mkMappingOption {
      description = "Defines 'Visual mode' mappings";
    };

    vim.snoremap = mkMappingOption {
      description = "Defines 'Select mode' mappings";
    };

    vim.cnoremap = mkMappingOption {
      description = "Defines 'Command-line mode' mappings";
    };

    vim.onoremap = mkMappingOption {
      description = "Defines 'Operator pending mode' mappings";
    };

    vim.tnoremap = mkMappingOption {
      description = "Defines 'Terminal mode' mappings";
    };



    vim.nmap = mkMappingOption {
      description = "Defines 'Normal mode' mappings";
    };

    vim.imap = mkMappingOption {
      description = "Defines 'Insert and Replace mode' mappings";
    };

    vim.vmap = mkMappingOption {
      description = "Defines 'Visual and Select mode' mappings";
    };

    vim.xmap = mkMappingOption {
      description = "Defines 'Visual mode' mappings";
    };

    vim.smap = mkMappingOption {
      description = "Defines 'Select mode' mappings";
    };

    vim.cmap = mkMappingOption {
      description = "Defines 'Command-line mode' mappings";
    };

    vim.omap = mkMappingOption {
      description = "Defines 'Operator pending mode' mappings";
    };

    vim.tmap = mkMappingOption {
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

      luaArray = name: values: optionalString
        (any (it: true) values)
        "${name} = {'${builtins.concatStringsSep "', '" values}'},";


      buildLspConfig = name: config: ''
        lspconfig.${name}.setup {
          ${luaArray "cmd" config.cmd}
          ${luaArray "filetypes" config.filetypes}
        }
      '';
      lspConfigs = mapAttrsFlatten (name: value: buildLspConfig name value.lspConfig) config.vim.languages;
    in
    {
      vim.languages = import ./lspDefaults.nix { inherit pkgs; };

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

        ${wrapLuaConfig ''
            local lspconfig = require'lspconfig'

            ${builtins.concatStringsSep "\n" lspConfigs}

            local function preview_location_callback(_, _, result)
              if result == nil or vim.tbl_isempty(result) then
                return nil
              end
              vim.lsp.util.preview_location(result[1])
            end

            function PeekDefinition()
              local params = vim.lsp.util.make_position_params()
              return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
            end
          ''}
      '';
    };
}
