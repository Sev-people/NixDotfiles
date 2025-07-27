{
  description = "DevShell Template";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    devShells.default = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      /* PYTHON
      python-with-tools = pkgs.python3.withPackages (ps: with ps; [
        black
        mypy
        setuptools
        pip
        pylsp
      ]);
      */
    in pkgs.mkShell {
      packages = [
        pkgs.git
        pkgs.ruff

        /* PYTHON
        # python-with-tools
        */
      ];
    };
  };
}
