#!/bin/bash

# Claude Code Configuration Installer
# Installs shared Claude Code configuration files to ~/.claude/

set -e

CLAUDE_DIR="$HOME/.claude"
REPO_NAME="claude-config"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo "╔════════════════════════════════════════╗"
echo "║   Claude Code Configuration Installer   ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Check if running from cloned repo or via curl
if [ -f "$SCRIPT_DIR/stacks/craftcms.md" ]; then
    # Running from cloned repo
    INSTALL_SOURCE="local"
    echo -e "${GREEN}Installing from local repository...${NC}"
else
    # Running via curl - need to clone first
    INSTALL_SOURCE="remote"
    REPO_URL="${REPO_URL:-https://github.com/roberthallatt/claude-config}"
    
    echo -e "${YELLOW}Repository URL: $REPO_URL${NC}"
    echo ""
    
    # Check for git
    if ! command -v git &> /dev/null; then
        echo -e "${RED}Error: git is required but not installed.${NC}"
        exit 1
    fi
    
    # Clone to temp directory
    TEMP_DIR=$(mktemp -d)
    echo "Cloning repository..."
    git clone --depth 1 "$REPO_URL" "$TEMP_DIR" || {
        echo -e "${RED}Error: Failed to clone repository.${NC}"
        echo "Make sure the repository URL is correct and accessible."
        rm -rf "$TEMP_DIR"
        exit 1
    }
    SCRIPT_DIR="$TEMP_DIR"
fi

# Create ~/.claude directory if it doesn't exist
mkdir -p "$CLAUDE_DIR"

# Backup existing files if they exist
backup_if_exists() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d%H%M%S)"
        echo -e "${YELLOW}Backing up existing $file to $backup${NC}"
        mv "$file" "$backup"
    fi
}

# Install stacks
echo ""
echo "Installing stack configurations..."
backup_if_exists "$CLAUDE_DIR/stacks"
rm -rf "$CLAUDE_DIR/stacks"
cp -r "$SCRIPT_DIR/stacks" "$CLAUDE_DIR/stacks"
echo -e "${GREEN}✓ Stacks installed${NC}"

# Install libraries
echo "Installing library configurations..."
backup_if_exists "$CLAUDE_DIR/libraries"
rm -rf "$CLAUDE_DIR/libraries"
cp -r "$SCRIPT_DIR/libraries" "$CLAUDE_DIR/libraries"
echo -e "${GREEN}✓ Libraries installed${NC}"

# Install global CLAUDE.md if it doesn't exist (don't overwrite user's customizations)
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    echo "Installing global CLAUDE.md..."
    cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    echo -e "${GREEN}✓ Global CLAUDE.md installed${NC}"
else
    echo -e "${YELLOW}⚠ Global CLAUDE.md already exists, skipping (won't overwrite your customizations)${NC}"
    echo "  To update, manually copy from: $SCRIPT_DIR/CLAUDE.md"
fi

# Clean up temp directory if we cloned
if [ "$INSTALL_SOURCE" = "remote" ]; then
    rm -rf "$TEMP_DIR"
fi

# Print summary
echo ""
echo "════════════════════════════════════════"
echo -e "${GREEN}Installation complete!${NC}"
echo "════════════════════════════════════════"
echo ""
echo "Installed to: $CLAUDE_DIR/"
echo ""
echo "Files installed:"
echo "  ~/.claude/CLAUDE.md        - Global preferences"
echo "  ~/.claude/stacks/          - CMS/framework configs"
echo "  ~/.claude/libraries/       - CSS/JS library configs"
echo ""
echo "Usage in your project CLAUDE.md:"
echo ""
echo "  @~/.claude/stacks/craftcms.md"
echo "  @~/.claude/libraries/tailwind.md"
echo "  @~/.claude/libraries/alpinejs.md"
echo ""
echo "To update later, run this script again or:"
echo "  cd ~/.claude && git pull  (if cloned manually)"
echo ""
