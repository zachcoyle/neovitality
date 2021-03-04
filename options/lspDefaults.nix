{ pkgs }:

with pkgs;
{

  bashls = {
    lspConfig = {
      cmd = [ "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server" "start" ];
    };
  };

  #clojure_lsp = {
  #  lspConfig = {
  #    cmd = [ "${clojure-lsp}/bin/clojure-lsp" ];
  #  };
  #};

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
      /*


      # from derivation: 

    3 # Example:
    4
    5 # jdt-ls -Xms500M --java-opts "-Xdiag -showversion" -data /tmp/jdtls_workspace
    6 #                                                                                                                                                                                                                                    ▲
    7 # === executes ===>                                                                                                                                                                                                                  █
    8 #                                                                                                                                                                                                                                    █
    9 # java \                                                                                                                                                                                                                             █
   10 #  -Xms500M \                                                                                                                                                                                                                        █
   11 #  -Xmx2G \                                                                                                                                                                                                                          █
   12 #  -Dlog.level=INFO  \                                                                                                                                                                                                               ▼
   13 #  -Xdiag \
   14 #  -showversion \
   15 #  -jar /nix/store/...equinox.launcher.jar \
   16 #  --add-modules=ALL-SYSTEM \
   17 #  --add-opens java.base/java.util=ALL-UNNAMED \
   18 #  --add-opens java.base/java.lang=ALL-UNNAMED \
   19 #  -configuration /tmp/jdtls_config/stXVO \
   20 #  -data /tmp/jdtls_workspace
      */





      cmd = [
        "${jdt-ls}/bin/jdt-ls"
        "-Xms500M"
        "-configuration"
        "tostring(vim.fn.getenv(\"JDTLS_CONFIG\"))"
        "-data"
        "tostring(vim.fn.getenv(\"WORKSPACE\"))"
        "--add-modules=ALL-SYSTEM"
        "--add-opens java.base/java.util=ALL-UNNAMED"
        "--add-opens java.base/java.lang=ALL-UNNAMED"

        # from lsp-config:
        #########
        # "util.path.join(tostring(vim.fn.getenv(\"JAVA_HOME\")), \"/bin/java\")"
        # "-Declipse.application=org.eclipse.jdt.ls.core.id1"
        # "-Dosgi.bundles.defaultStartLevel=4"
        # "-Declipse.product=org.eclipse.jdt.ls.core.product"
        # "-Dlog.protocol=true"
        # "-Dlog.level=ALL"
        # "-Xms1g"
        # "-Xmx2G"
        # "-jar"
        # "tostring(vim.fn.getenv(\"JAR\"))"
        # "-configuration"
        # "tostring(vim.fn.getenv(\"JDTLS_CONFIG\"))"
        # "-data"
        # "tostring(vim.fn.getenv(\"WORKSPACE\"))"
        # "--add-modules=ALL-SYSTEM"
        # "--add-opens java.base/java.util=ALL-UNNAMED"
        # "--add-opens java.base/java.lang=ALL-UNNAMED"

        # also there is https://github.com/mfussenegger/nvim-jdtls

      ];
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

  solargraph = {
    lspConfig = {
      cmd = [ "${solargraph}/bin/solargraph" "stdio" ];
    };
  };

  rust_analyzer = {
    lspConfig = {
      cmd = [ "${rust-analyzer}/bin/rust-analyzer" ];
      useCapabilities = true;
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
      useCapabilities = true;
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
