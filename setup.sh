#!/bin/bash

deviceType="$1"
deviceType=$( echo "$deviceType" | tr -s  '[:upper:]'  '[:lower:]' ) # convert deviceType to lowercase

# needed app
installApplicationForMacWithCask=(
    "raycast" # better spotlight in mac
    "visual-studio-code" # text-editor
    "Stats" # monitor mac stats
    "MonitorControl" # control external monitor
    "hiddenbar" # for tracking function
    "wireshark" # packet sniffing
    "postman" # api test
    "arc" # browser
)


installApplicationForMacWithoutCask=(
    "nmap"
)


installApplicationForLinux=(
    "wireshark"
)

# Check for macOS and handle Homebrew
if [[ "$(uname -s)" == "Darwin" && $deviceType == "mac" ]]; then
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install applications using Homebrew
    for app in "${installApplicationForMacWithCask[@]}"; do
        echo "Installing $app..."
        brew install --cask "$app"
    done

    for app in "${installApplicationForMacWithoutCask[@]}"; do
        echo "Installing $app..."
        brew install "$app"
    done
fi


# Check for Ubuntu and package manager (assuming script is intended for Ubuntu)
if [[ "$(uname -s)" == "Linux" && "${deviceType_lower}" == "ubuntu" ]]; then
    # Update package lists
    sudo apt update

    # Install applications using package manager
    for app in "${installApplication[@]}"; do
        echo "Installing $app..."
        # sudo apt install -y "$app"
    done
fi

# Add similar logic for other systems if needed (e.g., Fedora, CentOS)

echo "Script execution complete."


