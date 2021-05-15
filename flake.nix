{
  description = "Big Neovim Energy";

  inputs = {
    naersk = {
      url = github:nmattia/naersk;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = github:nixos/nixpkgs/master;
    nixpkgs-jdtls.url = github:nixos/nixpkgs/35925104b195ff6bbab8f645c56ecc0af62f87fd;
    flake-utils = {
      url = github:numtide/flake-utils;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = github:numtide/devshell;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = github:neovim/neovim?dir=contrib;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    vim-plugins-overlay = {
      url = github:vi-tality/vim-plugins-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    rnix-lsp = {
      url = github:nix-community/rnix-lsp;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.naersk.follows = "naersk";
    };

    clojure-lsp = {
      url = github:zachcoyle/clojure-lsp-flake;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, neovim, rnix-lsp, flake-utils, devshell, nur, vim-plugins-overlay, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs-jdtls = import inputs.nixpkgs-jdtls { inherit system; };
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays = [
            devshell.overlay
            vim-plugins-overlay.overlay
            nur.overlay
            (final: prev: {
              python = prev.python3;
              neovim-nightly = neovim.defaultPackage.${system};
              rnix-lsp = rnix-lsp.defaultPackage.${system};
              jdt-language-server = pkgs-jdtls.jdt-language-server;
              clojure-lsp = inputs.clojure-lsp.defaultPackage.${system};
            })
          ];
        };
        neovimBuilder = import ./options/neovimBuilder.nix { inherit pkgs; };
      in
      rec {

        inherit neovimBuilder;

        overlays = {
          vim-plugins-overlay = vim-plugins-overlay.overlay;
        };

        packages.neovim-nightly = neovim.defaultPackage.${system};

        defaultPackage = neovimBuilder {
          config = {
            vim = import ./defaults/defaultConfig.nix { inherit pkgs; };
          };
        };

        apps = {
          nvim = flake-utils.lib.mkApp {
            drv = defaultPackage;
            name = "nvim";
          };
        };

        defaultApp = apps.nvim;

        devShell = pkgs.devshell.mkShell {
          name = "neovitality";
          packages = [
            defaultPackage
            pkgs.tree-sitter
          ];

          commands = [
            {
              name = "nvim";
              command = "${defaultPackage}/bin/nvim";
              help = "alias for neovim with neovitality config";
            }
            {
              name = "vim";
              command = "${defaultPackage}/bin/nvim";
              help = "alias for neovim with neovitality config";
            }
          ];
        };

      }
    );
}
