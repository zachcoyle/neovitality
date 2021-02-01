{
  description = "Big Neovim Energy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgsMaster.url = "github:nixos/nixpkgs/master";

    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nur.url = "github:nix-community/NUR";

    galaxyline-nvim = { url = "github:glepnir/galaxyline.nvim"; flake = false; };
    scrollbar-nvim = { url = "github:Xuyuanp/scrollbar.nvim"; flake = false; };
    vim-dadbod-ui = { url = "github:kristijanhusak/vim-dadbod-ui"; flake = false; };
    vim-prisma = { url = "github:pantharshit00/vim-prisma"; flake = false; };

  };

  outputs = { self, nixpkgs, flake-utils, nixpkgsMaster, nur, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        vim-plugins-overlay = import ./vim-plugins-overlay.nix;
        neovitality-overlay = import ./neovitality-overlay.nix;

        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays = [
            (vim-plugins-overlay inputs)
            inputs.neovim-nightly-overlay.overlay
            (neovitality-overlay { pkgs = pkgs; })
            nur.overlay
            (final: prev: {
              bleedingEdge = nixpkgsMaster.legacyPackages."${system}";
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
