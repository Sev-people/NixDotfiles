{
  description = "DevShell Template";

  # Inputs
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, flake-utils, ... }:
      let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};

        python-env = with pkgs; [
          (python3.withPackages (ps: with ps; [
            black
            mypy
            setuptools
            pip
          ]))
          ruff
          pyright
        ];

        # ========== [ ENVIRONMENTS ] ==========
        devShellPackages = [
          # python-env
        ];
        # ========== [ ENVIRONMENTS ] ==========

      in
      {
        devShells.${system}.default = pkgs.mkShell {
          packages = devShellPackages;
        };
      }
    );
}
