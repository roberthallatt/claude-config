#!/usr/bin/env bash
#
# Install global Claude Code configuration files to ~/.claude/
#
# This installs:
# - Stack-specific knowledge (stacks/)
# - Library/framework references (libraries/)
# - Global coding preferences (global/CLAUDE.md)
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Target directory
CLAUDE_DIR="$HOME/.claude"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Claude Code Global Configuration Installer${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if ~/.claude exists
if [[ -d "$CLAUDE_DIR" ]]; then
  echo -e "${YELLOW}~/.claude/ directory already exists${NC}"
  echo ""
  echo "This will:"
  echo "  - Add/update stack knowledge files"
  echo "  - Add/update library reference files"
  echo "  - Add/update global coding preferences"
  echo ""
  read -p "Continue? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled"
    exit 0
  fi
else
  echo -e "${CYAN}Creating ~/.claude/ directory...${NC}"
  mkdir -p "$CLAUDE_DIR"
fi

echo ""

# Install stacks
if [[ -d "$SCRIPT_DIR/stacks" ]]; then
  echo -e "${CYAN}Installing stack knowledge files...${NC}"
  mkdir -p "$CLAUDE_DIR/stacks"

  STACK_COUNT=0
  for file in "$SCRIPT_DIR/stacks"/*.md; do
    if [[ -f "$file" ]]; then
      filename=$(basename "$file")
      cp "$file" "$CLAUDE_DIR/stacks/$filename"
      echo -e "  ${GREEN}✓${NC} $filename"
      ((STACK_COUNT++))
    fi
  done
  echo ""
else
  echo -e "${YELLOW}⚠ No stacks/ directory found${NC}"
  echo ""
fi

# Install libraries
if [[ -d "$SCRIPT_DIR/libraries" ]]; then
  echo -e "${CYAN}Installing library reference files...${NC}"
  mkdir -p "$CLAUDE_DIR/libraries"

  LIBRARY_COUNT=0
  for file in "$SCRIPT_DIR/libraries"/*.md; do
    if [[ -f "$file" ]]; then
      filename=$(basename "$file")
      cp "$file" "$CLAUDE_DIR/libraries/$filename"
      echo -e "  ${GREEN}✓${NC} $filename"
      ((LIBRARY_COUNT++))
    fi
  done
  echo ""
else
  echo -e "${YELLOW}⚠ No libraries/ directory found${NC}"
  echo ""
fi

# Install global CLAUDE.md
if [[ -f "$SCRIPT_DIR/global/CLAUDE.md" ]]; then
  echo -e "${CYAN}Installing global coding preferences...${NC}"

  if [[ -f "$CLAUDE_DIR/CLAUDE.md" ]]; then
    echo -e "${YELLOW}  ~/.claude/CLAUDE.md already exists${NC}"
    read -p "  Overwrite? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      # Backup existing
      backup="$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
      cp "$CLAUDE_DIR/CLAUDE.md" "$backup"
      echo -e "  ${CYAN}Backed up to: $(basename "$backup")${NC}"

      cp "$SCRIPT_DIR/global/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
      echo -e "  ${GREEN}✓${NC} CLAUDE.md updated"
    else
      echo -e "  ${YELLOW}○${NC} CLAUDE.md skipped"
    fi
  else
    cp "$SCRIPT_DIR/global/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    echo -e "  ${GREEN}✓${NC} CLAUDE.md"
  fi
  echo ""
else
  echo -e "${YELLOW}⚠ No global/CLAUDE.md found${NC}"
  echo ""
fi

# Summary
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Global configuration installed to: ${CYAN}$CLAUDE_DIR${NC}"
echo ""
echo "What was installed:"
echo "  ${GREEN}✓${NC} $STACK_COUNT stack knowledge files"
echo "  ${GREEN}✓${NC} $LIBRARY_COUNT library reference files"
echo "  ${GREEN}✓${NC} Global coding preferences"
echo ""
echo -e "${CYAN}Project CLAUDE.md files will reference these using:${NC}"
echo "  @~/.claude/stacks/expressionengine.md"
echo "  @~/.claude/libraries/tailwind.md"
echo "  @~/.claude/libraries/alpinejs.md"
echo ""
echo -e "${CYAN}Next steps:${NC}"
echo "  Deploy configurations to your projects:"
echo "  ${YELLOW}./setup-project.sh --stack=expressionengine --project=/path/to/project${NC}"
echo ""
