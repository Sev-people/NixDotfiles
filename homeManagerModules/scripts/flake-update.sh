set -e
pushd ~/.dotfiles/

git diff -U0 *.nix
echo "NixOS Rebuilding..."
if ! sudo nixos-rebuild switch --flake .#default &> nixos-switch.log; then
  grep --color error nixos-switch.log || cat nixos-switch.log
  exit 1
fi
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd
