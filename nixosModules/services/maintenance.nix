{ ... }:

{

  nix.optimise.automatic = true;

  # Run the GC weekly keeping the 5 most recent generation of each profiles.
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

}
