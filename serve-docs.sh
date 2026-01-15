#!/bin/bash
#
# serve-docs.sh
# Serve the documentation locally in a web browser
#
# Usage:
#   ./serve-docs.sh [port]
#
# Default port: 8000

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT="${1:-8000}"

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}  AI Config Documentation Server${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}Documentation available at:${NC}"
echo ""
echo -e "  Main docs:  http://localhost:${PORT}/docs/"
echo -e "  README:     http://localhost:${PORT}/"
echo ""
echo -e "Press Ctrl+C to stop the server"
echo ""

# Check if Python is available
if command -v python3 &> /dev/null; then
    cd "$SCRIPT_DIR"
    python3 -m http.server "$PORT"
elif command -v python &> /dev/null; then
    cd "$SCRIPT_DIR"
    python -m http.server "$PORT"
else
    echo "Error: Python is required to serve documentation"
    echo "Install Python or use: brew install python"
    exit 1
fi
