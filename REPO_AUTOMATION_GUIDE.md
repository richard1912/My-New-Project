# GitHub Repository Automation Guide

This guide explains how to use the automated repository creation script that sets up new GitHub repositories with spec-kit and customized push automation. The script works from within your project directory and automatically detects the project name from the current directory name.

## 🚀 Ready to Use spec-kit Commands!

After running the script, you can immediately start using spec-kit commands in your AI coding environment:

- **`/specify "Your project specification here"`** - Define your project requirements
- **`/plan "Your technical plan here"`** - Create implementation plans  
- **`/tasks`** - Break down work into actionable items
- **`/implement specs/001-feature-name/plan.md`** - Implement features

The script automatically initializes a complete spec-kit project structure, so you can start using these commands right away in Claude Code, GitHub Copilot, or similar AI coding environments!

## Prerequisites

The automation script will automatically install the required software for you using Windows Package Manager (winget). However, you need:

1. **Windows Package Manager (winget)** - Usually pre-installed on Windows 10/11
   - If not available, install from Microsoft Store or [https://github.com/microsoft/winget-cli](https://github.com/microsoft/winget-cli)

The script will automatically install:
- **GitHub CLI** - For GitHub repository management
- **Node.js and npm** - For JavaScript tools and development
- **Python** - For Python development
- **uv** - Modern Python package manager (required for spec-kit)
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

1. **Installs Prerequisites**: Automatically installs GitHub CLI, Node.js, Python, uv, and Git using winget
2. **Detects Project Name**: Automatically determines project name from the current directory name
3. **Checks Directory**: Warns if directory is not empty and asks for confirmation
4. **Initializes Git Repository**: Sets up git in the current directory
5. **Creates GitHub Repository**: Creates the repository on GitHub
6. **Installs spec-kit Dependencies**: Installs uv (Python package manager) required for [spec-kit](https://github.com/github/spec-kit)
7. **Initializes spec-kit Project**: Sets up spec-kit project structure and configuration for immediate use
8. **Customizes push_updates.bat**: Creates a customized batch file for easy pushing to develop branch
9. **Sets Up Branches**: Creates both `master` and `develop` branches
10. **Creates Initial Files**: Adds README.md, spec-kit configuration, and initial commit

## Generated Files

### push_updates.bat
A customized batch file that:
- Automatically sets the correct remote URL for your repository
- Handles git operations (add, commit, push)
- Manages branch switching and merging
- Provides interactive prompts for commit messages
- Includes error handling and confirmation steps

### spec-kit Project Structure
The script automatically creates a complete spec-kit project structure:
- `.spec-kit/` - spec-kit configuration and metadata
- `specs/` - Project specifications directory
- `plans/` - Technical implementation plans directory
- `tasks/` - Task breakdowns directory
- `.spec-kit.json` - spec-kit configuration file
- `specs/README.md` - Basic spec template and usage instructions

### README.md
A basic README file with:
- Project name and description
- Repository URL
- Setup date
- Basic usage instructions

## Workflow After Creation

1. **You're already in your project directory** - no need to navigate anywhere!

2. **Open in AI coding environment:**
   - Open this project in Claude Code, GitHub Copilot, or similar AI coding environment
   - The spec-kit project is already initialized and ready to use

3. **Start using spec-kit commands immediately:**
   - Use `/specify "Your project specification here"` in your AI chat
   - Use `/plan "Your technical plan here"` to create implementation plans
   - Use `/tasks` to break down work into actionable items
   - Use `/implement specs/001-feature-name/plan.md` to implement features

4. **Develop your project:**
   - Add your code files
   - Use `push_updates.bat` to push changes

5. **Using push_updates.bat:**
   - Double-click the file or run it from command line
   - Follow the prompts to commit and push changes
   - The script handles all git operations automatically

## spec-kit Commands

[Spec-kit](https://github.com/github/spec-kit) is a toolkit for Spec-Driven Development that uses `uvx` for installation. Here are the essential commands:

### Basic Commands

```powershell
# Initialize a new spec-driven project
uvx --from git+https://github.com/github/spec-kit.git specify init <PROJECT_NAME>

# Get help and see all available commands
uvx --from git+https://github.com/github/spec-kit.git specify --help

# Check version
uvx --from git+https://github.com/github/spec-kit.git specify --version
```

### Spec-Driven Development Workflow

The spec-kit workflow involves initializing a project and then using interactive commands within your development environment:

```powershell
# Step 1: Initialize a new spec-driven project
uvx --from git+https://github.com/github/spec-kit.git specify init photo-organizer

# Step 2: Navigate to the project directory
cd photo-organizer

# Step 3: Use interactive commands in your development environment
# These commands are used within Claude Code, GitHub Copilot, or similar AI coding environments:

# In your AI coding environment, use these commands:
# /specify "Build an application that helps organize photos in separate photo albums. Albums are grouped by date and can be re-organized by dragging and dropping on the main page."

# /plan "The application uses Vite with a minimal number of libraries. Use vanilla HTML, CSS, and JavaScript as much as possible. Images are not uploaded anywhere, and metadata is stored in a local SQLite database."

# /tasks

# Step 4: Implement the solution
uvx --from git+https://github.com/github/spec-kit.git specify implement specs/001-create-photo-organizer/plan.md
```

### Available Commands

```powershell
# List all available specifications
uvx --from git+https://github.com/github/spec-kit.git specify list

# Show help for all available commands
uvx --from git+https://github.com/github/spec-kit.git specify --help

# Check version information
uvx --from git+https://github.com/github/spec-kit.git specify --version

# Initialize a new project with specific template
uvx --from git+https://github.com/github/spec-kit.git specify init my-project --template web-app

# Generate project structure
uvx --from git+https://github.com/github/spec-kit.git specify generate structure

# Create API documentation
uvx --from git+https://github.com/github/spec-kit.git specify api docs

# Generate test specifications
uvx --from git+https://github.com/github/spec-kit.git specify tests generate
```

### Interactive Commands (Used in AI Coding Environments)

The `/specify`, `/plan`, and `/tasks` commands are used within AI coding environments like Claude Code, GitHub Copilot, or similar tools:

```powershell
# These commands are used within your AI coding environment, not in the terminal:

# /specify "Your detailed specification here"
# /plan "Your technical plan here" 
# /tasks
# /implement specs/001-feature-name/plan.md
```

### How to Use spec-kit Properly

1. **Initialize a project:**
   ```powershell
   uvx --from git+https://github.com/github/spec-kit.git specify init my-project
   cd my-project
   ```

2. **Open in your AI coding environment** (Claude Code, GitHub Copilot, etc.)

3. **Use the interactive commands** within the AI environment:
   - `/specify` - Create detailed specifications
   - `/plan` - Develop technical plans
   - `/tasks` - Break down into actionable tasks
   - `/implement` - Implement the solution

4. **Use command-line tools** for project management:
   ```powershell
   # List specifications
   uvx --from git+https://github.com/github/spec-kit.git specify list
   
   # Generate documentation
   uvx --from git+https://github.com/github/spec-kit.git specify docs generate
   
   # Get help
   uvx --from git+https://github.com/github/spec-kit.git specify --help
   ```

### Example Workflow

Here's a complete example of using spec-kit for a web application:

```powershell
# 1. Initialize project
uvx --from git+https://github.com/github/spec-kit.git specify init task-manager
cd task-manager

# 2. Open in your AI coding environment (Claude Code, GitHub Copilot, etc.)

# 3. Use interactive commands within the AI environment:
# /specify "Build a task management application with user authentication, project organization, and real-time collaboration features."

# /plan "Use React with TypeScript, Node.js with Express, PostgreSQL database, and Socket.io for real-time features."

# /tasks

# /implement specs/001-create-task-manager/plan.md

# 4. Use command-line tools for project management:
uvx --from git+https://github.com/github/spec-kit.git specify list
uvx --from git+https://github.com/github/spec-kit.git specify docs generate
```

> **Note**: spec-kit is installed via `uvx` from the GitHub repository. It helps with Spec-Driven Development, allowing you to build high-quality software faster by focusing on product scenarios rather than writing undifferentiated code. The toolkit integrates with AI coding agents like GitHub Copilot to streamline the development process.

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
- **Global tools**: uv (Python package manager) is installed globally, enabling spec-kit usage via uvx
- **Customized automation**: The push_updates.bat file is customized for your specific repository
- **Extensive logging**: Detailed logging is provided throughout the process for troubleshooting
- **Fallback support**: If automatic installation fails, manual installation links are provided
