# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a base boilerplate template repository designed to provide foundational project structure and configuration files. The repository serves as a starting point for new projects with pre-configured development tools and workflows.

## Setup and Development Environment

### Initial Setup

This repository uses Homebrew for package management, mise for tool version management, and just for task automation:

```bash
# Step 1: Install Homebrew (if not already installed)
make bootstrap

# Step 2: Install all development tools
brew bundle install

# Step 3: Setup development environment
just setup
```

**Alternative one-command setup** (if Homebrew is already installed):

```bash
just setup
```

### Tool Management with mise

```bash
# Install all tools defined in .tool-versions
mise install

# Check installed versions
mise list

# Update tools to latest versions
mise upgrade
```

### Task Management with just

```bash
# Show all available tasks
just help

# Setup development environment (brew bundle + mise install + Claude/Gemini CLI + pre-commit install)
just setup

# Run all linting checks
just lint

# Run specific pre-commit hook
just lint-hook <hook-name>

# Fix common formatting issues
just fix

# Clean pre-commit cache (with force cleanup)
just clean

# Update pre-commit hooks
just update-hooks

# Update brew packages
just update-brew

# Update mise tools
just update

# Show mise status
just status
```

## Code Quality and Linting

This repository uses pre-commit hooks for code quality enforcement. You can run them directly or use just commands:

```bash
# Using just (recommended)
just lint

# Or run pre-commit directly
pre-commit run --all-files
```

### Available pre-commit hooks

- **File validation**: check-json, check-yaml, check-added-large-files
- **Security**: detect-aws-credentials, detect-private-key
- **Formatting**: end-of-file-fixer, trailing-whitespace, mixed-line-ending
- **YAML linting**: yamllint
- **Spell checking**: cspell (uses cspell.json configuration)
- **Markdown linting**: markdownlint-cli2 with auto-fix
- **Japanese text linting**: textlint with Japanese-specific rules
- **Shell script linting**: shellcheck
- **GitHub Actions**: actionlint, prettier for workflow files
- **Terraform**: terraform_fmt
- **Renovate**: renovate-config-validator

## Spell Checking

The repository uses cspell for spell checking with a custom dictionary in `cspell.json`. The dictionary includes project-specific terms, tools, and proper nouns commonly used in development.

## Tool Architecture and Dependencies

### Tool Responsibilities

This setup separates responsibilities clearly:

- **brew**: System-level development tools (git, pre-commit, mise, just, uv)
- **mise**: Node.js version management only
- **uv**: Python package and project management
- **pre-commit**: Handles all linting tools automatically (no need to install separately)

### Automated CLI Tools Installation

The setup automatically installs AI CLI tools during `just setup`:

- **Claude Code CLI**: `@anthropic-ai/claude-code` - For AI-assisted development
- **Gemini CLI**: `@google/gemini-cli` - Alternative AI assistant

### Dependency Management

- **Renovate**: Automated dependency updates via `renovate.json5`, extending from `github>tqer39/renovate-config`

## GitHub Workflows and Automation

The repository includes several GitHub Actions workflows:

- **Pre-commit**: Runs on push to main and pull requests
- **Auto-assign**: Automatically assigns PR authors using kentaro-m/auto-assign-action
- **Labeler**: Automatically labels PRs based on file patterns (supports editorconfig, document, terraform, textlint, yamllint, markdownlint, asdf, actionlint, CODEOWNERS)
- **License year update**: Automated license year maintenance

## Project Structure

- `.github/`: GitHub-specific configuration (workflows, CODEOWNERS, templates)
- `.editorconfig`: Editor configuration for consistent code formatting
- `.pre-commit-config.yaml`: Pre-commit hooks configuration
- `.tool-versions`: Tool version definitions for mise
- `Brewfile`: Homebrew package definitions for brew bundle
- `cspell.json`: Spell checker configuration and custom dictionary
- `docs/`: Documentation files
- `justfile`: Task automation definitions
- `Makefile`: Homebrew bootstrap setup
- `renovate.json5`: Dependency update automation configuration

## Code Ownership

- Global code owner: @tqer39 (as defined in CODEOWNERS)

## Development Workflow

1. Pre-commit hooks will automatically run on commit
2. Pull requests are automatically assigned to the author
3. PRs are automatically labeled based on changed files
4. All pre-commit checks must pass before merging
5. Renovate will automatically create PRs for dependency updates
