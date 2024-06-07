# Prompt for confirmation before deleting .terraform* files and directories
$response = Read-Host -Prompt "Do you want to delete .terraform* files and directories? (y/n)"

if ($response -eq 'y' -or $response -eq 'Y') {
    # Delete .terraform* directories
    Get-ChildItem -Path . -Recurse -Directory -Filter '.terraform*' | ForEach-Object {
        Remove-Item -Path $_.FullName -Recurse -Force
    }
    # Delete .terraform* files
    Get-ChildItem -Path . -Recurse -File -Filter '.terraform*' | ForEach-Object {
        Remove-Item -Path $_.FullName -Force
    }
    # Delete terraform.tfstate* files
    Get-ChildItem -Path . -Recurse -File -Filter 'terraform.tfstate*' | ForEach-Object {
        Remove-Item -Path $_.FullName -Force
    }
    Write-Host ".terraform* files and directories deleted."
} else {
    Write-Host "Deletion of .terraform* files and directories skipped."
}

# Prompt for commit description
$description = Read-Host -Prompt "Enter commit description"

# Git commands
git add .
git commit -m "$description"
git branch -M main
git push -u origin main
