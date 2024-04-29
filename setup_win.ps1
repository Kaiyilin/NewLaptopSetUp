# Define applications to install
$installApplications = @(
    "Visual Studio Code"
    # "Speccy"    # Alternative to Stats for monitoring system stats
    # "HiddenBar"  # Assuming a Windows version exists
    "Postman"
    "7z.install"
    # "Chrome"  # Alternative to Arc browser
)

# Check for Windows and use Chocolatey package manager (optional)
if ($($env:OS -match "Windows") -eq $true) {
  # Check if Chocolatey is installed
  if (!(Test-Path -Path "C:\ProgramData\chocolatey\choco.exe")) {
    Write-Host "Installing Chocolatey..."
    # Download and run Chocolatey installer
    iex ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"))
  }

  # Install applications using Chocolatey
  foreach ($app in $installApplications) {
    Write-Host "Installing $app..."
    choco install -y $app
  }
} else {
  # Not Windows, cannot proceed further
  Write-Host "This script is designed for Windows systems."
}

