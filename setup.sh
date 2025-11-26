#!/bin/bash

set -e  # Exit on error

echo "Setting up Neovim configuration..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if running from the right directory
if [ ! -f "init.lua" ]; then
    echo -e "${RED}Error: Must run from nvim config directory${NC}"
    echo "Usage: ./setup.sh"
    exit 1
fi

# Check dependencies
echo -e "${YELLOW}Checking dependencies...${NC}"

check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}Error: $1 is not installed${NC}"
        echo "Please install $1 and try again"
        exit 1
    fi
}

check_command nvim
check_command git
check_command go  # For Go development

echo -e "${GREEN}✓ All dependencies found${NC}"

# Determine config directory
if [ -z "$XDG_CONFIG_HOME" ]; then
    CONFIG_DIR="$HOME/.config/nvim"
else
    CONFIG_DIR="$XDG_CONFIG_HOME/nvim"
fi

# Check if config already exists
if [ -d "$CONFIG_DIR" ] && [ "$(realpath "$CONFIG_DIR")" != "$(realpath .)" ]; then
    echo -e "${YELLOW}Warning: $CONFIG_DIR already exists${NC}"
    read -p "Backup existing config? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        BACKUP_DIR="${CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backing up to $BACKUP_DIR"
        mv "$CONFIG_DIR" "$BACKUP_DIR"
    else
        echo -e "${RED}Aborted. Please handle existing config manually.${NC}"
        exit 1
    fi
fi

# Create symlink or copy
if [ "$(realpath "$CONFIG_DIR")" != "$(realpath .)" ]; then
    echo -e "${YELLOW}Creating symlink...${NC}"
    ln -sfn "$(realpath .)" "$CONFIG_DIR"
    echo -e "${GREEN}✓ Symlink created${NC}"
fi

# Install lazy.nvim if not present
LAZYPATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZYPATH" ]; then
    echo -e "${YELLOW}Installing lazy.nvim...${NC}"
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git "$LAZYPATH"
    echo -e "${GREEN}✓ lazy.nvim installed${NC}"
else
    echo -e "${GREEN}✓ lazy.nvim already installed${NC}"
fi

# Install Go tools if needed
echo -e "${YELLOW}Checking Go tools...${NC}"
if ! command -v gopls &> /dev/null; then
    echo "Installing gopls..."
    go install golang.org/x/tools/gopls@latest
    echo -e "${GREEN}✓ gopls installed${NC}"
else
    echo -e "${GREEN}✓ gopls found${NC}"
fi

if ! command -v goimports &> /dev/null; then
    echo "Installing goimports..."
    go install golang.org/x/tools/cmd/goimports@latest
    echo -e "${GREEN}✓ goimports installed${NC}"
else
    echo -e "${GREEN}✓ goimports found${NC}"
fi

# Install TypeScript language server
echo -e "${YELLOW}Checking TypeScript language server...${NC}"
if ! command -v typescript-language-server &> /dev/null; then
    echo "Installing typescript-language-server..."
    if command -v npm &> /dev/null; then
        npm install -g typescript-language-server typescript
        echo -e "${GREEN}✓ typescript-language-server installed${NC}"
    else
        echo -e "${RED}Error: npm is not installed${NC}"
        echo "Please install Node.js/npm to use TypeScript support"
        echo "Or install manually: npm install -g typescript-language-server typescript"
    fi
else
    echo -e "${GREEN}✓ typescript-language-server found${NC}"
fi

# Make sure Go bin is in PATH
if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
    echo -e "${YELLOW}Warning: ~/go/bin not in PATH${NC}"
    echo "Add this to your ~/.bashrc or ~/.zshrc:"
    echo "export PATH=\$PATH:\$HOME/go/bin"
fi

# Check if npm global bin is in PATH (for typescript-language-server)
NPM_BIN="$(npm config get prefix)/bin"
if [[ ":$PATH:" != *":$NPM_BIN:"* ]] && command -v npm &> /dev/null; then
    echo -e "${YELLOW}Warning: npm global bin directory not in PATH${NC}"
    echo "Add this to your ~/.bashrc or ~/.zshrc:"
    echo "export PATH=\$PATH:\$(npm config get prefix)/bin"
fi

echo ""
echo -e "${GREEN}✓ Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Start neovim: nvim"
echo "2. Lazy.nvim will automatically install all plugins"
echo "3. Run :GoInstallBinaries inside neovim if needed"
echo ""
