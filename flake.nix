{
  description = "Big Neovim Energy";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    nixpkgsMaster.url = github:nixos/nixpkgs/master;

    flake-utils.url = github:numtide/flake-utils;
    neovim = { url = github:neovim/neovim?dir=contrib; inputs.nixpkgs.follows = "nixpkgs"; };
    nur.url = github:nix-community/NUR;

    galaxyline-nvim = { url = github:glepnir/galaxyline.nvim; flake = false; };
    scrollbar-nvim = { url = github:Xuyuanp/scrollbar.nvim; flake = false; };
    vim-dadbod-ui = { url = github:kristijanhusak/vim-dadbod-ui; flake = false; };
    vim-prisma = { url = github:pantharshit00/vim-prisma; flake = false; };
    formatter-nvim = { url = github:mhartington/formatter.nvim; flake = false; };

  };

  outputs = { self, nixpkgs, neovim, flake-utils, nixpkgsMaster, nur, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        vim-plugins-overlay = import ./vim-plugins-overlay.nix;
        neovitality-overlay = import ./neovitality-overlay.nix;

        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays = [
            (vim-plugins-overlay inputs)
            (neovitality-overlay { pkgs = pkgs; })
            nur.overlay
            (final: prev: {
              bleedingEdge = nixpkgsMaster.legacyPackages."${system}";
              neovim-nightly = neovim.defaultPackage.${system};
            })
          ];
        };
      in
      rec {
        defaultPackage = pkgs.neovitality;

        apps = {
          nvim = flake-utils.lib.mkApp {
            drv = pkgs.neovitality;
            name = "nvim";
          };
        };

        defaultApp = apps.nvim;
      }
    );
}
