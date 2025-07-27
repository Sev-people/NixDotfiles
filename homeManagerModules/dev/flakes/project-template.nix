{
  description = "DevShell Template";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      /* PYTHON
      python-with-tools = pkgs.python3.withPackages (ps: with ps; [
        black
        mypy
        setuptools
        pip
        pylsp
      ]);
      */
      in
      {
        devShells.default = pkgs.mkShell { packages = [
        pkgs.git
        pkgs.ruff

        /* PYTHON
        # python-with-tools
        */
        ]; };
      }
    );
}
