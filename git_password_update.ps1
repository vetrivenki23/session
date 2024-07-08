# Function to clear old Git credentials
function Clear-GitCredentials {
    Write-Host "Clearing old Git credentials..."
    git credential-manager erase
    Write-Host "Old Git credentials cleared."
}

# Function to prompt for new credentials
function Prompt-NewCredentials {
    Write-Host "You will be prompted to enter your new credentials when you perform a Git operation."
}

# Function to update Windows Credential Manager
function Update-WindowsCredentials {
    Write-Host "Updating Windows Credential Manager..."

    # Open Credential Manager UI for the user to update GitHub credentials
    Start-Process "control.exe" "keymgr.dll"
    Write-Host "Please find and update your GitHub credentials (look for entries related to 'git:https://github.com')."

    Read-Host -Prompt "Press Enter after updating the credentials"
}

# Function to reconfigure Git Credential Manager
function Reconfigure-GitCredentialManager {
    Write-Host "Reconfiguring Git Credential Manager..."
    git config --global credential.helper manager-core
    Write-Host "Git Credential Manager reconfigured."
}

# Function to guide SSH key update
function Update-SSHKey {
    Write-Host "Updating SSH key..."
    Write-Host "Ensure your SSH key is correctly updated and added to your SSH agent."
    ssh-add ~/.ssh/id_rsa

    Write-Host "Log into GitHub and go to Settings > SSH and GPG keys."
    Write-Host "Add your new SSH key or update the existing one."
}

# Clear old credentials
Clear-GitCredentials

# Prompt user to update credentials on next Git operation
Prompt-NewCredentials

# Update Windows Credential Manager if on Windows
if ($IsWindows) {
    Update-WindowsCredentials
}

# Reconfigure Git Credential Manager
Reconfigure-GitCredentialManager

# Provide instructions for SSH key update
Update-SSHKey

Write-Host "Script execution complete. Please perform a Git operation to enter your new credentials."
