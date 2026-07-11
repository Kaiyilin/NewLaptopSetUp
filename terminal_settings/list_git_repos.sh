#!/bin/bash
# Git Repository Finder and Opener
# This script lists all directories containing a .git folder under the SEARCH_DIR
# and allows you to select and open one in VSCode using fzf

# Configuration: Change the SEARCH_DIR variable below to set your search directory
SEARCH_DIR="/home/user/workSpace"

# Function to display help
show_help() {
    echo "Git Repository Finder - Help"
    echo "=========================="
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  -h, --help     Show this help message"
    echo "  -s, --setup    Interactive setup to change search directory"
    echo ""
    echo "CONFIGURATION:"
    echo "To change the search directory, either:"
    echo "1. Run: $0 --setup"
    echo "2. Edit this file and modify the SEARCH_DIR variable on line 6"
    echo "   Current SEARCH_DIR: $SEARCH_DIR"
    echo ""
    echo "REQUIREMENTS:"
    echo "- fzf (fuzzy finder)"
    echo "- code (VSCode command line tool)"
}

# Function to setup search directory
setup_search_dir() {
    echo "Current search directory: $SEARCH_DIR"
    echo -n "Enter new search directory (or press Enter to keep current): "
    read -r new_dir
    
    if [[ -n "$new_dir" ]]; then
        if [[ -d "$new_dir" ]]; then
            # Update the script file
            sed -i.bak "s|^SEARCH_DIR=.*|SEARCH_DIR=\"$new_dir\"|" "$0"
            echo "Search directory updated to: $new_dir"
            echo "Backup created: ${0}.bak"
        else
            echo "Error: Directory '$new_dir' does not exist."
            exit 1
        fi
    else
        echo "Keeping current search directory: $SEARCH_DIR"
    fi
}

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    -s|--setup)
        setup_search_dir
        exit 0
        ;;
    -*)
        echo "Unknown option: $1"
        echo "Use -h or --help for usage information."
        exit 1
        ;;
esac

# Check if search directory exists
if [[ ! -d "$SEARCH_DIR" ]]; then
    echo "Error: Search directory '$SEARCH_DIR' does not exist."
    echo "Run '$0 --setup' to configure a new search directory."
    exit 1
fi

# Check if required tools are available
command -v fzf >/dev/null 2>&1 || {
    echo "Error: fzf is not installed. Please install fzf first."
    exit 1
}

command -v code >/dev/null 2>&1 || {
    echo "Error: VSCode CLI tool 'code' is not available."
    exit 1
}

echo "Searching for Git repositories in: $SEARCH_DIR"

# More efficient find with optimizations
selected_repo=$(find "$SEARCH_DIR" -maxdepth 6 -type d -name ".git" -print0 | 
    xargs -0 -n1 dirname | 
    fzf --prompt="Search for repo: " --height=40% --border --exit-0)

# Check if a repo was selected
if [[ -n "$selected_repo" ]]; then
    echo "Opening repository: $selected_repo"
    code "$selected_repo"
else
    echo "No repositories found or none selected."
fi
