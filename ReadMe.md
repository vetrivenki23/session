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

# Terraform Cleanup Script

To clean up Terraform-related files and directories, you can use the following script:

```bash
# Delete .terraform* files and directories
find . -type d -name '.terraform*' -exec rm -rf {} +
find . -type f -name '.terraform*' -exec rm -f {} +

# Delete terraform.tfstate* files
find . -type f -name 'terraform.tfstate*' -exec rm -f {} +
```

# gitignore

add the following lines to your .gitignore file:

```bash
# Ignore Terraform folder

.terraform/

# Ignore Terraform state file

terraform.tfstate
```

# Commit and Push Script

```bash
@echo off
set /p description="Enter commit description: "
git add .
git commit -m "%description%"
git branch -M main
git push -u origin main
```

# Clone Repo

```bash
git clone https://github.com/vetrivenki23/session.git
```

# Update 400 permission in Windows

```bash
icacls.exe your_key_name.pem /reset
icacls.exe your_key_name.pem /grant:r "$($env:username):(r)"
icacls.exe your_key_name.pem /inheritance:r
```
