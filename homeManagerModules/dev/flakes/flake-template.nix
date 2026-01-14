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
          ];
        };

        # For other dependencies
        nativeBuildInputs = [ pkgs.pkg-config ];
      };
}
