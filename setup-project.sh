#!/bin/bash
#
# setup-project.sh
# Deploy AI coding assistant configuration to any project
#
# Usage:
#   ./setup-project.sh --project=/path/to/project [options]
#   ./setup-project.sh --stack=expressionengine --project=/path/to/project [options]
#
# Options:
#   --stack       Stack template (auto-detected if not specified)
#   --project     Target project directory
#   --name        Human-readable project name (optional, derived from directory if not provided)
#   --slug        Project slug for templates (optional, derived from directory if not provided)
#   --dry-run     Show what would be done without making changes
#   --force       Overwrite existing configuration without prompting
#   --clean       Remove existing Claude/AI config before deploying
#   --refresh     Re-scan project and regenerate CLAUDE.md only (preserves .claude/ customizations)
#   --skip-vscode       Skip VSCode settings (if you manage them separately)
#   --install-extensions Install recommended VSCode extensions automatically
#   --with-mcp          Deploy .mcp.json for ExpressionEngine MCP server integration
#   --with-gemini       Deploy .gemini/ configuration for Gemini Code Assist
#   --with-copilot      Deploy .github/copilot-instructions.md for GitHub Copilot
#   --with-cursor       Deploy .cursorrules for Cursor AI
#   --with-windsurf     Deploy .windsurfrules for Windsurf AI
#   --with-codex        Deploy AGENTS.md for OpenAI Codex
#   --with-aider        Deploy CONVENTIONS.md for Aider
#   --with-all          Deploy configuration for ALL supported AI assistants
#   --analyze           Generate analysis prompt for AI to build custom config
#   --discover          AI-powered analysis mode for unknown/custom stacks
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script directory (where claude-config-repo lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default values
STACK=""
PROJECT_DIR=""
PROJECT_NAME=""
PROJECT_SLUG=""
DRY_RUN=false
FORCE=false
CLEAN=false
REFRESH=false
SKIP_VSCODE=false
INSTALL_EXTENSIONS=false
WITH_MCP=false
WITH_GEMINI=false
WITH_COPILOT=false
WITH_CURSOR=false
WITH_WINDSURF=false
WITH_CODEX=false
WITH_AIDER=false
WITH_ALL=false
ANALYZE=false
DISCOVER=false

# Detected values (populated during analysis)
DDEV_NAME=""
DDEV_DOCROOT=""
DDEV_PHP=""
DDEV_DB_TYPE=""
DDEV_DB_VERSION=""
DDEV_NODEJS=""
TEMPLATE_GROUP=""
HAS_TAILWIND=false
HAS_ALPINE=false
HAS_FOUNDATION=false
HAS_SCSS=false
HAS_VANILLA_JS=false
HAS_STASH=false
HAS_STRUCTURE=false
HAS_BILINGUAL=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --stack=*)
      STACK="${1#*=}"
      shift
      ;;
    --project=*)
      PROJECT_DIR="${1#*=}"
      shift
      ;;
    --name=*)
      PROJECT_NAME="${1#*=}"
      shift
      ;;
    --slug=*)
      PROJECT_SLUG="${1#*=}"
      shift
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --force)
      FORCE=true
      shift
      ;;
    --clean)
      CLEAN=true
      shift
      ;;
    --refresh)
      REFRESH=true
      shift
      ;;
    --skip-vscode)
      SKIP_VSCODE=true
      shift
      ;;
    --install-extensions)
      INSTALL_EXTENSIONS=true
      shift
      ;;
    --with-mcp)
      WITH_MCP=true
      shift
      ;;
    --with-gemini)
      WITH_GEMINI=true
      shift
      ;;
    --with-copilot)
      WITH_COPILOT=true
      shift
      ;;
    --with-cursor)
      WITH_CURSOR=true
      shift
      ;;
    --with-windsurf)
      WITH_WINDSURF=true
      shift
      ;;
    --with-codex)
      WITH_CODEX=true
      shift
      ;;
    --with-aider)
      WITH_AIDER=true
      shift
      ;;
    --with-all)
      WITH_ALL=true
      WITH_GEMINI=true
      WITH_COPILOT=true
      WITH_CURSOR=true
      WITH_WINDSURF=true
      WITH_CODEX=true
      WITH_AIDER=true
      shift
      ;;
    --analyze)
      ANALYZE=true
      shift
      ;;
    --discover)
      DISCOVER=true
      shift
      ;;
    -h|--help)
      echo "Usage: $0 --project=<path> [options]"
      echo ""
      echo "Options:"
      echo "  --stack=<n>       Stack template (auto-detected if not specified)"
      echo "  --project=<path>  Target project directory (required)"
      echo "  --discover        AI-powered mode: analyze codebase and generate custom config"
      echo "  --name=<n>        Human-readable project name"
      echo "  --slug=<slug>     Project slug for templates"
      echo "  --dry-run         Preview changes without applying"
      echo "  --force           Overwrite existing config without prompting"
      echo "  --clean           Remove existing config before deploying (fresh start)"
      echo "  --refresh         Update config files (auto-detects stack from CLAUDE.md)"
      echo "  --skip-vscode     Do not copy VSCode settings"
      echo "  --install-extensions Install recommended VSCode extensions automatically"
      echo ""
      echo "AI Assistants:"
      echo "  --with-gemini     Deploy .gemini/ for Gemini Code Assist"
      echo "  --with-copilot    Deploy .github/copilot-instructions.md for GitHub Copilot"
      echo "  --with-cursor     Deploy .cursorrules for Cursor AI"
      echo "  --with-windsurf   Deploy .windsurfrules for Windsurf AI"
      echo "  --with-codex      Deploy AGENTS.md for OpenAI Codex"
      echo "  --with-aider      Deploy CONVENTIONS.md for Aider"
      echo "  --with-all        Deploy ALL AI assistant configurations"
      echo "  --with-mcp        Deploy .mcp.json for EE MCP server integration"
      echo ""
      echo "Other:"
      echo "  --analyze         Generate analysis prompt for Claude"
      echo ""
      echo "Available stacks:"
      ls -1 "$SCRIPT_DIR/projects/" 2>/dev/null | sed 's/^/  - /'
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      exit 1
      ;;
  esac
done

# Validation and auto-detection
if [[ -z "$PROJECT_DIR" ]]; then
  echo -e "${RED}Error: --project is required${NC}"
  exit 1
fi

# Resolve project directory to absolute path
PROJECT_DIR="$(cd "$PROJECT_DIR" 2>/dev/null && pwd)" || {
  echo -e "${RED}Error: Project directory does not exist: $PROJECT_DIR${NC}"
  exit 1
}

# Auto-detect stack if not specified
if [[ -z "$STACK" ]]; then
  # First try: Check existing CLAUDE.md (for --refresh)
  if [[ -f "$PROJECT_DIR/CLAUDE.md" ]]; then
    DETECTED_STACK=$(grep '@~/.claude/stacks/' "$PROJECT_DIR/CLAUDE.md" 2>/dev/null | head -1 | sed -E 's|.*@~/.claude/stacks/([^.]+)\.md.*|\1|')
    if [[ -n "$DETECTED_STACK" ]]; then
      STACK="$DETECTED_STACK"
      echo -e "${CYAN}Auto-detected stack from CLAUDE.md: ${GREEN}$STACK${NC}"
    fi
  fi

  # Second try: Detect from project files
  if [[ -z "$STACK" ]]; then
    # We need the detect_stack function - source it inline for now
    # ExpressionEngine
    if [[ -d "$PROJECT_DIR/system/ee" ]] || [[ -f "$PROJECT_DIR/system/user/config/config.php" ]]; then
      if [[ -f "$PROJECT_DIR/composer.json" ]] && grep -q "laravel/framework" "$PROJECT_DIR/composer.json" 2>/dev/null; then
        STACK="coilpack"
      else
        STACK="expressionengine"
      fi
    # Craft CMS
    elif [[ -f "$PROJECT_DIR/craft" ]] && [[ -f "$PROJECT_DIR/composer.json" ]] && grep -q "craftcms/cms" "$PROJECT_DIR/composer.json" 2>/dev/null; then
      STACK="craftcms"
    # WordPress Bedrock
    elif [[ -d "$PROJECT_DIR/web/app/mu-plugins" ]] || [[ -d "$PROJECT_DIR/web/app/plugins" ]] || [[ -f "$PROJECT_DIR/wp-config.php" ]] || [[ -d "$PROJECT_DIR/wp-content" ]]; then
      STACK="wordpress-roots"
    # Next.js
    elif [[ -f "$PROJECT_DIR/next.config.js" ]] || [[ -f "$PROJECT_DIR/next.config.mjs" ]] || [[ -f "$PROJECT_DIR/next.config.ts" ]]; then
      STACK="nextjs"
    # Docusaurus
    elif [[ -f "$PROJECT_DIR/docusaurus.config.js" ]] || [[ -f "$PROJECT_DIR/docusaurus.config.ts" ]]; then
      STACK="docusaurus"
    # Check package.json for Next.js or Docusaurus
    elif [[ -f "$PROJECT_DIR/package.json" ]]; then
      if grep -q '"next"' "$PROJECT_DIR/package.json" 2>/dev/null; then
        STACK="nextjs"
      elif grep -q '"@docusaurus' "$PROJECT_DIR/package.json" 2>/dev/null; then
        STACK="docusaurus"
      fi
    fi

    if [[ -n "$STACK" ]]; then
      echo -e "${CYAN}Auto-detected stack from project files: ${GREEN}$STACK${NC}"
    fi
  fi
fi

# If still no stack and --discover mode, use custom/generic stack
if [[ -z "$STACK" ]] && [[ "$DISCOVER" == true ]]; then
  STACK="custom"
  echo -e "${CYAN}Discovery mode: Will generate custom configuration${NC}"
fi

# Validate stack is specified or detected
if [[ -z "$STACK" ]]; then
  echo -e "${YELLOW}Could not auto-detect stack.${NC}"
  echo ""
  echo "Options:"
  echo "  1. Specify a stack:  --stack=<stack>"
  echo "  2. Use discovery mode:  --discover"
  echo ""
  echo "Available stacks:"
  ls -1 "$SCRIPT_DIR/projects/" 2>/dev/null | sed 's/^/  - /'
  echo "  - custom (use --discover for AI-powered setup)"
  exit 1
fi

# Check stack exists (or is custom)
STACK_DIR="$SCRIPT_DIR/projects/$STACK"
if [[ "$STACK" != "custom" ]] && [[ ! -d "$STACK_DIR" ]]; then
  echo -e "${RED}Error: Stack '$STACK' not found${NC}"
  echo "Available stacks:"
  ls -1 "$SCRIPT_DIR/projects/" 2>/dev/null | sed 's/^/  - /'
  echo "  - custom (use --discover for AI-powered setup)"
  exit 1
fi

# Derive project name and slug if not provided
if [[ -z "$PROJECT_NAME" ]]; then
  PROJECT_NAME="$(basename "$PROJECT_DIR")"
fi

if [[ -z "$PROJECT_SLUG" ]]; then
  PROJECT_SLUG="$(basename "$PROJECT_DIR" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
fi

# ============================================================================
# Project Detection Functions
# ============================================================================

detect_ddev_config() {
  local config_file="$PROJECT_DIR/.ddev/config.yaml"
  if [[ -f "$config_file" ]]; then
    DDEV_NAME=$(grep -E "^name:" "$config_file" 2>/dev/null | head -1 | sed 's/name:[[:space:]]*//' | tr -d '"' || echo "")
    DDEV_DOCROOT=$(grep -E "^docroot:" "$config_file" 2>/dev/null | head -1 | sed 's/docroot:[[:space:]]*//' | tr -d '"' || echo "public")
    DDEV_PHP=$(grep -E "^php_version:" "$config_file" 2>/dev/null | head -1 | sed 's/php_version:[[:space:]]*//' | tr -d '"' || echo "8.1")
    DDEV_NODEJS=$(grep -E "^nodejs_version:" "$config_file" 2>/dev/null | head -1 | sed 's/nodejs_version:[[:space:]]*//' | tr -d '"' || echo "18")
    
    # TLD detection (default: ddev.site)
    DDEV_TLD=$(grep -E "^project_tld:" "$config_file" 2>/dev/null | head -1 | sed 's/project_tld:[[:space:]]*//' | tr -d '"' || echo "ddev.site")
    
    # Get all additional FQDNs
    local fqdns=$(grep -A10 "additional_fqdns:" "$config_file" 2>/dev/null | grep -E "^\s+-" | sed 's/.*-[[:space:]]*//' | tr -d '"')
    
    # Try to find an FQDN that contains the DDEV name (prefer English/primary domain)
    DDEV_PRIMARY_FQDN=""
    if [[ -n "$fqdns" ]]; then
      # First, try to find one that contains the DDEV name
      DDEV_PRIMARY_FQDN=$(echo "$fqdns" | grep -i "$DDEV_NAME" | head -1 || true)
      # If no match, use the first FQDN
      if [[ -z "$DDEV_PRIMARY_FQDN" ]]; then
        DDEV_PRIMARY_FQDN=$(echo "$fqdns" | head -1)
      fi
    fi
    
    # Build primary URL
    if [[ -n "$DDEV_PRIMARY_FQDN" ]]; then
      # Check if FQDN already has a TLD (contains a dot after the hostname)
      if [[ "$DDEV_PRIMARY_FQDN" == *.*.* ]]; then
        # Already a full FQDN (e.g., www.kidsnewtocanada.test)
        DDEV_PRIMARY_URL="https://$DDEV_PRIMARY_FQDN"
      else
        # Partial FQDN (e.g., www.caringforkids) - append the project TLD
        DDEV_PRIMARY_URL="https://${DDEV_PRIMARY_FQDN}.${DDEV_TLD}"
      fi
    elif [[ -n "$DDEV_TLD" ]] && [[ "$DDEV_TLD" != "ddev.site" ]]; then
      DDEV_PRIMARY_URL="https://${DDEV_NAME}.${DDEV_TLD}"
    else
      DDEV_PRIMARY_URL="https://${DDEV_NAME}.ddev.site"
    fi
    
    # Database detection (more complex due to nested structure)
    if grep -q "type: mariadb" "$config_file" 2>/dev/null; then
      DDEV_DB_TYPE="MariaDB"
      DDEV_DB_VERSION=$(grep -A1 "database:" "$config_file" 2>/dev/null | grep "version:" | sed 's/.*version:[[:space:]]*//' | tr -d '"' || echo "10.11")
    elif grep -q "type: mysql" "$config_file" 2>/dev/null; then
      DDEV_DB_TYPE="MySQL"
      DDEV_DB_VERSION=$(grep -A1 "database:" "$config_file" 2>/dev/null | grep "version:" | sed 's/.*version:[[:space:]]*//' | tr -d '"' || echo "8.0")
    else
      DDEV_DB_TYPE="MariaDB"
      DDEV_DB_VERSION="10.11"
    fi
    return 0
  fi
  return 1
}

detect_template_group() {
  local templates_dir="$PROJECT_DIR/system/user/templates"
  if [[ -d "$templates_dir" ]]; then
    # Find the first non-underscore directory (the main template group)
    TEMPLATE_GROUP=$(ls -1 "$templates_dir" 2>/dev/null | grep -v "^_" | head -1 || true)
  fi
  return 0
}

detect_frontend_tools() {
  # Check for Tailwind
  if [[ -f "$PROJECT_DIR/$DDEV_DOCROOT/tailwind.config.js" ]] || [[ -f "$PROJECT_DIR/tailwind.config.js" ]]; then
    HAS_TAILWIND=true
  fi

  # Check for Foundation
  if [[ -f "$PROJECT_DIR/package.json" ]] && grep -q "foundation-sites" "$PROJECT_DIR/package.json" 2>/dev/null; then
    HAS_FOUNDATION=true
  elif find "$PROJECT_DIR" -name "foundation.min.css" -o -name "foundation.css" 2>/dev/null | head -1 | grep -q .; then
    HAS_FOUNDATION=true
  fi

  # Check for SCSS/Sass
  if [[ -f "$PROJECT_DIR/package.json" ]] && grep -q '"sass"\|"node-sass"' "$PROJECT_DIR/package.json" 2>/dev/null; then
    HAS_SCSS=true
  elif find "$PROJECT_DIR" -name "*.scss" -o -name "*.sass" 2>/dev/null | head -1 | grep -q .; then
    HAS_SCSS=true
  fi

  # Check for Alpine.js (in package.json or templates)
  if [[ -f "$PROJECT_DIR/package.json" ]] && grep -q "alpinejs" "$PROJECT_DIR/package.json" 2>/dev/null; then
    HAS_ALPINE=true
  elif find "$PROJECT_DIR" -path "*/node_modules" -prune -o -path "*/vendor" -prune -o -path "*/.git" -prune -o \( -name "*.html" -o -name "*.twig" -o -name "*.blade.php" \) -type f -exec grep -lq "x-data\|@click" {} \; 2>/dev/null | head -1 | grep -q .; then
    HAS_ALPINE=true
  fi

  # Check for bilingual content patterns (user_language compared to 'en'/'fr' or lang variables)
  if find "$PROJECT_DIR" -path "*/node_modules" -prune -o -path "*/vendor" -prune -o -path "*/.git" -prune -o \( -name "*.html" -o -name "*.twig" -o -name "*.blade.php" \) -type f -exec grep -lq "user_language.*['\"]en['\"]\\|user_language.*['\"]fr['\"]\\|{lang:\\|{% if.*lang\\|@lang" {} \; 2>/dev/null | head -1 | grep -q .; then
    HAS_BILINGUAL=true
  fi

  # Detect vanilla JS/HTML (no major framework detected)
  # If no Tailwind, Foundation, or Alpine, assume vanilla JS/HTML is being used
  if [[ "$HAS_TAILWIND" == false ]] && [[ "$HAS_FOUNDATION" == false ]] && [[ "$HAS_ALPINE" == false ]]; then
    HAS_VANILLA_JS=true
  fi

  return 0
}

detect_addons() {
  local addons_dir="$PROJECT_DIR/system/user/addons"
  if [[ -d "$addons_dir" ]]; then
    [[ -d "$addons_dir/stash" ]] && HAS_STASH=true
    [[ -d "$addons_dir/structure" ]] && HAS_STRUCTURE=true
  fi
  return 0
}

# Auto-detect the technology stack based on project files
detect_stack() {
  local detected=""

  # ExpressionEngine: system/ee/ directory
  if [[ -d "$PROJECT_DIR/system/ee" ]] || [[ -f "$PROJECT_DIR/system/user/config/config.php" ]]; then
    # Check if it's Coilpack (EE + Laravel)
    if [[ -f "$PROJECT_DIR/composer.json" ]] && grep -q "laravel/framework" "$PROJECT_DIR/composer.json" 2>/dev/null; then
      detected="coilpack"
    else
      detected="expressionengine"
    fi

  # Craft CMS: craft executable or config/app.php with Craft
  elif [[ -f "$PROJECT_DIR/craft" ]] || [[ -f "$PROJECT_DIR/bootstrap.php" && -d "$PROJECT_DIR/config" ]]; then
    if [[ -f "$PROJECT_DIR/composer.json" ]] && grep -q "craftcms/cms" "$PROJECT_DIR/composer.json" 2>/dev/null; then
      detected="craftcms"
    fi

  # WordPress Bedrock (Roots): web/app structure or wp-content
  elif [[ -d "$PROJECT_DIR/web/app/mu-plugins" ]] || [[ -d "$PROJECT_DIR/web/app/plugins" ]]; then
    detected="wordpress-roots"
  elif [[ -f "$PROJECT_DIR/wp-config.php" ]] || [[ -d "$PROJECT_DIR/wp-content" ]]; then
    detected="wordpress-roots"

  # Next.js: next.config.js or next.config.mjs
  elif [[ -f "$PROJECT_DIR/next.config.js" ]] || [[ -f "$PROJECT_DIR/next.config.mjs" ]] || [[ -f "$PROJECT_DIR/next.config.ts" ]]; then
    detected="nextjs"

  # Docusaurus: docusaurus.config.js
  elif [[ -f "$PROJECT_DIR/docusaurus.config.js" ]] || [[ -f "$PROJECT_DIR/docusaurus.config.ts" ]]; then
    detected="docusaurus"

  # Additional framework detection for future stacks
  # Laravel (standalone): artisan file
  elif [[ -f "$PROJECT_DIR/artisan" ]] && [[ -f "$PROJECT_DIR/composer.json" ]]; then
    if grep -q "laravel/framework" "$PROJECT_DIR/composer.json" 2>/dev/null; then
      detected="laravel"  # Future stack
    fi

  # React (Create React App or Vite)
  elif [[ -f "$PROJECT_DIR/package.json" ]]; then
    if grep -q '"react"' "$PROJECT_DIR/package.json" 2>/dev/null; then
      if grep -q '"next"' "$PROJECT_DIR/package.json" 2>/dev/null; then
        detected="nextjs"
      elif grep -q '"@docusaurus' "$PROJECT_DIR/package.json" 2>/dev/null; then
        detected="docusaurus"
      fi
    fi
  fi

  echo "$detected"
}

# Detect additional technologies for discovery report
detect_all_technologies() {
  DETECTED_TECHNOLOGIES=()

  # Package managers
  [[ -f "$PROJECT_DIR/package.json" ]] && DETECTED_TECHNOLOGIES+=("npm/Node.js")
  [[ -f "$PROJECT_DIR/yarn.lock" ]] && DETECTED_TECHNOLOGIES+=("Yarn")
  [[ -f "$PROJECT_DIR/pnpm-lock.yaml" ]] && DETECTED_TECHNOLOGIES+=("pnpm")
  [[ -f "$PROJECT_DIR/bun.lockb" ]] && DETECTED_TECHNOLOGIES+=("Bun")
  [[ -f "$PROJECT_DIR/composer.json" ]] && DETECTED_TECHNOLOGIES+=("Composer/PHP")
  [[ -f "$PROJECT_DIR/Gemfile" ]] && DETECTED_TECHNOLOGIES+=("Ruby/Bundler")
  [[ -f "$PROJECT_DIR/requirements.txt" ]] || [[ -f "$PROJECT_DIR/pyproject.toml" ]] && DETECTED_TECHNOLOGIES+=("Python")
  [[ -f "$PROJECT_DIR/go.mod" ]] && DETECTED_TECHNOLOGIES+=("Go")
  [[ -f "$PROJECT_DIR/Cargo.toml" ]] && DETECTED_TECHNOLOGIES+=("Rust")

  # Frameworks (from package.json)
  if [[ -f "$PROJECT_DIR/package.json" ]]; then
    grep -q '"react"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("React")
    grep -q '"vue"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Vue.js")
    grep -q '"svelte"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Svelte")
    grep -q '"angular"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Angular")
    grep -q '"express"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Express.js")
    grep -q '"fastify"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Fastify")
    grep -q '"astro"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Astro")
    grep -q '"nuxt"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Nuxt.js")
    grep -q '"gatsby"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Gatsby")
    grep -q '"remix"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Remix")
    grep -q '"vite"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Vite")
    grep -q '"webpack"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Webpack")
    grep -q '"esbuild"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("esbuild")
    grep -q '"typescript"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("TypeScript")
    grep -q '"tailwindcss"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Tailwind CSS")
    grep -q '"alpinejs"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Alpine.js")
    grep -q '"sass"\|"node-sass"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Sass/SCSS")
    grep -q '"jest"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Jest")
    grep -q '"vitest"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Vitest")
    grep -q '"playwright"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Playwright")
    grep -q '"cypress"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Cypress")
    grep -q '"prisma"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Prisma")
    grep -q '"drizzle"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Drizzle ORM")
    grep -q '"eslint"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("ESLint")
    grep -q '"prettier"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Prettier")
    grep -q '"storybook"' "$PROJECT_DIR/package.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Storybook")
  fi

  # PHP frameworks (from composer.json)
  if [[ -f "$PROJECT_DIR/composer.json" ]]; then
    grep -q '"laravel/framework"' "$PROJECT_DIR/composer.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Laravel")
    grep -q '"symfony/' "$PROJECT_DIR/composer.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Symfony")
    grep -q '"craftcms/cms"' "$PROJECT_DIR/composer.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Craft CMS")
    grep -q '"expressionengine/' "$PROJECT_DIR/composer.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("ExpressionEngine")
    grep -q '"phpunit/' "$PROJECT_DIR/composer.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("PHPUnit")
    grep -q '"pestphp/' "$PROJECT_DIR/composer.json" 2>/dev/null && DETECTED_TECHNOLOGIES+=("Pest PHP")
  fi

  # Config files detection
  [[ -f "$PROJECT_DIR/tailwind.config.js" ]] || [[ -f "$PROJECT_DIR/tailwind.config.ts" ]] && DETECTED_TECHNOLOGIES+=("Tailwind CSS")
  [[ -f "$PROJECT_DIR/tsconfig.json" ]] && DETECTED_TECHNOLOGIES+=("TypeScript")
  [[ -f "$PROJECT_DIR/.eslintrc.js" ]] || [[ -f "$PROJECT_DIR/.eslintrc.json" ]] || [[ -f "$PROJECT_DIR/eslint.config.js" ]] && DETECTED_TECHNOLOGIES+=("ESLint")
  [[ -f "$PROJECT_DIR/.prettierrc" ]] || [[ -f "$PROJECT_DIR/prettier.config.js" ]] && DETECTED_TECHNOLOGIES+=("Prettier")
  [[ -f "$PROJECT_DIR/docker-compose.yml" ]] || [[ -f "$PROJECT_DIR/docker-compose.yaml" ]] && DETECTED_TECHNOLOGIES+=("Docker Compose")
  [[ -f "$PROJECT_DIR/Dockerfile" ]] && DETECTED_TECHNOLOGIES+=("Docker")
  [[ -d "$PROJECT_DIR/.ddev" ]] && DETECTED_TECHNOLOGIES+=("DDEV")
  [[ -f "$PROJECT_DIR/.github/workflows" ]] && DETECTED_TECHNOLOGIES+=("GitHub Actions")
  [[ -f "$PROJECT_DIR/.gitlab-ci.yml" ]] && DETECTED_TECHNOLOGIES+=("GitLab CI")

  # Database indicators
  [[ -f "$PROJECT_DIR/prisma/schema.prisma" ]] && DETECTED_TECHNOLOGIES+=("Prisma ORM")
  [[ -d "$PROJECT_DIR/migrations" ]] || [[ -d "$PROJECT_DIR/database/migrations" ]] && DETECTED_TECHNOLOGIES+=("Database Migrations")

  # Remove duplicates
  DETECTED_TECHNOLOGIES=($(echo "${DETECTED_TECHNOLOGIES[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
}

# ============================================================================
# Helper Functions
# ============================================================================

do_copy() {
  local src="$1"
  local dest="$2"
  if [[ "$DRY_RUN" == true ]]; then
    echo -e "  ${YELLOW}[DRY-RUN]${NC} cp -r $src → $dest"
  else
    cp -r "$src" "$dest"
    echo -e "  ${GREEN}✓${NC} Copied $(basename "$src")"
  fi
}

do_mkdir() {
  local dir="$1"
  if [[ "$DRY_RUN" == true ]]; then
    echo -e "  ${YELLOW}[DRY-RUN]${NC} mkdir -p $dir"
  else
    mkdir -p "$dir"
  fi
}

do_template() {
  local src="$1"
  local dest="$2"
  local dest_file=$(basename "$dest")
  if [[ "$DRY_RUN" == true ]]; then
    echo -e "  ${YELLOW}[DRY-RUN]${NC} Template $src → $dest"
    echo -e "           Substitutions: {{PROJECT_NAME}}=$PROJECT_NAME, {{PROJECT_SLUG}}=$PROJECT_SLUG"
  else
    sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
        -e "s/{{PROJECT_SLUG}}/$PROJECT_SLUG/g" \
        -e "s|{{PROJECT_PATH}}|${PROJECT_DIR}|g" \
        -e "s/{{DDEV_NAME}}/${DDEV_NAME:-$PROJECT_SLUG}/g" \
        -e "s/{{DDEV_DOCROOT}}/${DDEV_DOCROOT:-public}/g" \
        -e "s/{{DDEV_PHP}}/${DDEV_PHP:-8.1}/g" \
        -e "s/{{DDEV_DB_TYPE}}/${DDEV_DB_TYPE:-MariaDB}/g" \
        -e "s/{{DDEV_DB_VERSION}}/${DDEV_DB_VERSION:-10.11}/g" \
        -e "s/{{DDEV_TLD}}/${DDEV_TLD:-ddev.site}/g" \
        -e "s|{{DDEV_PRIMARY_URL}}|${DDEV_PRIMARY_URL:-https://${DDEV_NAME:-$PROJECT_SLUG}.ddev.site}|g" \
        -e "s/{{TEMPLATE_GROUP}}/${TEMPLATE_GROUP:-$PROJECT_SLUG}/g" \
        "$src" > "$dest"
    echo -e "  ${GREEN}✓${NC} Created $dest_file from template"
  fi
}

do_clean() {
  # Remove existing AI assistant configuration files
  local files_to_clean=(
    # Claude Code
    "$PROJECT_DIR/CLAUDE.md"
    "$PROJECT_DIR/.claude"
    # Gemini Code Assist
    "$PROJECT_DIR/GEMINI.md"
    "$PROJECT_DIR/.gemini"
    "$PROJECT_DIR/.geminiignore"
    # GitHub Copilot
    "$PROJECT_DIR/.github/copilot-instructions.md"
    # Cursor AI
    "$PROJECT_DIR/.cursorrules"
    "$PROJECT_DIR/.cursor"
    # Windsurf AI
    "$PROJECT_DIR/.windsurfrules"
    "$PROJECT_DIR/.windsurf"
    # OpenAI Codex
    "$PROJECT_DIR/AGENTS.md"
    # Aider
    "$PROJECT_DIR/CONVENTIONS.md"
  )

  echo -e "${CYAN}Cleaning existing configuration...${NC}"

  for item in "${files_to_clean[@]}"; do
    if [[ -e "$item" ]] || [[ -L "$item" ]]; then
      if [[ "$DRY_RUN" == true ]]; then
        echo -e "  ${YELLOW}[DRY-RUN]${NC} rm -rf $item"
      else
        rm -rf "$item"
        echo -e "  ${GREEN}✓${NC} Removed $(basename "$item")"
      fi
    fi
  done
  echo ""
}

# ============================================================================
# Main Execution
# ============================================================================

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  AI Coding Assistant Configuration Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Clean existing configuration if --clean flag is set (do this FIRST before scanning)
if [[ "$CLEAN" == true ]]; then
  do_clean
fi

# Run detection
echo -e "${CYAN}Scanning project...${NC}"
detect_ddev_config && echo -e "  ${GREEN}✓${NC} Found DDEV config" || echo -e "  ${YELLOW}○${NC} No DDEV config found"
detect_template_group
if [[ -n "$TEMPLATE_GROUP" ]]; then
  echo -e "  ${GREEN}✓${NC} Found template group: $TEMPLATE_GROUP"
else
  echo -e "  ${YELLOW}○${NC} No template group detected"
fi
detect_frontend_tools
[[ "$HAS_TAILWIND" == true ]] && echo -e "  ${GREEN}✓${NC} Tailwind CSS detected" || echo -e "  ${YELLOW}○${NC} No Tailwind detected"
[[ "$HAS_FOUNDATION" == true ]] && echo -e "  ${GREEN}✓${NC} Foundation framework detected" || echo -e "  ${YELLOW}○${NC} No Foundation detected"
[[ "$HAS_SCSS" == true ]] && echo -e "  ${GREEN}✓${NC} SCSS/Sass detected" || echo -e "  ${YELLOW}○${NC} No SCSS/Sass detected"
[[ "$HAS_ALPINE" == true ]] && echo -e "  ${GREEN}✓${NC} Alpine.js detected" || echo -e "  ${YELLOW}○${NC} No Alpine.js detected"
[[ "$HAS_VANILLA_JS" == true ]] && echo -e "  ${GREEN}✓${NC} Vanilla JS/HTML detected (no frameworks)" || true
[[ "$HAS_BILINGUAL" == true ]] && echo -e "  ${GREEN}✓${NC} Bilingual content detected" || echo -e "  ${YELLOW}○${NC} No bilingual patterns detected"
detect_addons
[[ "$HAS_STASH" == true ]] && echo -e "  ${GREEN}✓${NC} Stash add-on detected" || true
[[ "$HAS_STRUCTURE" == true ]] && echo -e "  ${GREEN}✓${NC} Structure add-on detected" || true
echo ""

echo -e "  Stack:       ${GREEN}$STACK${NC}"
echo -e "  Project:     ${GREEN}$PROJECT_DIR${NC}"
echo -e "  Name:        ${GREEN}$PROJECT_NAME${NC}"
echo -e "  Slug:        ${GREEN}$PROJECT_SLUG${NC}"
[[ -n "$DDEV_NAME" ]] && echo -e "  DDEV Name:   ${GREEN}$DDEV_NAME${NC}"
[[ -n "$DDEV_DOCROOT" ]] && echo -e "  Docroot:     ${GREEN}$DDEV_DOCROOT${NC}"
[[ -n "$DDEV_PHP" ]] && echo -e "  PHP:         ${GREEN}$DDEV_PHP${NC}"
[[ -n "$DDEV_DB_TYPE" ]] && echo -e "  Database:    ${GREEN}$DDEV_DB_TYPE $DDEV_DB_VERSION${NC}"
[[ -n "$DDEV_PRIMARY_URL" ]] && echo -e "  Primary URL: ${GREEN}$DDEV_PRIMARY_URL${NC}"
echo -e "  Dry Run:     ${YELLOW}$DRY_RUN${NC}"
echo -e "  Force:       ${YELLOW}$FORCE${NC}"
echo -e "  Clean:       ${YELLOW}$CLEAN${NC}"
echo -e "  Refresh:     ${YELLOW}$REFRESH${NC}"
[[ "$DISCOVER" == true ]] && echo -e "  Discover:    ${GREEN}true${NC}"
echo ""

# Discovery mode: Run comprehensive technology detection and generate analysis prompt
if [[ "$DISCOVER" == true ]]; then
  echo -e "${BLUE}Running discovery mode...${NC}"
  echo ""

  # Run comprehensive technology detection
  detect_all_technologies

  echo -e "${CYAN}Technologies detected:${NC}"
  if [[ ${#DETECTED_TECHNOLOGIES[@]} -gt 0 ]]; then
    for tech in "${DETECTED_TECHNOLOGIES[@]}"; do
      echo -e "  ${GREEN}✓${NC} $tech"
    done
  else
    echo -e "  ${YELLOW}○${NC} No specific technologies detected"
  fi
  echo ""
fi

# Refresh mode: only regenerate CLAUDE.md, skip everything else
if [[ "$REFRESH" == true ]]; then
  echo -e "${BLUE}Refreshing CLAUDE.md...${NC}"
  echo ""
  
  # Regenerate CLAUDE.md from template
  if [[ -f "$STACK_DIR/CLAUDE.md.template" ]]; then
    do_template "$STACK_DIR/CLAUDE.md.template" "$PROJECT_DIR/CLAUDE.md"
  elif [[ -f "$STACK_DIR/CLAUDE.md" ]]; then
    do_copy "$STACK_DIR/CLAUDE.md" "$PROJECT_DIR/"
  fi

  # Deploy MCP if requested (even in refresh mode)
  if [[ "$WITH_MCP" == true ]] && [[ -f "$STACK_DIR/.mcp.json" ]]; then
    echo ""
    echo -e "${CYAN}Deploying MCP configuration...${NC}"
    do_copy "$STACK_DIR/.mcp.json" "$PROJECT_DIR/"
  fi
  
  # Deploy Gemini if requested (even in refresh mode)
  if [[ "$WITH_GEMINI" == true ]] && [[ -d "$STACK_DIR/gemini" ]]; then
    echo ""
    echo -e "${CYAN}Refreshing Gemini Code Assist configuration...${NC}"
    
    # Create directories
    do_mkdir "$PROJECT_DIR/.gemini"
    do_mkdir "$PROJECT_DIR/.gemini/commands"
    
    # Copy static config files
    for file in config.yaml styleguide.md; do
      if [[ -f "$STACK_DIR/gemini/$file" ]]; then
        do_copy "$STACK_DIR/gemini/$file" "$PROJECT_DIR/.gemini/"
      fi
    done
    
    # Deploy settings.json from template
    if [[ -f "$STACK_DIR/gemini/settings.json.template" ]]; then
      do_template "$STACK_DIR/gemini/settings.json.template" "$PROJECT_DIR/.gemini/settings.json"
    fi
    
    # Deploy .geminiignore
    if [[ -f "$STACK_DIR/gemini/geminiignore.template" ]]; then
      do_copy "$STACK_DIR/gemini/geminiignore.template" "$PROJECT_DIR/.geminiignore"
    fi
    
    # Deploy custom commands
    if [[ -d "$STACK_DIR/gemini/commands" ]]; then
      for file in "$STACK_DIR/gemini/commands"/*.toml; do
        if [[ -e "$file" ]]; then
          do_copy "$file" "$PROJECT_DIR/.gemini/commands/"
        fi
      done
    fi
    
    # Generate GEMINI.md from template
    if [[ -f "$STACK_DIR/gemini/GEMINI.md.template" ]]; then
      do_template "$STACK_DIR/gemini/GEMINI.md.template" "$PROJECT_DIR/GEMINI.md"
    fi
  fi
  
  echo ""
  echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${GREEN}  CLAUDE.md refreshed successfully!${NC}"
  echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo -e "${CYAN}Updated values:${NC}"
  [[ -n "$DDEV_NAME" ]] && echo -e "  DDEV Name:   ${GREEN}$DDEV_NAME${NC}"
  [[ -n "$DDEV_DOCROOT" ]] && echo -e "  Docroot:     ${GREEN}$DDEV_DOCROOT${NC}"
  [[ -n "$DDEV_PHP" ]] && echo -e "  PHP:         ${GREEN}$DDEV_PHP${NC}"
  [[ -n "$DDEV_DB_TYPE" ]] && echo -e "  Database:    ${GREEN}$DDEV_DB_TYPE $DDEV_DB_VERSION${NC}"
  [[ -n "$DDEV_PRIMARY_URL" ]] && echo -e "  Primary URL: ${GREEN}$DDEV_PRIMARY_URL${NC}"
  [[ -n "$TEMPLATE_GROUP" ]] && echo -e "  Template:    ${GREEN}$TEMPLATE_GROUP${NC}"
  [[ "$HAS_TAILWIND" == true ]] && echo -e "  Tailwind:    ${GREEN}Yes${NC}"
  echo ""
  echo -e "${CYAN}Preserved:${NC}"
  echo -e "  .claude/agents/     (your customizations)"
  echo -e "  .claude/commands/   (your customizations)"
  echo -e "  .claude/rules/      (your customizations)"
  echo -e "  .claude/skills/     (your customizations)"
  echo -e "  .vscode/            (not modified)"
  if [[ "$WITH_MCP" == true ]]; then
    echo ""
    echo -e "${CYAN}MCP configuration deployed:${NC}"
    echo -e "  .mcp.json — EE MCP + Context7 servers"
    echo ""
    echo -e "${YELLOW}Note:${NC} Restart Claude Code to activate MCP tools"
  fi
  if [[ "$WITH_GEMINI" == true ]]; then
    echo ""
    echo -e "${CYAN}Gemini Code Assist configuration deployed:${NC}"
    echo -e "  GEMINI.md — Agent mode context file"
    echo -e "  .gemini/config.yaml — GitHub PR review settings"
    echo -e "  .gemini/styleguide.md — Code review style guide"
    echo -e "  .gemini/settings.json — MCP servers and settings"
    echo -e "  .gemini/commands/*.toml — Custom Gemini commands"
  fi
  exit 0
fi

# Check for existing configuration (skip if --clean or --force)
if [[ -d "$PROJECT_DIR/.claude" ]] && [[ "$FORCE" != true ]] && [[ "$CLEAN" != true ]] && [[ "$DRY_RUN" != true ]]; then
  echo -e "${YELLOW}Warning: .claude/ directory already exists in project${NC}"
  read -p "Overwrite? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
  fi
fi

echo -e "${BLUE}Deploying configuration...${NC}"
echo ""

# 1. Create .claude directory structure
do_mkdir "$PROJECT_DIR/.claude"

# 2. Copy agents with smart filtering
if [[ -d "$STACK_DIR/agents" ]]; then
  echo ""
  echo -e "${CYAN}Copying agents (conditional based on stack)...${NC}"
  do_mkdir "$PROJECT_DIR/.claude/agents"

  # Universal agents - ALWAYS copy these
  universal_agents=(
    "backend-architect.md"
    "frontend-architect.md"
    "devops-engineer.md"
    "security-expert.md"
    "performance-auditor.md"
    "data-migration-specialist.md"
    "server-admin.md"
    "code-quality-specialist.md"
  )

  for agent in "${universal_agents[@]}"; do
    if [[ -f "$STACK_DIR/agents/$agent" ]]; then
      do_copy "$STACK_DIR/agents/$agent" "$PROJECT_DIR/.claude/agents/"
    fi
  done

  # Stack-specific agents - conditional copy
  # Coilpack specialist
  if [[ "$STACK" == "coilpack" ]] && [[ -f "$STACK_DIR/agents/coilpack-specialist.md" ]]; then
    do_copy "$STACK_DIR/agents/coilpack-specialist.md" "$PROJECT_DIR/.claude/agents/"
  elif [[ "$STACK" != "coilpack" ]] && [[ -f "$STACK_DIR/agents/coilpack-specialist.md" ]]; then
    echo -e "  ${YELLOW}○${NC} Skipped coilpack-specialist.md (not coilpack stack)"
  fi

  # Craft CMS specialist
  if [[ "$STACK" == "craftcms" ]] && [[ -f "$STACK_DIR/agents/craftcms-specialist.md" ]]; then
    do_copy "$STACK_DIR/agents/craftcms-specialist.md" "$PROJECT_DIR/.claude/agents/"
  elif [[ "$STACK" != "craftcms" ]] && [[ -f "$STACK_DIR/agents/craftcms-specialist.md" ]]; then
    echo -e "  ${YELLOW}○${NC} Skipped craftcms-specialist.md (not craftcms stack)"
  fi

  # ExpressionEngine specialist (for expressionengine and coilpack)
  if [[ "$STACK" == "expressionengine" || "$STACK" == "coilpack" ]] && [[ -f "$STACK_DIR/agents/expressionengine-specialist.md" ]]; then
    do_copy "$STACK_DIR/agents/expressionengine-specialist.md" "$PROJECT_DIR/.claude/agents/"
  elif [[ "$STACK" != "expressionengine" && "$STACK" != "coilpack" ]] && [[ -f "$STACK_DIR/agents/expressionengine-specialist.md" ]]; then
    echo -e "  ${YELLOW}○${NC} Skipped expressionengine-specialist.md (not EE/coilpack stack)"
  fi

  # EE template expert (expressionengine only)
  if [[ "$STACK" == "expressionengine" ]] && [[ -f "$STACK_DIR/agents/ee-template-expert.md" ]]; then
    do_copy "$STACK_DIR/agents/ee-template-expert.md" "$PROJECT_DIR/.claude/agents/"
  elif [[ "$STACK" != "expressionengine" ]] && [[ -f "$STACK_DIR/agents/ee-template-expert.md" ]]; then
    echo -e "  ${YELLOW}○${NC} Skipped ee-template-expert.md (not expressionengine stack)"
  fi

  # Next.js specialist
  if [[ "$STACK" == "nextjs" ]] && [[ -f "$STACK_DIR/agents/nextjs-specialist.md" ]]; then
    do_copy "$STACK_DIR/agents/nextjs-specialist.md" "$PROJECT_DIR/.claude/agents/"
  elif [[ "$STACK" != "nextjs" ]] && [[ -f "$STACK_DIR/agents/nextjs-specialist.md" ]]; then
    echo -e "  ${YELLOW}○${NC} Skipped nextjs-specialist.md (not nextjs stack)"
  fi

  # React specialist (nextjs and docusaurus)
  if [[ "$STACK" == "nextjs" || "$STACK" == "docusaurus" ]] && [[ -f "$STACK_DIR/agents/react-specialist.md" ]]; then
    do_copy "$STACK_DIR/agents/react-specialist.md" "$PROJECT_DIR/.claude/agents/"
  elif [[ "$STACK" != "nextjs" && "$STACK" != "docusaurus" ]] && [[ -f "$STACK_DIR/agents/react-specialist.md" ]]; then
    echo -e "  ${YELLOW}○${NC} Skipped react-specialist.md (not React-based stack)"
  fi

  # WordPress specialist
  if [[ "$STACK" == "wordpress-roots" ]] && [[ -f "$STACK_DIR/agents/wordpress-specialist.md" ]]; then
    do_copy "$STACK_DIR/agents/wordpress-specialist.md" "$PROJECT_DIR/.claude/agents/"
  elif [[ "$STACK" != "wordpress-roots" ]] && [[ -f "$STACK_DIR/agents/wordpress-specialist.md" ]]; then
    echo -e "  ${YELLOW}○${NC} Skipped wordpress-specialist.md (not wordpress stack)"
  fi
fi

# 2b. Copy commands conditionally
if [[ -d "$STACK_DIR/commands" ]]; then
  echo ""
  echo -e "${CYAN}Copying commands (conditional based on detection)...${NC}"
  do_mkdir "$PROJECT_DIR/.claude/commands"

  # Core commands - ALWAYS copy if they exist
  for cmd in project-analyze.md project-discover.md sync-configs.md ddev-helper.md ee-template-scaffold.md ee-check-syntax.md craft-helper.md wordpress-helper.md nextjs-helper.md stash-optimize.md laravel-helper.md twig-helper.md livewire-component.md twig-scaffold.md docusaurus-helper.md; do
    if [[ -f "$STACK_DIR/commands/$cmd" ]]; then
      do_copy "$STACK_DIR/commands/$cmd" "$PROJECT_DIR/.claude/commands/"
    fi
  done

  # Conditional: Tailwind
  if [[ -f "$STACK_DIR/commands/tailwind-build.md" ]]; then
    if [[ "$HAS_TAILWIND" == "true" ]]; then
      do_copy "$STACK_DIR/commands/tailwind-build.md" "$PROJECT_DIR/.claude/commands/"
    else
      if [[ "$DRY_RUN" == true ]]; then
        echo -e "  ${YELLOW}[SKIP]${NC} tailwind-build.md (not detected)"
      else
        echo -e "  ${YELLOW}○${NC} Skipped tailwind-build.md (not detected)"
      fi
    fi
  fi

  # Conditional: Alpine.js
  if [[ -f "$STACK_DIR/commands/alpine-component-gen.md" ]]; then
    if [[ "$HAS_ALPINE" == "true" ]]; then
      do_copy "$STACK_DIR/commands/alpine-component-gen.md" "$PROJECT_DIR/.claude/commands/"
    else
      if [[ "$DRY_RUN" == true ]]; then
        echo -e "  ${YELLOW}[SKIP]${NC} alpine-component-gen.md (not detected)"
      else
        echo -e "  ${YELLOW}○${NC} Skipped alpine-component-gen.md (not detected)"
      fi
    fi
  fi
fi

# 2c. Copy skills conditionally
if [[ -d "$STACK_DIR/skills" ]]; then
  echo ""
  echo -e "${CYAN}Copying skills (conditional based on detection)...${NC}"
  do_mkdir "$PROJECT_DIR/.claude/skills"

  # Core skills - ALWAYS copy if they exist
  for skill in ee-stash-optimizer ee-template-assistant; do
    if [[ -d "$STACK_DIR/skills/$skill" ]]; then
      do_copy "$STACK_DIR/skills/$skill" "$PROJECT_DIR/.claude/skills/"
    fi
  done

  # Conditional: Tailwind
  if [[ -d "$STACK_DIR/skills/tailwind-utility-finder" ]]; then
    if [[ "$HAS_TAILWIND" == "true" ]]; then
      do_copy "$STACK_DIR/skills/tailwind-utility-finder" "$PROJECT_DIR/.claude/skills/"
    else
      if [[ "$DRY_RUN" == true ]]; then
        echo -e "  ${YELLOW}[SKIP]${NC} tailwind-utility-finder (not detected)"
      else
        echo -e "  ${YELLOW}○${NC} Skipped tailwind-utility-finder (not detected)"
      fi
    fi
  fi

  # Conditional: Alpine.js
  if [[ -d "$STACK_DIR/skills/alpine-component-builder" ]]; then
    if [[ "$HAS_ALPINE" == "true" ]]; then
      do_copy "$STACK_DIR/skills/alpine-component-builder" "$PROJECT_DIR/.claude/skills/"
    else
      if [[ "$DRY_RUN" == true ]]; then
        echo -e "  ${YELLOW}[SKIP]${NC} alpine-component-builder (not detected)"
      else
        echo -e "  ${YELLOW}○${NC} Skipped alpine-component-builder (not detected)"
      fi
    fi
  fi
fi

# 2d. Copy rules conditionally based on detection
if [[ -d "$STACK_DIR/rules" ]]; then
  echo ""
  echo -e "${CYAN}Copying rules (conditional based on detection)...${NC}"
  do_mkdir "$PROJECT_DIR/.claude/rules"

  # Core rules - ALWAYS copy if they exist
  for rule in accessibility.md performance.md; do
    if [[ -f "$STACK_DIR/rules/$rule" ]]; then
      do_copy "$STACK_DIR/rules/$rule" "$PROJECT_DIR/.claude/rules/"
    fi
  done

  # Stack-specific rules - ALWAYS copy if they exist
  for rule in expressionengine-templates.md craft-templates.md blade-templates.md nextjs-patterns.md laravel-patterns.md markdown-content.md mcp-workflow.md; do
    if [[ -f "$STACK_DIR/rules/$rule" ]]; then
      do_copy "$STACK_DIR/rules/$rule" "$PROJECT_DIR/.claude/rules/"
    fi
  done

  # Conditional: Tailwind
  if [[ -f "$STACK_DIR/rules/tailwind-css.md" ]]; then
    if [[ "$HAS_TAILWIND" == "true" ]]; then
      do_copy "$STACK_DIR/rules/tailwind-css.md" "$PROJECT_DIR/.claude/rules/"
    else
      if [[ "$DRY_RUN" == true ]]; then
        echo -e "  ${YELLOW}[SKIP]${NC} tailwind-css.md (not detected)"
      else
        echo -e "  ${YELLOW}○${NC} Skipped tailwind-css.md (not detected)"
      fi
    fi
  fi

  # Conditional: Alpine.js
  if [[ -f "$STACK_DIR/rules/alpinejs.md" ]]; then
    if [[ "$HAS_ALPINE" == "true" ]]; then
      do_copy "$STACK_DIR/rules/alpinejs.md" "$PROJECT_DIR/.claude/rules/"
    else
      if [[ "$DRY_RUN" == true ]]; then
        echo -e "  ${YELLOW}[SKIP]${NC} alpinejs.md (not detected)"
      else
        echo -e "  ${YELLOW}○${NC} Skipped alpinejs.md (not detected)"
      fi
    fi
  fi

  # Conditional: Bilingual
  if [[ -f "$STACK_DIR/rules/bilingual-content.md" ]]; then
    if [[ "$HAS_BILINGUAL" == "true" ]]; then
      do_copy "$STACK_DIR/rules/bilingual-content.md" "$PROJECT_DIR/.claude/rules/"
    else
      if [[ "$DRY_RUN" == true ]]; then
        echo -e "  ${YELLOW}[SKIP]${NC} bilingual-content.md (not detected)"
      else
        echo -e "  ${YELLOW}○${NC} Skipped bilingual-content.md (not detected)"
      fi
    fi
  fi
fi

# 3. Copy settings.local.json
if [[ -f "$STACK_DIR/settings.local.json" ]]; then
  do_copy "$STACK_DIR/settings.local.json" "$PROJECT_DIR/.claude/"
fi

# 4. Copy VSCode settings (unless skipped)
if [[ "$SKIP_VSCODE" != true ]] && [[ -d "$STACK_DIR/.vscode" ]]; then
  echo ""
  echo -e "${CYAN}Copying VSCode settings...${NC}"
  
  # Check if .vscode exists and is not empty
  if [[ -d "$PROJECT_DIR/.vscode" ]] && [[ "$(ls -A "$PROJECT_DIR/.vscode" 2>/dev/null)" ]]; then
    if [[ "$FORCE" != true ]] && [[ "$DRY_RUN" != true ]]; then
      echo -e "${YELLOW}Warning: .vscode/ directory already has files${NC}"
      read -p "Merge/overwrite VSCode settings? (y/N) " -n 1 -r
      echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "  ${YELLOW}○${NC} Skipped VSCode settings"
      else
        do_mkdir "$PROJECT_DIR/.vscode"
        for file in "$STACK_DIR/.vscode"/*; do
          if [[ -e "$file" ]]; then
            do_copy "$file" "$PROJECT_DIR/.vscode/"
          fi
        done
      fi
    else
      do_mkdir "$PROJECT_DIR/.vscode"
      for file in "$STACK_DIR/.vscode"/*; do
        if [[ -e "$file" ]]; then
          do_copy "$file" "$PROJECT_DIR/.vscode/"
        fi
      done
    fi
  else
    do_mkdir "$PROJECT_DIR/.vscode"
    for file in "$STACK_DIR/.vscode"/*; do
      if [[ -e "$file" ]]; then
        do_copy "$file" "$PROJECT_DIR/.vscode/"
      fi
    done
  fi
fi

# 5. Copy MCP configuration (if requested)
if [[ "$WITH_MCP" == true ]] && [[ -f "$STACK_DIR/.mcp.json" ]]; then
  echo ""
  echo -e "${CYAN}Deploying MCP configuration...${NC}"
  
  if [[ -f "$PROJECT_DIR/.mcp.json" ]] && [[ "$FORCE" != true ]]; then
    echo -e "${YELLOW}Warning: .mcp.json already exists${NC}"
    read -p "Overwrite? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      do_copy "$STACK_DIR/.mcp.json" "$PROJECT_DIR/"
    else
      echo -e "  ${YELLOW}○${NC} Skipped .mcp.json"
    fi
  else
    do_copy "$STACK_DIR/.mcp.json" "$PROJECT_DIR/"
  fi
fi

# 6. Deploy Gemini Code Assist configuration (if requested)
if [[ "$WITH_GEMINI" == true ]] && [[ -d "$STACK_DIR/gemini" ]]; then
  echo ""
  echo -e "${CYAN}Deploying Gemini Code Assist configuration...${NC}"
  
  # Create .gemini directory structure
  do_mkdir "$PROJECT_DIR/.gemini"
  do_mkdir "$PROJECT_DIR/.gemini/commands"
  
  # Copy static config files
  for file in config.yaml styleguide.md; do
    if [[ -f "$STACK_DIR/gemini/$file" ]]; then
      do_copy "$STACK_DIR/gemini/$file" "$PROJECT_DIR/.gemini/"
    fi
  done
  
  # Deploy settings.json from template (handles MCP config)
  if [[ -f "$STACK_DIR/gemini/settings.json.template" ]]; then
    do_template "$STACK_DIR/gemini/settings.json.template" "$PROJECT_DIR/.gemini/settings.json"
  elif [[ -f "$STACK_DIR/gemini/settings.json" ]]; then
    do_copy "$STACK_DIR/gemini/settings.json" "$PROJECT_DIR/.gemini/"
  fi
  
  # Deploy .geminiignore
  if [[ -f "$STACK_DIR/gemini/geminiignore.template" ]]; then
    do_copy "$STACK_DIR/gemini/geminiignore.template" "$PROJECT_DIR/.geminiignore"
  fi
  
  # Deploy custom commands (TOML format)
  if [[ -d "$STACK_DIR/gemini/commands" ]]; then
    for file in "$STACK_DIR/gemini/commands"/*.toml; do
      if [[ -e "$file" ]]; then
        do_copy "$file" "$PROJECT_DIR/.gemini/commands/"
      fi
    done
  fi
  
  # Generate GEMINI.md from template
  if [[ -f "$STACK_DIR/gemini/GEMINI.md.template" ]]; then
    do_template "$STACK_DIR/gemini/GEMINI.md.template" "$PROJECT_DIR/GEMINI.md"
  fi
fi

# 6b. Deploy GitHub Copilot configuration (if requested)
if [[ "$WITH_COPILOT" == true ]]; then
  echo ""
  echo -e "${CYAN}Deploying GitHub Copilot configuration...${NC}"

  # Create .github directory
  do_mkdir "$PROJECT_DIR/.github"

  # Deploy copilot-instructions.md from template
  if [[ -f "$STACK_DIR/copilot/copilot-instructions.md.template" ]]; then
    do_template "$STACK_DIR/copilot/copilot-instructions.md.template" "$PROJECT_DIR/.github/copilot-instructions.md"
  elif [[ -f "$STACK_DIR/copilot/copilot-instructions.md" ]]; then
    do_copy "$STACK_DIR/copilot/copilot-instructions.md" "$PROJECT_DIR/.github/"
  else
    echo -e "  ${YELLOW}○${NC} No Copilot template found for this stack"
  fi
fi

# 6c. Deploy Cursor AI configuration (if requested)
if [[ "$WITH_CURSOR" == true ]]; then
  echo ""
  echo -e "${CYAN}Deploying Cursor AI configuration...${NC}"

  # Deploy .cursorrules from template
  if [[ -f "$STACK_DIR/cursor/cursorrules.template" ]]; then
    do_template "$STACK_DIR/cursor/cursorrules.template" "$PROJECT_DIR/.cursorrules"
  elif [[ -f "$STACK_DIR/cursor/cursorrules" ]]; then
    do_copy "$STACK_DIR/cursor/cursorrules" "$PROJECT_DIR/.cursorrules"
  else
    echo -e "  ${YELLOW}○${NC} No Cursor template found for this stack"
  fi
fi

# 6d. Deploy Windsurf AI configuration (if requested)
if [[ "$WITH_WINDSURF" == true ]]; then
  echo ""
  echo -e "${CYAN}Deploying Windsurf AI configuration...${NC}"

  # Deploy .windsurfrules from template
  if [[ -f "$STACK_DIR/windsurf/windsurfrules.template" ]]; then
    do_template "$STACK_DIR/windsurf/windsurfrules.template" "$PROJECT_DIR/.windsurfrules"
  elif [[ -f "$STACK_DIR/windsurf/windsurfrules" ]]; then
    do_copy "$STACK_DIR/windsurf/windsurfrules" "$PROJECT_DIR/.windsurfrules"
  else
    echo -e "  ${YELLOW}○${NC} No Windsurf template found for this stack"
  fi
fi

# 6e. Deploy OpenAI Codex configuration (if requested)
if [[ "$WITH_CODEX" == true ]]; then
  echo ""
  echo -e "${CYAN}Deploying OpenAI Codex configuration...${NC}"

  # Deploy AGENTS.md from template
  if [[ -f "$STACK_DIR/openai/AGENTS.md.template" ]]; then
    do_template "$STACK_DIR/openai/AGENTS.md.template" "$PROJECT_DIR/AGENTS.md"
  elif [[ -f "$STACK_DIR/openai/AGENTS.md" ]]; then
    do_copy "$STACK_DIR/openai/AGENTS.md" "$PROJECT_DIR/"
  else
    echo -e "  ${YELLOW}○${NC} No Codex template found for this stack"
  fi
fi

# 6f. Deploy Aider configuration (if requested)
if [[ "$WITH_AIDER" == true ]]; then
  echo ""
  echo -e "${CYAN}Deploying Aider configuration...${NC}"

  # Deploy CONVENTIONS.md from template
  if [[ -f "$STACK_DIR/aider/CONVENTIONS.md.template" ]]; then
    do_template "$STACK_DIR/aider/CONVENTIONS.md.template" "$PROJECT_DIR/CONVENTIONS.md"
  elif [[ -f "$STACK_DIR/aider/CONVENTIONS.md" ]]; then
    do_copy "$STACK_DIR/aider/CONVENTIONS.md" "$PROJECT_DIR/"
  else
    echo -e "  ${YELLOW}○${NC} No Aider template found for this stack"
  fi
fi

# 7. Create CLAUDE.md from template
echo ""
echo -e "${CYAN}Deploying Claude Code main configuration...${NC}"
if [[ -f "$STACK_DIR/CLAUDE.md.template" ]]; then
  do_template "$STACK_DIR/CLAUDE.md.template" "$PROJECT_DIR/CLAUDE.md"
elif [[ -f "$STACK_DIR/CLAUDE.md" ]]; then
  do_copy "$STACK_DIR/CLAUDE.md" "$PROJECT_DIR/"
fi

# 8. Generate analysis prompt if requested
if [[ "$ANALYZE" == true ]] && [[ "$DRY_RUN" != true ]]; then
  echo ""
  echo -e "${CYAN}Generating analysis prompt...${NC}"
  
  cat > "$PROJECT_DIR/.claude/ANALYZE_PROJECT.md" << 'ANALYSIS_EOF'
# Project Analysis Request

Please run the `/project-analyze` command to scan this project and customize the configuration.

## What to Analyze

1. **DDEV Configuration** (`.ddev/config.yaml`)
   - Verify project name, URLs, PHP version
   - Check database type and version
   - Note any custom configuration

2. **Template Structure** (`system/user/templates/`)
   - Identify template group name
   - Document layout and partial organization
   - Check for bilingual patterns

3. **Frontend Build** (`public/` or project root)
   - Find `package.json` and document npm scripts
   - Check Tailwind config for brand colors
   - Note build tool (PostCSS, Vite, Webpack, etc.)

4. **Add-ons** (`system/user/addons/`)
   - List installed add-ons
   - Note any custom add-ons

5. **Update Configuration**
   - Customize CLAUDE.md with detected values
   - Update brand colors in Tailwind rules
   - Adjust commands for this project's paths

## After Analysis

Update these files with project-specific information:
- `CLAUDE.md` - Project overview, URLs, commands
- `.claude/rules/tailwind-css.md` - Brand colors
- `.claude/skills/tailwind-utility-finder/BRAND_COLORS.md` - Color reference
ANALYSIS_EOF

  echo -e "  ${GREEN}✓${NC} Created .claude/ANALYZE_PROJECT.md"
fi

# 9. Generate discovery prompt if in discovery mode
if [[ "$DISCOVER" == true ]] && [[ "$DRY_RUN" != true ]]; then
  echo ""
  echo -e "${CYAN}Generating discovery analysis prompt...${NC}"

  # Build technology list for the prompt
  TECH_LIST=""
  if [[ ${#DETECTED_TECHNOLOGIES[@]} -gt 0 ]]; then
    for tech in "${DETECTED_TECHNOLOGIES[@]}"; do
      TECH_LIST="${TECH_LIST}- ${tech}\n"
    done
  fi

  cat > "$PROJECT_DIR/.claude/DISCOVERY_PROMPT.md" << DISCOVERY_EOF
# Project Discovery Analysis

This project was set up using **discovery mode**. Claude (or another AI assistant) should analyze this codebase and generate comprehensive configuration.

## Detected Technologies

The setup script detected the following technologies:

${TECH_LIST:-"- No specific technologies detected - manual analysis required"}

## Your Task

Run the \`/project-discover\` command (or follow these steps manually):

### 1. Analyze the Codebase

Scan the project to understand:
- Directory structure and organization
- Primary programming language(s) and frameworks
- Build tools and package managers
- Testing setup and conventions
- Code quality tools (linters, formatters)

### 2. Research Best Practices

For each detected technology, research:
- Official coding standards and style guides
- Security best practices
- Performance optimization techniques
- Testing strategies

### 3. Generate Configuration

Create or update:

**CLAUDE.md** - Update with:
- Accurate project overview
- Complete directory structure
- All development commands
- Framework-specific patterns

**.claude/rules/** - Create rules for:
- Framework-specific patterns
- Language coding standards
- Security requirements
- Testing guidelines

**.claude/agents/** - Create specialists for:
- Backend development (if applicable)
- Frontend development (if applicable)
- Testing and QA
- Security review

### 4. Update Other AI Configs

If other AI assistants were deployed, update:
- \`.github/copilot-instructions.md\`
- \`.cursorrules\`
- \`.windsurfrules\`
- \`AGENTS.md\`
- \`CONVENTIONS.md\`
- \`GEMINI.md\`

## Project Information

- **Name**: ${PROJECT_NAME}
- **Path**: ${PROJECT_DIR}
- **Stack**: ${STACK} (custom/discovery mode)

## After Discovery

Once complete, delete this file and commit the generated configuration.
DISCOVERY_EOF

  echo -e "  ${GREEN}✓${NC} Created .claude/DISCOVERY_PROMPT.md"
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if [[ "$DRY_RUN" == true ]]; then
  echo -e "${YELLOW}  Dry run complete. No changes made.${NC}"
else
  echo -e "${GREEN}  Configuration deployed successfully!${NC}"
fi
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Adjust next steps based on mode
if [[ "$DISCOVER" == true ]]; then
  echo -e "${CYAN}Discovery Mode - Next steps:${NC}"
  echo "  1. Open the project in Claude Code (or your AI assistant)"
  echo "  2. Run: /project-discover"
  echo "     This will analyze your codebase and generate custom configuration"
  echo ""
  echo "  The AI will:"
  echo "  - Analyze your project structure and technologies"
  echo "  - Research best practices for your stack"
  echo "  - Generate rules, agents, and documentation"
  echo "  - Update all AI assistant configuration files"
else
  echo -e "${CYAN}Next steps:${NC}"
  echo "  1. Open the project in Claude Code"
  echo "  2. Run: /project-analyze"
  echo "     This will scan the codebase and customize the configuration"
fi
echo ""
echo "  Or manually review and customize:"
echo "  - CLAUDE.md — Project overview and commands"
echo "  - .claude/rules/ — Project-specific constraints"
echo "  - .claude/agents/ — Custom agent personas"
echo ""
if [[ "$SKIP_VSCODE" != true ]]; then
  echo -e "${CYAN}VSCode settings deployed:${NC}"
  echo "  - .vscode/settings.json — Editor + Emmet config"
  echo "  - .vscode/extensions.json — Recommended extensions"
  echo "  - .vscode/launch.json — Xdebug configuration"
  echo "  - .vscode/tasks.json — DDEV Xdebug tasks"
  echo "  - .vscode/tailwind.json — Tailwind CSS IntelliSense"
  echo ""
  if [[ "$INSTALL_EXTENSIONS" != true ]]; then
    echo -e "${YELLOW}Tip:${NC} Use --install-extensions to auto-install recommended extensions"
    echo ""
  fi
fi
if [[ "$WITH_MCP" == true ]]; then
  echo -e "${CYAN}MCP configuration deployed:${NC}"
  echo "  - .mcp.json — ExpressionEngine MCP server config"
  echo "  - .claude/rules/mcp-workflow.md — MCP usage rules"
  echo ""
  echo -e "${YELLOW}Note:${NC} Restart Claude Code to activate MCP tools"
  echo ""
fi
if [[ "$WITH_GEMINI" == true ]]; then
  echo -e "${CYAN}Gemini Code Assist configuration deployed:${NC}"
  echo "  - GEMINI.md — Agent mode context file"
  echo "  - .gemini/config.yaml — GitHub PR review settings"
  echo "  - .gemini/styleguide.md — Code review style guide"
  echo "  - .gemini/settings.json — MCP servers and settings"
  echo "  - .gemini/commands/*.toml — Custom Gemini commands"
  echo "  - .geminiignore — File exclusion patterns"
  echo ""
fi
if [[ "$WITH_COPILOT" == true ]]; then
  echo -e "${CYAN}GitHub Copilot configuration deployed:${NC}"
  echo "  - .github/copilot-instructions.md — Custom instructions"
  echo ""
fi
if [[ "$WITH_CURSOR" == true ]]; then
  echo -e "${CYAN}Cursor AI configuration deployed:${NC}"
  echo "  - .cursorrules — Project rules for Cursor"
  echo ""
fi
if [[ "$WITH_WINDSURF" == true ]]; then
  echo -e "${CYAN}Windsurf AI configuration deployed:${NC}"
  echo "  - .windsurfrules — Project rules for Windsurf"
  echo ""
fi
if [[ "$WITH_CODEX" == true ]]; then
  echo -e "${CYAN}OpenAI Codex configuration deployed:${NC}"
  echo "  - AGENTS.md — Agent instructions for Codex"
  echo ""
fi
if [[ "$WITH_AIDER" == true ]]; then
  echo -e "${CYAN}Aider configuration deployed:${NC}"
  echo "  - CONVENTIONS.md — Coding conventions for Aider"
  echo ""
fi
if [[ "$INSTALL_EXTENSIONS" == true ]] && [[ "$SKIP_VSCODE" != true ]] && [[ "$DRY_RUN" != true ]]; then
  echo -e "${CYAN}Installing VSCode extensions...${NC}"
  echo ""
  if "$SCRIPT_DIR/install-vscode-extensions.sh" "$PROJECT_DIR"; then
    echo ""
  else
    echo -e "${YELLOW}Note: Extension installation requires 'code' command${NC}"
    echo "To install manually: Open VSCode → Extensions → Install recommendations"
    echo ""
  fi
fi

echo -e "${CYAN}Gitignore reminder:${NC}"
echo "  Ensure .gitignore includes:"
echo "    CLAUDE.md"
echo "    .claude/"
if [[ "$WITH_GEMINI" == true ]]; then
  echo "    GEMINI.md"
  echo "    .gemini/"
  echo "    .geminiignore"
fi
if [[ "$WITH_COPILOT" == true ]]; then
  echo "    .github/copilot-instructions.md"
fi
if [[ "$WITH_CURSOR" == true ]]; then
  echo "    .cursorrules"
  echo "    .cursor/"
fi
if [[ "$WITH_WINDSURF" == true ]]; then
  echo "    .windsurfrules"
  echo "    .windsurf/"
fi
if [[ "$WITH_CODEX" == true ]]; then
  echo "    AGENTS.md"
fi
if [[ "$WITH_AIDER" == true ]]; then
  echo "    CONVENTIONS.md"
fi
echo ""
