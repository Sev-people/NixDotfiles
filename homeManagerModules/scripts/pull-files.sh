set -euo pipefail

# List of absolute paths
REPOS=(
  "/home/marc/.dotfiles"
  "/home/marc/Documents/work"
  "/home/marc/.password-store"
)

commit_message() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD)
  echo "Auto-commit on $(date '+%Y-%m-%d %H:%M:%S') [${branch}]"
}

for repo in "${REPOS[@]}"; do
  echo ">>> Processing repository: $repo"
  cd "$repo" || { echo "$repo not found"; continue; }
  
  git fetch origin main
  
  if git merge-base --is-ancestor HEAD origin/main; then
    git reset --hard origin/main
  else
    echo "[$repo] Not strictly behind. No reset."
    continue
  fi
done
