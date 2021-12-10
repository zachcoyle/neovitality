{ pkgs }:
let
  buildFormatter = { exe, args ? [ ], stdin ? true }: ''
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

  prettierFormatter = { parser ? null, exe ? null }:
    let
      parserArgs =
        if parser != null
        then [ "'--parser'" "'${parser}'" ]
        else [ ];
    in
    {
      exe =
        if exe != null
        then exe
        else "prettier";
      args = [ "'--stdin-filepath'" "'\"' .. vim.api.nvim_buf_get_name(0) .. '\"'" ] ++ parserArgs;
    };

  clangFormatter = {
    exe = "clang-format";
    args = [ "'--assume-filename=' .. vim.api.nvim_buf_get_name(0)" ];
  };

  filetypes = {

    c = {
      extension = "c,*.h";
      formatters = [ clangFormatter ];
    };

    cpp = {
      extension = "cpp,*.h";
      formatters = [ clangFormatter ];
    };

    css = {
      extension = "css";
      formatters = [ (prettierFormatter { parser = "css"; }) ];
    };

    dhall = {
      extension = "dhall";
      formatters = [{ exe = "dhall"; args = [ "'format'" ]; }];
    };

    go = {
      extension = "go";
      formatters = [
        { exe = "gofumpt"; }
        { exe = "gofumports"; }
      ];
    };

    graphql = {
      extension = "graphql,*.gql";
      formatters = [ (prettierFormatter { parser = "graphql"; }) ];
    };

    haskell = {
      extension = "hs";
      formatters = [{ exe = "ormolu"; }];
    };

    javascript = {
      extension = "js";
      formatters = [ (prettierFormatter { }) ];
    };

    javascriptreact = {
      extension = "jsx";
      formatters = [ (prettierFormatter { }) ];
    };

    java = {
      extension = "java";
      formatters = [
        (prettierFormatter { parser = "java"; })
      ];
    };

    json = {
      extension = "json";
      formatters = [ (prettierFormatter { }) ];
    };

    jsonc = {
      extension = "json,*.jsonc";
      formatters = [ (prettierFormatter { }) ];
    };

    kotlin = {
      extension = "kt";
      formatters = [
        {
          exe = "ktlint";
          args = [ "'-F'" ];
        }
      ];
    };

    lua = {
      extension = "lua";
      formatters = [
        {
          exe = "stylua";
          args = [ "'--search-parent-directories'" "'--stdin-filepath'" "'\"%:p\"'" "'--'" "'-'" ];
        }
      ];
    };

    nix = {
      extension = "nix";
      formatters = [{ exe = "nixpkgs-fmt"; }];
    };

    objc = {
      extension = "m,*.h";
      formatters = [ clangFormatter ];
    };

    python = {
      extension = "py";
      formatters = [
        {
          exe = "isort";
          args = [ "'-'" ];
        }
        {
          exe = "black";
          args = [ "'-q'" "'-'" ];
        }
      ];
    };

    ruby = {
      extension = "rb";
      formatters = [
        {
          exe = "rubocop";
          args = [ "'--auto-correct'" "'--stdin'" "'\"%:p\"'" "'2>/dev/null'" "'|'" "'sed \"1,/^====================$/d\"'" ];
        }
      ];
    };

    rust = {
      extension = "rs";
      formatters = [{ exe = "rustfmt"; }];
    };

    scala = {
      extension = "scala,*.sc";
      formatters = [
        {
          exe = "scalafmt";
          args = [ "'--stdin'" ];

        }
      ];
    };

    sh = {
      extension = "sh";
      formatters = [
        {
          exe = "shfmt";
          args = [ "'-i 2'" ];
        }
      ];
    };

    terraform = {
      extension = "tf";
      formatters = [
        {
          exe = "terraform";
          args = [ "'fmt'" "'-write'" "'-'" ];
        }
      ];
    };

    typescript = {
      extension = "ts";
      formatters = [ (prettierFormatter { }) ];
    };

    typescriptreact = {
      extension = "tsx";
      formatters = [ (prettierFormatter { }) ];
    };

    yaml = {
      extension = "yml,*.yaml";
      formatters = [ (prettierFormatter { parser = "yaml"; }) ];
    };

  };

  # currently doesn't build :(
  # // (if pkgs.system != "x86_64-darwin" then { } else {
  #   swift = {
  #     extension = "swift";
  #     formatters = [
  #       {
  #         exe = "swiftformat";
  #       }
  #     ];
  #   };
  # });

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
    logging = false,
    filetype = {
      ${builtins.concatStringsSep newline ((map buildFormatterGroupByName enabledLanguages))}
    }
  })

  vim.api.nvim_exec([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost ${autoSaveFiletypes} silent FormatWrite
  augroup END
  ]], true)
''
