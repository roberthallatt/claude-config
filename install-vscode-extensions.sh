#!/usr/bin/env bash
#
# Install VSCode extensions from extensions.json
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

PROJECT_DIR="${1:-.}"

if [[ ! -f "$PROJECT_DIR/.vscode/extensions.json" ]]; then
  echo -e "${RED}Error: No .vscode/extensions.json found in $PROJECT_DIR${NC}"
  exit 1
fi

# Check if code command is available
if ! command -v code &> /dev/null; then
  echo -e "${RED}Error: 'code' command not found${NC}"
  echo "Please install VSCode command line tools:"
  echo "  1. Open VSCode"
  echo "  2. Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
  exit 1
fi

echo -e "${BLUE}Installing VSCode extensions from .vscode/extensions.json...${NC}"
echo ""

# Parse extensions.json and extract extension IDs
EXTENSIONS=$(grep -oP '"\K[^"]+(?=")' "$PROJECT_DIR/.vscode/extensions.json" | grep '\.' || true)

if [[ -z "$EXTENSIONS" ]]; then
  echo -e "${YELLOW}No extensions found in extensions.json${NC}"
  exit 0
fi

INSTALLED=0
SKIPPED=0
FAILED=0

while IFS= read -r extension; do
  if code --list-extensions | grep -q "^${extension}$"; then
    echo -e "  ${YELLOW}○${NC} $extension (already installed)"
    ((SKIPPED++))
  else
    echo -e "  ${CYAN}Installing${NC} $extension..."
    if code --install-extension "$extension" --force &> /dev/null; then
      echo -e "  ${GREEN}✓${NC} $extension installed"
      ((INSTALLED++))
    else
      echo -e "  ${RED}✗${NC} Failed to install $extension"
      ((FAILED++))
    fi
  fi
done <<< "$EXTENSIONS"

echo ""
echo -e "${GREEN}Installation complete:${NC}"
echo -e "  Installed: $INSTALLED"
echo -e "  Skipped:   $SKIPPED"
[[ $FAILED -gt 0 ]] && echo -e "  ${RED}Failed:    $FAILED${NC}"

if [[ $INSTALLED -gt 0 ]]; then
  echo ""
  echo -e "${CYAN}Note: Reload VSCode to activate new extensions${NC}"
fi
