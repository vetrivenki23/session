# Install AWS Tools for PowerShell if not already installed
# Install-Module -Name AWSPowerShell

# Set the date for 7 days ago
$sevenDaysAgo = (Get-Date).AddDays(-7).ToString("yyyy-MM-ddTHH:mm:ssZ")

# Get the list of instances
$instances = Get-EC2Instance -Filter @{Name = 'instance-state-name'; Values = 'running' } | Where-Object { $_.Instances.LaunchTime -ge $sevenDaysAgo }

# Output the instances
$instances.Instances | Select-Object InstanceId, LaunchTime
