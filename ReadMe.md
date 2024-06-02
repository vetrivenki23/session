# GitHub

## Create a New Repository on GitHub from the Command Line

```bash
# Create a README.md file with the title "AWS"
echo "# AWS" >> README.md

# Initialize a new git repository
git init

# Add README.md to the staging area
git add README.md

# Commit the file with a message
git commit -m "first commit"

# Rename the default branch to main
git branch -M main

# Add the remote repository URL
git remote add origin https://github.com/vetrivenki23/session.git

# Push the changes to the remote repository on the main branch
git push -u origin main
```

## Push an Existing Repository to GitHub from the Command Line

```bash
# Add the remote repository URL
git remote add origin https://github.com/vetrivenki23/session.git

# Rename the default branch to main
git branch -M main

# Push the changes to the remote repository on the main branch
git push -u origin main
```
