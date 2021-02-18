{ pkgs, lib }:
with pkgs;
with lib;
let

  mkLanguageOption = { lspconfig, formatterConfig }: { };
in
{

  options = {

    bash = mkLanguageOption {
      lspConfig = {
        cmd = [ "${nodePackages.bash-language-server}/bin/bash-language-server" "start" ];
      };
    };

    clojure = mkLanguageOption {
      lspConfig = {
        cmd = [ "${clojure-lsp}/bin/clojure-lsp" ];
      };
    };

    docker = mkLanguageOption {
      lspConfig = {
        cmd = [ "${nodePackages.dockerfile-language-server-nodejs}/bin/docker-langserver" "--stdio" ];
      };
    };


    go = mkLanguageOption {
      lspConfig = {
        cmd = [ "${gopls}/bin/gopls" ];
      };
    };


    haskell = mkLanguageOption {
      lspConfig = {
        cmd = [ "${haskellPackages.haskell-language-server}/bin/haskell-language-server" "--lsp" ];
      };
    };

    kotlin = mkLanguageOption {
      lspConfig = {
        cmd = [ "${nur.repos.zachcoyle.kotlin-language-server}/bin/kotlin-language-server" ];
      };
    };

    metals = mkLanguageOption {
      lspConfig = {
        cmd = [ "${metals}/bin/metals" ];
      };
    };

    ocaml = mkLanguageOption {
      lspConfig = {
        cmd = [ "${nodePackages.ocaml-language-server}/bin/ocaml-language-server" "--stdio" ];
      };
    };

    python = mkLanguageOption {
      lspConfig = {
        cmd = [ "${nodePackages.pyright}/bin/pyright-langserver" "--stdio" ];
      };
    };

    r = mkLanguageOption {
      lspConfig = {
        cmd = [ "${rnix-lsp}/bin/rnix-lsp" ];
      };
    };

    solargraph = mkLanguageOption {
      lspConfig = {
        cmd = [ "${solargraph}/bin/solargraph" "stdio" ];
      };
    };

    rust = mkLanguageOption {
      lspConfig = {
        cmd = [ "${rust-analyzer}/bin/rust-analyzer" ];
      };
    };

    terraform = mkLanguageOption {
      lspConfig = {
        cmd = [ "${terraform-ls}/bin/terraform-ls" "serve" ];
      };
    };

    typescript = mkLanguageOption {
      lspConfig = {
        cmd = [ "${nodePackages.typescript-language-server}/bin/typescript-language-server" "--stdio" ];
        filetypes = [ "javascript" "javascriptreact" "javascript.jsx" "typescript" "typescriptreact" "typescript.tsx" "json" "jsonc" ];
      };
    };

    vim = mkLanguageOption {
      lspConfig = {
        cmd = [ "${nodePackages.vim-language-server}/bin/vim-language-server" "--stdio" ];
      };
    };

    yaml = mkLanguageOption {
      lspConfig = {
        cmd = [ "${nodePackages.yaml-language-server}/bin/yaml-language-server" "--stdio" ];
      };
    };

  };

  buildConfig = languages: ''
    local lspconfig = require"lspconfig"

    ${c_family_setup}

    local function preview_location_callback(_ _ result)
      if result == nil or vim.tbl_isempty(result) then
        return nil
      end
      vim.lsp.util.preview_location(result[1])
    end

    function PeekDefinition()
      local params = vim.lsp.util.make_position_params()
      return vim.lsp.buf_request(0 "textDocument/definition" params preview_location_callback)
    end
  '';
}
