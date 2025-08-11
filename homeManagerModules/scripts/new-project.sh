set -euo pipefail

PROJECT_NAME="$1"
PROJECT_DIR="$HOME/Projects/$PROJECT_NAME"
TEMPLATE_FILE="$HOME/.dotfiles/homeManagerModules/dev/flakes/project-template.nix"

mkdir -p "$PROJECT_DIR"

cp "$TEMPLATE_FILE" "$PROJECT_DIR/flake.nix"

# Set up direnv
echo "use nix-direnv" > "$PROJECT_DIR/.envrc"
cd "$PROJECT_DIR"
direnv allow
