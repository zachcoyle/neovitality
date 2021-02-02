{ pkgs }:
let
  prettier_fn = ''
    function()
      return {
        exe = '${pkgs.nodePackages.prettier}/bin/prettier',
        args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
        stdin = true,
      }
    end
  '';

  buildFormatter = { exe, args ? [ ], stdin }: ''
    function()
      return {
        exe = '${exe}',
        args = { ${builtins.concatStringsSep ", " args} },
        stdin = ${if stdin then "true" else "false"},
      }
    end,
  '';

  buildFormatterGroup = { filetype, formatters }:
    ''
      ${filetype} = {
        ${builtins.concatStringsSep newline (map buildFormatter formatters)}
      },
    '';

  prettierFormatter = {
    exe = "${pkgs.nodePackages.prettier}/bin/prettier";
    args = [ "'--stdin-filepath'" "vim.api.nvim_buf_get_name(0)" ];
    stdin = true;
  };

  filetypes = {
    nix = {
      extension = "nix";
      formatters = [
        {
          exe = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          args = [ ];
          stdin = true;
        }
      ];
    };
    python = {
      extension = "py";
      formatters = [
        {
          exe = "${pkgs.python3Packages.black}/bin/black";
          args = [ "'-q'" "'-'" ];
          stdin = true;
        }
        {
          exe = "${pkgs.python3Packages.isort}/bin/isort";
          args = [ "'-'" ];
          stdin = true;
        }
      ];
    };
    javascript = {
      extension = "js";
      formatters = [ prettierFormatter ];
    };

    javascriptreact = {
      extension = "jsx";
      formatters = [ prettierFormatter ];
    };

    typescript = {
      extension = "ts";
      formatters = [ prettierFormatter ];
    };

    typescriptreact = {
      extension = "tsx";
      formatters = [ prettierFormatter ];
    };

  };

  newline = ''
  '';

  enabledLanguages = builtins.attrNames filetypes;

  autoSaveFiletypes = "*." + builtins.concatStringsSep ",*." (map (l: (builtins.getAttr l filetypes).extension) enabledLanguages);

  buildFormatterGroupByName = language:
    let
      filetypeSettings = builtins.getAttr language filetypes;
    in
    buildFormatterGroup {
      filetype = language;
      formatters = filetypeSettings.formatters;
    };

in
''
  require('formatter').setup({
    logging = true,
    filetype = {
      ${builtins.concatStringsSep newline ((map buildFormatterGroupByName enabledLanguages))}
    }
  })

  vim.api.nvim_exec([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost ${autoSaveFiletypes} FormatWrite
  augroup END
  ]], true)
''
