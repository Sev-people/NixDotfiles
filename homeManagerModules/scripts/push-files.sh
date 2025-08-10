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
    cd "$repo"

    git add .
    git commit -m "$(commit_message)" || echo "No changes to commit in $repo"
    git push
done
