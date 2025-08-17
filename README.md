# boilerplate-base

A base boilerplate template for projects with pre-configured development tools and workflows.

## Quick Start

### Prerequisites

This project uses different tools for different purposes:

- **Homebrew**: System-level development tools
- **mise**: Programming language version management
- **just**: Task automation and command runner

### Setup

```bash
# 1. Install Homebrew (if not already installed)
make bootstrap

# 2. Install all development tools
brew bundle install

# 3. Setup development environment
just setup
```

**Alternative one-command setup** (if Homebrew is already installed):

```bash
just setup
```

### Available Commands

```bash
# Show all available tasks
just help

# Run code quality checks
just lint

# Update development tools
just update-brew  # Update Homebrew packages
just update       # Update mise-managed tools
```

## Tool Responsibilities

This setup clearly separates tool responsibilities:

- **brew**: System-level development tools (git, pre-commit, linters, etc.)
- **mise**: Programming language version management (Node.js, Python, etc.)

This approach ensures clean separation of concerns and avoids conflicts between system tools and language-specific versions.
