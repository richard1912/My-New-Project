# GitHub Repository Automation Guide

This guide explains how to use the automated repository creation script that sets up new GitHub repositories with spec-kit and customized push automation. The script works from within your project directory and automatically detects the project name from the current directory name.

## Prerequisites

The automation script will automatically install the required software for you using Windows Package Manager (winget). However, you need:

1. **Windows Package Manager (winget)** - Usually pre-installed on Windows 10/11
   - If not available, install from Microsoft Store or [https://github.com/microsoft/winget-cli](https://github.com/microsoft/winget-cli)

The script will automatically install:
- **GitHub CLI** - For GitHub repository management
- **Node.js and npm** - For JavaScript tools and development
- **Python** - For spec-kit and other Python tools
- **Git** - For version control

> **Note**: If automatic installation fails, the script will provide manual installation links for each required tool.

## Authentication Setup

1. **Authenticate with GitHub CLI:**
   ```powershell
   gh auth login
   ```
   Follow the prompts to authenticate with your GitHub account.

## Usage

### Basic Usage

1. **Navigate to your project directory:**
   ```powershell
   cd "C:\MyProject"
   ```

2. **Run the script:**
   ```powershell
   .\create_new_repo.ps1
   ```

### Advanced Usage

```powershell
# Navigate to your project directory first
cd "C:\MyProject"

# Run with additional options
.\create_new_repo.ps1 -Description "A description of my project" -Private
```

### Parameters

- **`-Description`** (Optional): A description for your repository
- **`-Private`** (Optional): Create a private repository (default is public)
- **`-GitHubUsername`** (Optional): Your GitHub username (default: "richard1912")

> **Note**: The project name is automatically detected from the current directory name.

## What the Script Does

1. **Installs Prerequisites**: Automatically installs GitHub CLI, Node.js, and Git using winget
2. **Detects Project Name**: Automatically determines project name from the current directory name
3. **Checks Directory**: Warns if directory is not empty and asks for confirmation
4. **Initializes Git Repository**: Sets up git in the current directory
5. **Creates GitHub Repository**: Creates the repository on GitHub
6. **Installs spec-kit Globally**: Installs [spec-kit](https://github.com/github/spec-kit) (Python package) globally for Spec-Driven Development
7. **Customizes push_updates.bat**: Creates a customized batch file for easy pushing to develop branch
8. **Sets Up Branches**: Creates both `master` and `develop` branches
9. **Creates Initial Files**: Adds README.md and initial commit

## Generated Files

### push_updates.bat
A customized batch file that:
- Automatically sets the correct remote URL for your repository
- Handles git operations (add, commit, push)
- Manages branch switching and merging
- Provides interactive prompts for commit messages
- Includes error handling and confirmation steps

### README.md
A basic README file with:
- Project name and description
- Repository URL
- Setup date
- Basic usage instructions

## Workflow After Creation

1. **You're already in your project directory** - no need to navigate anywhere!

2. **Start developing:**
   - Add your code files
   - Use `spec-kit` commands for Spec-Driven Development
   - Use `push_updates.bat` to push changes

3. **Using push_updates.bat:**
   - Double-click the file or run it from command line
   - Follow the prompts to commit and push changes
   - The script handles all git operations automatically

## spec-kit Commands

Since spec-kit is installed globally, you can use it from anywhere. [Spec-kit](https://github.com/github/spec-kit) is a toolkit for Spec-Driven Development:

```powershell
# Initialize a new spec-driven project
spec-kit init

# Create a new specification
spec-kit create spec "Feature Description"

# List all specs
spec-kit list

# Get help
spec-kit --help
```

> **Note**: spec-kit is a Python package that helps with Spec-Driven Development, allowing you to build high-quality software faster by focusing on product scenarios rather than writing undifferentiated code.

## Troubleshooting

### Common Issues

1. **"winget not found"**
   - Install Windows Package Manager from Microsoft Store
   - Or download from [https://github.com/microsoft/winget-cli](https://github.com/microsoft/winget-cli)
   - Restart your terminal after installation

2. **"Not authenticated with GitHub"**
   - Run `gh auth login` to authenticate
   - Follow the authentication prompts

3. **"Some prerequisites could not be installed automatically"**
   - The script will provide manual installation links
   - Install the missing tools manually and run the script again
   - Restart your terminal after manual installations

4. **"Directory is not empty"**
   - The script will show you what's in the directory
   - Choose 'y' to continue if you want to proceed
   - Or choose 'N' to cancel and clean up the directory first

5. **"Failed to install [tool] using winget"**
   - Check your internet connection
   - Ensure winget is up to date: `winget upgrade winget`
   - Try running PowerShell as Administrator
   - Install the tool manually using the provided links

### Getting Help

- Check the script output for specific error messages and installation status
- The script provides detailed logging throughout the process
- Verify your GitHub authentication status with `gh auth status`
- Check winget availability with `winget --version`
- Ensure you have administrator privileges if installations fail

## Example Session

```powershell
# 1. Create and navigate to your project directory
mkdir MyNewApp
cd MyNewApp

# 2. Run the script (it will install prerequisites automatically)
.\create_new_repo.ps1 -Description "A cool new application"

# The script will:
# 1. Install GitHub CLI, Node.js, and Git (if not already installed)
# 2. Detect project name from current directory name (MyNewApp)
# 3. Check if directory is empty and ask for confirmation
# 4. Create GitHub repository and set up git
# 5. Install spec-kit globally
# 6. Create customized push_updates.bat

# 3. Start using spec-kit (you're already in the project directory)
spec-kit init

# 4. Make some changes and push them
# (Double-click push_updates.bat or run it from command line)
```

## Notes

- **Run from project directory**: The script must be run from within your project directory
- **Automatic project detection**: Project name is automatically detected from the current directory name
- **Directory safety**: Script warns if directory is not empty and asks for confirmation
- **Prerequisites**: The script automatically installs all required prerequisites using Windows Package Manager
- **Branches**: The script creates both `master` and `develop` branches
- **Default workflow**: All changes are pushed to the `develop` branch by default
- **Global tools**: spec-kit (Python package) is installed globally, so it's available system-wide
- **Customized automation**: The push_updates.bat file is customized for your specific repository
- **Extensive logging**: Detailed logging is provided throughout the process for troubleshooting
- **Fallback support**: If automatic installation fails, manual installation links are provided
