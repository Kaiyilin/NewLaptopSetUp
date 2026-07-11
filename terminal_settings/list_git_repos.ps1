function Open-GitRepo {
    <#
    .SYNOPSIS
        Searches for Git repositories and opens them in VS Code using fzf.
        pre-requisites: fzf, VS Code CLI (code), and PowerShell 7+.
    #>
    param (
        [string]$SearchDir = "C:\Users\YourName\workSpace",
        [switch]$Setup
    )

    # 1. Handle Setup/Configuration
    if ($Setup) {
        Write-Host "Current search directory: $SearchDir" -ForegroundColor Cyan
        $newDir = Read-Host "Enter new search directory (or press Enter to keep current)"
        if ($newDir) {
            if (Test-Path $newDir -PathType Container) {
                Write-Host "To make this permanent, update the `$SearchDir` default value in your Profile." -ForegroundColor Yellow
                $SearchDir = $newDir
            } else {
                Write-Error "Directory '$newDir' does not exist."
                return
            }
        }
    }

    # 2. Dependency Checks
    if (!(Get-Command fzf -ErrorAction SilentlyContinue)) {
        Write-Error "fzf is not installed. (Hint: 'winget install fzf')"
        return
    }
    if (!(Get-Command code -ErrorAction SilentlyContinue)) {
        Write-Error "VSCode CLI 'code' is not installed."
        return
    }

    # 3. The Search Logic
    Write-Host "Searching for Git repositories in: $SearchDir..." -ForegroundColor Gray

    # Find directories containing .git, get their parent path, and pipe to fzf
    $selectedRepo = Get-ChildItem -Path $SearchDir -Filter ".git" -Recurse -Depth 5 -Directory -ErrorAction SilentlyContinue | 
        Select-Object -ExpandProperty Parent | 
        Select-Object -ExpandProperty FullName | 
        fzf --prompt="Search for repo: " --height=40% --border

    # 4. Open in VS Code
    if ($selectedRepo) {
        Write-Host "Opening repository: $selectedRepo" -ForegroundColor Green
        code $selectedRepo
    } else {
        Write-Host "No repository selected." -ForegroundColor Yellow
    }
}