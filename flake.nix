{
  description = "Big Neovim Energy";

  inputs = {

    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgsMaster.url = "github:nixos/nixpkgs/master";
    nur.url = "github:nix-community/NUR";

    galaxyline-nvim = { url = "github:glepnir/galaxyline.nvim"; flake = false; };
    scrollbar-nvim = { url = "github:Xuyuanp/scrollbar.nvim"; flake = false; };
    vim-dadbod-ui = { url = "github:kristijanhusak/vim-dadbod-ui"; flake = false; };
    vim-prisma = { url = "github:pantharshit00/vim-prisma"; flake = false; };

  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
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
          ];
        };
      in
      {
        defaultPackage = pkgs.neovitality;
      }
    );
}
