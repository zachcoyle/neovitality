{ pkgs }:

with pkgs;
{

  bashls = {
    lspConfig = {
      cmd = [ "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server" "start" ];
    };
  };

  clojure_lsp = {
    lspConfig = {
      cmd = [ "${clojure-lsp}/bin/clojure-lsp" ];
    };
  };

  dhall_lsp_server = {
    lspConfig = {
      cmd = [ "${pkgs.dhall-lsp-server}/bin/dhall-lsp-server" ];
    };
  };

  dockerls = {
    lspConfig = {
      cmd = [ "${nodePackages.dockerfile-language-server-nodejs}/bin/docker-langserver" "--stdio" ];
    };
  };


  gopls = {
    lspConfig = {
      cmd = [ "${gopls}/bin/gopls" ];
    };
  };

  hls = {
    lspConfig = {
      cmd = [ "${haskellPackages.haskell-language-server}/bin/haskell-language-server" "--lsp" ];
    };
  };

  jdtls = {
    lspConfig = {
      cmd = [ "${jdt-language-server}/bin/jdt-language-server" ];
    };
  };

  kotlin_language_server = {
    lspConfig = {
      cmd = [ "${nur.repos.zachcoyle.kotlin-language-server}/bin/kotlin-language-server" ];
    };
  };

  metals = {
    lspConfig = {
      cmd = [ "${metals}/bin/metals" ];
    };
  };

  ocamlls = {
    lspConfig = {
      cmd = [ "${nodePackages.ocaml-language-server}/bin/ocaml-language-server" "--stdio" ];
    };
  };

  pyright = {
    lspConfig = {
      cmd = [ "${nodePackages.pyright}/bin/pyright-langserver" "--stdio" ];
    };
  };

  rnix = {
    lspConfig = {
      cmd = [ "${rnix-lsp}/bin/rnix-lsp" ];
    };
  };

  rust_analyzer = {
    lspConfig = {
      cmd = [ "${rust-analyzer}/bin/rust-analyzer" ];
    };
  };

  solargraph = {
    lspConfig = {
      cmd = [ "${solargraph}/bin/solargraph" "stdio" ];
    };
  };

  texlab = {
    lspConfig = {
      cmd = [ "${texlab}/bin/texlab" ];
    };
  };

  terraformls = {
    lspConfig = {
      cmd = [ "${terraform-ls}/bin/terraform-ls" "serve" ];
    };
  };

  tsserver = {
    lspConfig = {
      cmd = [ "${nodePackages.typescript-language-server}/bin/typescript-language-server" "--stdio" ];
      filetypes = [ "javascript" "javascriptreact" "javascript.jsx" "typescript" "typescriptreact" "typescript.tsx" "json" "jsonc" ];
    };
  };

  vimls = {
    lspConfig = {
      cmd = [ "${nodePackages.vim-language-server}/bin/vim-language-server" "--stdio" ];
    };
  };

  yamlls = {
    lspConfig = {
      cmd = [ "${nodePackages.yaml-language-server}/bin/yaml-language-server" "--stdio" ];
    };
  };
}
