#!/bin/bash

# Prompt for commit description
read -p "Enter commit description: " description

# Git commands
git add .
git commit -m "$description"
git branch -M main
git push -u origin main

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
