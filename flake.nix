{
  description = "Big Neovim Energy";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    nur.url = github:nix-community/NUR;

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

    rnix-lsp.url = github:nix-community/rnix-lsp;

  };

  outputs = { self, nixpkgs, neovim, rnix-lsp, flake-utils, nur, vim-plugins-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays = [
            vim-plugins-overlay.overlay
            nur.overlay
            (final: prev: {
              neovim-nightly = neovim.defaultPackage.${system};
              rnix-lsp = rnix-lsp.defaultPackage.${system};
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
            vim = import ./examples/defaultConfig.nix { inherit pkgs; };
          };
        };

        apps = {
          nvim = flake-utils.lib.mkApp {
            drv = defaultPackage;
            name = "nvim";
          };
        };

        defaultApp = apps.nvim;

        devShell = pkgs.mkShell {
          inherit system;
          buildInputs = [
            defaultPackage
          ];
        };

      }
    );
}
