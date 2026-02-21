#!/bin/bash
#
# serve-docs.sh
# Serve the documentation locally in a web browser
#
# Usage:
#   ./serve-docs.sh [port] [--no-open]
#
# Options:
#   port        Port number (default: 8000)
#   --no-open   Don't automatically open browser
#
# Default port: 8000

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT="8000"
OPEN_BROWSER=true

# Parse arguments
for arg in "$@"; do
    case $arg in
        --no-open)
            OPEN_BROWSER=false
            ;;
        [0-9]*)
            PORT="$arg"
            ;;
    esac
done

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Function to open browser (cross-platform)
open_browser() {
    local url="$1"
    # Wait a moment for server to start
    sleep 1
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        open "$url"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v xdg-open &> /dev/null; then
            xdg-open "$url"
        elif command -v gnome-open &> /dev/null; then
            gnome-open "$url"
        fi
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        # Windows (Git Bash, Cygwin)
        start "$url"
    fi
}

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}  AI Config Documentation Server${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}Documentation available at:${NC}"
echo ""
echo -e "  http://localhost:${PORT}/"
echo ""
echo -e "Press Ctrl+C to stop the server"
echo ""

# Open browser in background if enabled
if [ "$OPEN_BROWSER" = true ]; then
    open_browser "http://localhost:${PORT}/" &
fi

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
