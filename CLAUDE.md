# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a base boilerplate template repository designed to provide foundational project structure and configuration files. The repository serves as a starting point for new projects with pre-configured development tools and workflows.

## Code Quality and Linting

This repository uses pre-commit hooks for code quality enforcement. Run the following commands:

```bash
# Install pre-commit hooks
pre-commit install

# Run all pre-commit hooks manually
pre-commit run --all-files

# Run a specific hook
pre-commit run <hook-name>
```

### Available pre-commit hooks:
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

## Dependency Management

- **Renovate**: Automated dependency updates are configured via `renovate.json5`, extending from `github>tqer39/renovate-config`

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
- `cspell.json`: Spell checker configuration and custom dictionary
- `renovate.json5`: Dependency update automation configuration

## Code Ownership

- Global code owner: @tqer39 (as defined in CODEOWNERS)

## Development Workflow

1. Pre-commit hooks will automatically run on commit
2. Pull requests are automatically assigned to the author
3. PRs are automatically labeled based on changed files
4. All pre-commit checks must pass before merging
5. Renovate will automatically create PRs for dependency updates