#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Prompt for confirmation before deleting .terraform* files and directories
read -p "Do you want to delete .terraform* files and directories? (y/n): " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    # Delete .terraform* directories
    find . -type d -name '.terraform*' -exec rm -rf {} +
    # Delete .terraform* files
    find . -type f -name '.terraform*' -exec rm -f {} +
    # Delete terraform.tfstate* files
    find . -type f -name 'terraform.tfstate*' -exec rm -f {} +
    echo ".terraform* files and directories deleted."
else
    echo "Deletion of .terraform* files and directories skipped."
fi

# Prompt for commit description
read -p "Enter commit description: " description

# Git commands
git add .

# Ensure we are on the main branch
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    echo "Switching to the main branch."
    git checkout main
fi

# Pull latest changes from remote repository
echo "Pulling latest changes from remote repository."
if ! git pull --rebase origin main; then
    echo "Error: git pull failed. Resolve conflicts and try again."
    exit 1
fi

# Commit changes
if ! git commit -m "$description"; then
    echo "Error: git commit failed."
    exit 1
fi

# Push changes to the remote repository
if ! git push -u origin main; then
    echo "Error: git push failed."
    exit 1
fi

echo "Changes pushed to main branch successfully."
