# Development tasks for boilerplate-base

# Show available commands
help:
    @just --list

# Setup development environment
setup:
    @echo "Setting up development environment..."
    brew bundle install
    @if command -v mise >/dev/null 2>&1; then \
        echo "→ Installing tools with mise..."; \
        if [ "$(basename "$SHELL")" = "zsh" ]; then \
            eval "$(mise activate zsh)"; \
        elif [ "$(basename "$SHELL")" = "bash" ]; then \
            eval "$(mise activate bash)"; \
        fi; \
        mise install; \
    else \
        echo "⚠ mise not found. Please run 'make bootstrap' first."; \
        exit 1; \
    fi
    @echo "→ Installing Node.js CLI tools..."
    $(mise where nodejs)/bin/npm install -g @anthropic-ai/claude-code
    $(mise where nodejs)/bin/npm install -g @google/gemini-cli
    pre-commit install
    @echo "Setup complete!"

# Run pre-commit hooks on all files
lint:
    pre-commit run --all-files

# Run specific pre-commit hook
lint-hook hook:
    pre-commit run {{hook}}

# Update pre-commit hooks to latest versions
update-hooks:
    pre-commit autoupdate

# Fix common formatting issues
fix:
    pre-commit run end-of-file-fixer --all-files
    pre-commit run trailing-whitespace --all-files
    pre-commit run markdownlint-cli2 --all-files

# Clean pre-commit cache
clean:
    @echo "Cleaning pre-commit cache..."
    -pre-commit clean
    @if [ -d ~/.cache/pre-commit ]; then \
        echo "→ Force removing pre-commit cache directory..."; \
        rm -rf ~/.cache/pre-commit; \
    fi
    @echo "Clean complete!"

# Show mise status
status:
    mise list

# Install mise tools
install:
    mise install

# Update mise tools
update:
    mise upgrade

# Update brew packages
update-brew:
    brew update
    brew bundle install
    brew upgrade

# Run rulesync with passthrough args
rulesync args='':
    @if command -v rulesync >/dev/null 2>&1; then \
        echo "Running: rulesync {{args}}"; \
        rulesync {{args}}; \
    else \
        echo "⚠ rulesync が見つかりません。docs/RULESYNC.ja.md を参照してインストールしてください。"; \
        exit 1; \
    fi
