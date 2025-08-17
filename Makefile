# Bootstrap development environment
# This Makefile handles the initial setup of development tools

.DEFAULT_GOAL := help

# Detect operating system
UNAME_S := $(shell uname -s)

# Check if command exists
define check_command
	@command -v $(1) >/dev/null 2>&1
endef

.PHONY: help
help: ## Show this help message
	@echo "Bootstrap development environment"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: check-os
check-os: ## Check operating system compatibility
	@echo "Detected OS: $(UNAME_S)"
ifeq ($(UNAME_S),Darwin)
	@echo "✓ macOS detected - compatible"
else ifeq ($(UNAME_S),Linux)
	@echo "✓ Linux detected - compatible"
else
	@echo "⚠ Unsupported OS: $(UNAME_S)"
	@echo "This Makefile supports macOS and Linux only"
	@exit 1
endif

.PHONY: install-brew
install-brew: check-os ## Install Homebrew package manager
ifeq ($(UNAME_S),Darwin)
	@echo "Installing Homebrew for macOS..."
	@if $(call check_command,brew); then \
		echo "✓ Homebrew already installed"; \
	else \
		echo "→ Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		echo "✓ Homebrew installed successfully"; \
	fi
else ifeq ($(UNAME_S),Linux)
	@echo "Installing Homebrew for Linux..."
	@if $(call check_command,brew); then \
		echo "✓ Homebrew already installed"; \
	else \
		echo "→ Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		echo "→ Adding Homebrew to PATH..."; \
		echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc; \
		eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; \
		echo "✓ Homebrew installed successfully"; \
	fi
endif

.PHONY: install-mise
install-mise: install-brew ## Install mise version manager
	@echo "Installing mise..."
	@if $(call check_command,mise); then \
		echo "✓ mise already installed"; \
	else \
		echo "→ Installing mise via Homebrew..."; \
		brew install mise; \
		echo "✓ mise installed successfully"; \
	fi

.PHONY: install-just
install-just: install-brew ## Install just command runner
	@echo "Installing just..."
	@if $(call check_command,just); then \
		echo "✓ just already installed"; \
	else \
		echo "→ Installing just via Homebrew..."; \
		brew install just; \
		echo "✓ just installed successfully"; \
	fi

.PHONY: bootstrap
bootstrap: install-brew install-mise install-just ## Bootstrap complete development environment
	@echo ""
	@echo "🎉 Bootstrap complete!"
	@echo ""
	@echo "Next steps:"
	@echo "1. Reload your shell or run: source ~/.bashrc (Linux) or restart terminal (macOS)"
	@echo "2. Run: just setup"
	@echo ""
	@echo "Available commands after bootstrap:"
	@echo "  just help    - Show available tasks"
	@echo "  just setup   - Setup development environment"
	@echo "  just lint    - Run code quality checks"

.PHONY: clean
clean: ## Remove installed tools (use with caution)
	@echo "⚠ This will remove mise and just, but not Homebrew"
	@read -p "Are you sure? (y/N): " confirm && [ "$$confirm" = "y" ] || exit 1
	@if $(call check_command,mise); then brew uninstall mise; fi
	@if $(call check_command,just); then brew uninstall just; fi
	@echo "✓ Tools removed"
