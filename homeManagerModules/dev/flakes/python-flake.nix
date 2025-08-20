{
  description = "DevShell Template";

  # Inputs
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
      let
        pkgs = nixpkgs.legacyPackages."x86_64-linux";

        external-deps = [

        ];
      in {
        devShells."x86_64-linux".default = pkgs.mkShell {
          packages = with pkgs; [
            (python3.withPackages (ps: with ps; [
              black
              mypy
              setuptools
              pip
            ]))
            ruff
            pyright
            external-deps
          ];
        };

        # For other dependencies
        nativeBuildInputs = [ pkgs.pkg-config ];
      };
}
