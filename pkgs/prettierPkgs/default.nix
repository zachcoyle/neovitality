{ pkgs }:

pkgs.yarn2nix-moretea.mkYarnPackage {
  name = "prettierPkgs";
  src = ./.;
  packageJson = ./package.json;
  yarnLock = ./yarn.lock;
  publishBinsFor = [
    "prettier"
    "prettier-plugin-java"
  ];
}
