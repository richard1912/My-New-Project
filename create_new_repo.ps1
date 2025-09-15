# GitHub Repository Creation and Setup Automation Script
# This script creates a new GitHub repository, installs spec-kit, and sets up push_updates.bat
# Run this script from within your project directory

param(
    [Parameter(Mandatory=$false)]
    [string]$Description = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$Private = $false,
    
    [Parameter(Mandatory=$false)]
    [string]$GitHubUsername = "richard1912"
)

# Set error action preference
$ErrorActionPreference = "Stop"

# Function to check if a command exists
function Test-Command {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

# Function to install GitHub CLI using winget
function Install-GitHubCLI {
    Write-Host "📦 Installing GitHub CLI using winget..." -ForegroundColor Yellow
    try {
        winget install --id GitHub.cli --accept-package-agreements --accept-source-agreements
        Write-Host "✅ GitHub CLI installed successfully" -ForegroundColor Green
        return $true
    } catch {
        Write-Warning "⚠️ Failed to install GitHub CLI using winget. Please install manually from https://cli.github.com/"
        return $false
    }
}

# Function to install Node.js using winget
function Install-NodeJS {
    Write-Host "📦 Installing Node.js using winget..." -ForegroundColor Yellow
    try {
        winget install --id OpenJS.NodeJS --accept-package-agreements --accept-source-agreements
        Write-Host "✅ Node.js installed successfully" -ForegroundColor Green
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        return $true
    } catch {
        Write-Warning "⚠️ Failed to install Node.js using winget. Please install manually from https://nodejs.org/"
        return $false
    }
}

# Function to install Python using winget
function Install-Python {
    Write-Host "📦 Installing Python using winget..." -ForegroundColor Yellow
    try {
        winget install --id Python.Python.3 --accept-package-agreements --accept-source-agreements
        Write-Host "✅ Python installed successfully" -ForegroundColor Green
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        return $true
    } catch {
        Write-Warning "⚠️ Failed to install Python using winget. Please install manually from https://python.org/"
        return $false
    }
}

# Function to install uv using pip
function Install-UV {
    Write-Host "📦 Installing uv (Python package manager)..." -ForegroundColor Yellow
    try {
        pip install uv
        Write-Host "✅ uv installed successfully" -ForegroundColor Green
        return $true
    } catch {
        Write-Warning "⚠️ Failed to install uv. You may need to run 'pip install uv' manually"
        return $false
    }
}

# Function to install Git using winget
function Install-Git {
    Write-Host "📦 Installing Git using winget..." -ForegroundColor Yellow
    try {
        winget install --id Git.Git --accept-package-agreements --accept-source-agreements
        Write-Host "✅ Git installed successfully" -ForegroundColor Green
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        return $true
    } catch {
        Write-Warning "⚠️ Failed to install Git using winget. Please install manually from https://git-scm.com/"
        return $false
    }
}

# Function to check and install prerequisites
function Install-Prerequisites {
    Write-Host "🔍 Checking and installing prerequisites..." -ForegroundColor Yellow
    Write-Host ""
    
    $allInstalled = $true
    
    # Check and install winget first
    if (-not (Test-Command "winget")) {
        Write-Host "❌ winget not found. Please install Windows Package Manager first." -ForegroundColor Red
        Write-Host "   You can install it from the Microsoft Store or visit: https://github.com/microsoft/winget-cli" -ForegroundColor Yellow
        $allInstalled = $false
    } else {
        Write-Host "✅ winget found" -ForegroundColor Green
    }
    
    # Check and install GitHub CLI
    if (-not (Test-Command "gh")) {
        Write-Host "🔍 GitHub CLI not found. Attempting to install..." -ForegroundColor Yellow
        if (Test-Command "winget") {
            if (-not (Install-GitHubCLI)) {
                $allInstalled = $false
            }
        } else {
            Write-Host "❌ Cannot install GitHub CLI without winget" -ForegroundColor Red
            $allInstalled = $false
        }
    } else {
        Write-Host "✅ GitHub CLI found" -ForegroundColor Green
    }
    
    # Check and install Node.js
    if (-not (Test-Command "node")) {
        Write-Host "🔍 Node.js not found. Attempting to install..." -ForegroundColor Yellow
        if (Test-Command "winget") {
            if (-not (Install-NodeJS)) {
                $allInstalled = $false
            }
        } else {
            Write-Host "❌ Cannot install Node.js without winget" -ForegroundColor Red
            $allInstalled = $false
        }
    } else {
        Write-Host "✅ Node.js found" -ForegroundColor Green
    }
    
    # Check and install Python
    if (-not (Test-Command "python")) {
        Write-Host "🔍 Python not found. Attempting to install..." -ForegroundColor Yellow
        if (Test-Command "winget") {
            if (-not (Install-Python)) {
                $allInstalled = $false
            }
        } else {
            Write-Host "❌ Cannot install Python without winget" -ForegroundColor Red
            $allInstalled = $false
        }
    } else {
        Write-Host "✅ Python found" -ForegroundColor Green
    }
    
    # Check and install uv
    if (-not (Test-Command "uv")) {
        Write-Host "🔍 uv not found. Attempting to install..." -ForegroundColor Yellow
        if (Test-Command "python") {
            if (-not (Install-UV)) {
                $allInstalled = $false
            }
        } else {
            Write-Host "❌ Cannot install uv without Python" -ForegroundColor Red
            $allInstalled = $false
        }
    } else {
        Write-Host "✅ uv found" -ForegroundColor Green
    }
    
    # Check and install Git
    if (-not (Test-Command "git")) {
        Write-Host "🔍 Git not found. Attempting to install..." -ForegroundColor Yellow
        if (Test-Command "winget") {
            if (-not (Install-Git)) {
                $allInstalled = $false
            }
        } else {
            Write-Host "❌ Cannot install Git without winget" -ForegroundColor Red
            $allInstalled = $false
        }
    } else {
        Write-Host "✅ Git found" -ForegroundColor Green
    }
    
    Write-Host ""
    if (-not $allInstalled) {
        Write-Host "❌ Some prerequisites could not be installed automatically." -ForegroundColor Red
        Write-Host "   Please install them manually and run the script again." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Required software:" -ForegroundColor Yellow
        Write-Host "1. GitHub CLI: https://cli.github.com/" -ForegroundColor White
        Write-Host "2. Node.js: https://nodejs.org/" -ForegroundColor White
        Write-Host "3. Python: https://python.org/" -ForegroundColor White
        Write-Host "4. uv: pip install uv" -ForegroundColor White
        Write-Host "5. Git: https://git-scm.com/" -ForegroundColor White
        exit 1
    } else {
        Write-Host "✅ All prerequisites are installed and ready!" -ForegroundColor Green
        Write-Host ""
    }
}

# Get project name from current directory
$ProjectName = Split-Path -Leaf (Get-Location)
Write-Host "🚀 Starting GitHub Repository Creation and Setup Process..." -ForegroundColor Green
Write-Host "📁 Project Directory: $(Get-Location)" -ForegroundColor Cyan
Write-Host "📝 Project Name: $ProjectName" -ForegroundColor Cyan
Write-Host ""

# Validate inputs
if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    Write-Error "Could not determine project name from current directory"
    exit 1
}

# Install prerequisites
Install-Prerequisites

# Check if user is authenticated with GitHub
Write-Host "🔐 Checking GitHub authentication..." -ForegroundColor Yellow
try {
    gh auth status | Out-Null
    Write-Host "✅ GitHub authentication verified" -ForegroundColor Green
} catch {
    Write-Error "❌ Not authenticated with GitHub. Please run 'gh auth login' first"
    exit 1
}

# Display versions of installed tools
Write-Host "📋 Installed tool versions:" -ForegroundColor Yellow
try {
    $ghVersion = gh --version
    Write-Host "   GitHub CLI: $($ghVersion[0])" -ForegroundColor Green
} catch {
    Write-Host "   GitHub CLI: Not available" -ForegroundColor Red
}

try {
    $nodeVersion = node --version
    $npmVersion = npm --version
    Write-Host "   Node.js: $nodeVersion" -ForegroundColor Green
    Write-Host "   npm: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "   Node.js/npm: Not available" -ForegroundColor Red
}

try {
    $pythonVersion = python --version
    Write-Host "   Python: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "   Python: Not available" -ForegroundColor Red
}

try {
    $uvVersion = uv --version
    Write-Host "   uv: $uvVersion" -ForegroundColor Green
} catch {
    Write-Host "   uv: Not available" -ForegroundColor Red
}

try {
    $gitVersion = git --version
    Write-Host "   Git: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "   Git: Not available" -ForegroundColor Red
}
Write-Host ""

# Check if we're in a valid project directory
Write-Host "📁 Working in current directory: $(Get-Location)" -ForegroundColor Yellow

# Check if directory is empty or has minimal content
$items = Get-ChildItem -Force
$scriptFiles = @("create_new_repo.ps1", "REPO_AUTOMATION_GUIDE.md", "README.md", ".git")
$nonScriptItems = $items | Where-Object { $_.Name -notin $scriptFiles }

if ($nonScriptItems.Count -gt 0) {
    Write-Host "⚠️ Directory contains project files. Contents:" -ForegroundColor Yellow
    $items | ForEach-Object { 
        if ($_.Name -in $scriptFiles) {
            Write-Host "   - $($_.Name) (script/documentation)" -ForegroundColor Gray
        } else {
            Write-Host "   - $($_.Name)" -ForegroundColor Yellow
        }
    }
    Write-Host ""
    $continue = Read-Host "Continue with repository setup? (y/N)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        Write-Host "Operation cancelled." -ForegroundColor Yellow
        exit 0
    }
} else {
    Write-Host "✅ Directory contains only script files - proceeding with setup" -ForegroundColor Green
}

# Initialize git repository
Write-Host "🔧 Initializing git repository..." -ForegroundColor Yellow
git init | Out-Null

# Create GitHub repository
Write-Host "🌐 Creating GitHub repository..." -ForegroundColor Yellow
$repoArgs = @("repo", "create", $ProjectName, "--public")
if ($Private) {
    $repoArgs = @("repo", "create", $ProjectName, "--private")
}
if ($Description) {
    $repoArgs += "--description", $Description
}

try {
    gh @repoArgs | Out-Null
    Write-Host "✅ GitHub repository created successfully" -ForegroundColor Green
} catch {
    Write-Error "❌ Failed to create GitHub repository"
    exit 1
}

# Add remote origin
Write-Host "🔗 Setting up remote origin..." -ForegroundColor Yellow
$repoUrl = "https://github.com/$GitHubUsername/$ProjectName.git"
git remote add origin $repoUrl

# Install spec-kit globally (persistent installation)
Write-Host "📦 Installing spec-kit globally..." -ForegroundColor Yellow
try {
    # Install spec-kit using uvx (it's installed from GitHub repository)
    uvx --from git+https://github.com/github/spec-kit.git specify --help | Out-Null
    Write-Host "✅ spec-kit installed and available via uvx" -ForegroundColor Green
} catch {
    Write-Warning "⚠️ Failed to install spec-kit. You may need to install uv first:"
    Write-Warning "   pip install uv"
    Write-Warning "   Then run: uvx --from git+https://github.com/github/spec-kit.git specify init <PROJECT_NAME>"
}

# Create customized push_updates.bat file
Write-Host "📝 Creating customized push_updates.bat..." -ForegroundColor Yellow

$pushUpdatesContent = @"
@echo off
setlocal enabledelayedexpansion

:: $ProjectName Update Pusher Script (Windows Version)
:: This script helps push updates to the develop branch of the $ProjectName repository

:: Main script starts here
echo Starting $ProjectName Update Process...
echo.

:: Check if we're in a git repository
if not exist ".git" (
    echo [ERROR] Not in a git repository. Please run this script from the $ProjectName project directory.
    pause
    exit /b 1
)

:: Set remote origin to development repository
echo [INFO] Setting remote origin to development repository...
git remote set-url origin $repoUrl
if errorlevel 1 (
    echo [ERROR] Failed to set remote origin.
    pause
    exit /b 1
) else (
    echo [SUCCESS] Remote origin set to development repository.
)

:: Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git is not installed. Please install git first.
    pause
    exit /b 1
)

:: Get current branch
for /f "tokens=*" %%i in ('git branch --show-current') do set current_branch=%%i
echo [INFO] Current branch: !current_branch!

:: Check if there are any changes to commit
git status --porcelain >nul 2>&1
if errorlevel 1 (
    echo [WARNING] No changes detected. Nothing to commit.
    pause
    exit /b 0
)

:: Check if there are actually changes
for /f %%i in ('git status --porcelain ^| find /c /v ""') do set change_count=%%i
if !change_count! equ 0 (
    echo [WARNING] No changes detected. Nothing to commit.
    pause
    exit /b 0
)

:: Show current status
echo [INFO] Current git status:
git status --short

:: Prompt for commit message
echo.
echo Please provide a description of your changes:
echo This will be used as the commit message.
echo.
set /p commit_message="Description: "

:: Check if commit message is empty
if "!commit_message!"=="" (
    echo [ERROR] Commit message cannot be empty. Exiting.
    pause
    exit /b 1
)

:: Confirm the action
echo.
echo About to commit and push with message:
echo   '!commit_message!'
echo.
set /p confirm="Proceed? (y/N): "

if /i not "!confirm!"=="y" (
    echo [INFO] Operation cancelled.
    pause
    exit /b 0
)

:: Add all changes
echo [INFO] Adding all changes...
git add .
if errorlevel 1 (
    echo [ERROR] Failed to add changes.
    pause
    exit /b 1
)

:: Commit changes
echo [INFO] Committing changes...
git commit -m "!commit_message!"
if errorlevel 1 (
    echo [ERROR] Failed to commit changes.
    pause
    exit /b 1
) else (
    echo [SUCCESS] Changes committed successfully!
)

:: Check if we need to switch to develop branch
if not "!current_branch!"=="develop" (
    echo [WARNING] You're not on the develop branch. Switching to develop...
    git checkout develop
    if errorlevel 1 (
        echo [ERROR] Failed to switch to develop branch.
        pause
        exit /b 1
    ) else (
        echo [SUCCESS] Switched to develop branch.
    )
    
    :: Merge the changes from the previous branch
    echo [INFO] Merging changes from !current_branch!...
    git merge "!current_branch!"
    if errorlevel 1 (
        echo [ERROR] Failed to merge changes. You may need to resolve conflicts manually.
        pause
        exit /b 1
    ) else (
        echo [SUCCESS] Merged changes successfully!
    )
)

:: Pull latest changes from remote
echo [INFO] Pulling latest changes from remote...
git pull origin develop
if errorlevel 1 (
    echo [WARNING] Failed to pull latest changes. This might cause conflicts.
    set /p continue_anyway="Continue anyway? (y/N): "
    if /i not "!continue_anyway!"=="y" (
        echo [INFO] Operation cancelled. Please resolve conflicts manually.
        pause
        exit /b 1
    )
) else (
    echo [SUCCESS] Pulled latest changes successfully!
)

:: Push to remote
echo [INFO] Pushing changes to remote develop branch...
git push origin develop
if errorlevel 1 (
    echo [ERROR] Failed to push changes. Please check your remote configuration and try again.
    pause
    exit /b 1
) else (
    echo [SUCCESS] Changes pushed successfully to develop branch!
    echo [SUCCESS] Your updates are now live on GitHub!
)

:: Clean up (optional)
if not "!current_branch!"=="develop" (
    echo.
    set /p delete_branch="Delete the feature branch '!current_branch!'? (y/N): "
    if /i "!delete_branch!"=="y" (
        echo [INFO] Deleting feature branch...
        git branch -d "!current_branch!"
        if errorlevel 1 (
            echo [WARNING] Failed to delete feature branch. It may have unmerged changes.
        ) else (
            echo [SUCCESS] Feature branch deleted locally.
            echo Note: If you pushed this branch to remote, you may want to delete it there too.
        )
    )
)

echo.
echo [SUCCESS] Update process completed successfully!
echo [INFO] Repository: $repoUrl
echo [INFO] Branch: develop
echo.
pause
"@

$pushUpdatesContent | Out-File -FilePath "push_updates.bat" -Encoding ASCII

# Create initial README.md
Write-Host "📄 Creating initial README.md..." -ForegroundColor Yellow
$readmeContent = @"
# $ProjectName

$Description

## Getting Started

This project was created using the automated repository setup script.

## Development

Use the included `push_updates.bat` script to easily push changes to the develop branch.

## Repository Information

- **Repository URL**: $repoUrl
- **Default Branch**: develop
- **Setup Date**: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
"@

$readmeContent | Out-File -FilePath "README.md" -Encoding UTF8

# Initialize spec-kit project
Write-Host "🔧 Initializing spec-kit project..." -ForegroundColor Yellow
try {
    # Initialize spec-kit project in the current directory
    uvx --from git+https://github.com/github/spec-kit.git specify init $ProjectName --yes
    Write-Host "✅ spec-kit project initialized successfully" -ForegroundColor Green
    
    # Create .spec-kit directory structure
    New-Item -ItemType Directory -Path ".spec-kit" -Force | Out-Null
    New-Item -ItemType Directory -Path "specs" -Force | Out-Null
    New-Item -ItemType Directory -Path "plans" -Force | Out-Null
    New-Item -ItemType Directory -Path "tasks" -Force | Out-Null
    
    # Create a basic .spec-kit configuration file
    $specKitConfig = @"
{
  "project_name": "$ProjectName",
  "version": "1.0.0",
  "description": "A new project created with spec-kit",
  "language": "typescript",
  "framework": "react",
  "ai_agent": "claude",
  "specs_directory": "specs",
  "plans_directory": "plans",
  "tasks_directory": "tasks"
}
"@
    $specKitConfig | Out-File -FilePath ".spec-kit.json" -Encoding UTF8
    
    # Create a basic spec template
    $specTemplate = @"
# Project Specification: $ProjectName

## Overview
This is a new project created with spec-kit. Use the /specify command in your AI coding environment to define the project requirements.

## Example Usage
In your AI coding environment, you can now use:
- `/specify "Your detailed project specification here"`
- `/plan "Your technical implementation plan here"`
- `/tasks` to break down the work
- `/implement specs/001-feature-name/plan.md` to implement features

## Project Structure
- `specs/` - Project specifications
- `plans/` - Technical implementation plans  
- `tasks/` - Task breakdowns
- `.spec-kit/` - spec-kit configuration and metadata
"@
    $specTemplate | Out-File -FilePath "specs/README.md" -Encoding UTF8
    
    Write-Host "✅ spec-kit project structure created" -ForegroundColor Green
    Write-Host "✅ spec-kit configuration created" -ForegroundColor Green
    
} catch {
    Write-Warning "⚠️ Failed to initialize spec-kit project. You can initialize it manually later:"
    Write-Warning "   uvx --from git+https://github.com/github/spec-kit.git specify init $ProjectName"
}

# Create initial commit
Write-Host "💾 Creating initial commit..." -ForegroundColor Yellow
git add .
git commit -m "Initial commit: Project setup with spec-kit and push automation"

# Create and switch to develop branch
Write-Host "🌿 Creating develop branch..." -ForegroundColor Yellow
git checkout -b develop
git push -u origin develop

# Switch back to master (GitHub's default branch)
Write-Host "🔄 Switching back to master branch..." -ForegroundColor Yellow
git checkout master
git push -u origin master

Write-Host ""
Write-Host "🎉 Repository setup completed successfully!" -ForegroundColor Green
Write-Host "📁 Project directory: $(Get-Location)" -ForegroundColor Cyan
Write-Host "🌐 Repository URL: $repoUrl" -ForegroundColor Cyan
Write-Host "📦 spec-kit: Project initialized and ready for /specify commands!" -ForegroundColor Cyan
Write-Host "📝 push_updates.bat: Created and customized for this repository" -ForegroundColor Cyan
Write-Host ""
Write-Host "🚀 Ready to use spec-kit commands in your AI chat!" -ForegroundColor Green
Write-Host "You can now use these commands in your AI coding environment:" -ForegroundColor Yellow
Write-Host "  /specify 'Your project specification here'" -ForegroundColor White
Write-Host "  /plan 'Your technical plan here'" -ForegroundColor White
Write-Host "  /tasks" -ForegroundColor White
Write-Host "  /implement specs/001-feature-name/plan.md" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Open this project in your AI coding environment (Claude Code, GitHub Copilot, etc.)" -ForegroundColor White
Write-Host "2. Start using /specify commands to define your project" -ForegroundColor White
Write-Host "3. Use push_updates.bat to push changes to the develop branch" -ForegroundColor White
Write-Host ""

# Open the current directory in explorer
Write-Host "🔍 Opening project directory..." -ForegroundColor Yellow
Start-Process explorer.exe -ArgumentList (Get-Location)
