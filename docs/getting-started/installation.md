# Installation

## Prerequisites

- **Git** - Clone this repository
- **Bash** - Run the setup script (macOS/Linux/WSL)
- **VSCode** (optional) - For IDE integration and extension installation
- **DDEV** (optional) - For ExpressionEngine/Coilpack MCP servers

## Clone the Repository

```bash
git clone https://github.com/canadian-paediatric-society/claude-config-repo.git
cd claude-config-repo
```

## Make Scripts Executable

```bash
chmod +x setup-project.sh
chmod +x serve-docs.sh
```

## Verify Installation

```bash
./setup-project.sh --help
```

You should see the usage documentation for the setup script.

## Set Up Shell Aliases (Recommended)

Add global aliases to run commands from anywhere without specifying the full path.

### Determine Your Shell

```bash
echo $SHELL
```

This will show `/bin/bash`, `/bin/zsh`, or another shell.

### Add Aliases

Edit your shell configuration file:

| Shell | Configuration File |
|-------|-------------------|
| Zsh (macOS default) | `~/.zshrc` |
| Bash | `~/.bashrc` or `~/.bash_profile` |
| Fish | `~/.config/fish/config.fish` |

Add these lines to the appropriate file (update the path to match where you cloned the repository):

**For Zsh or Bash:**

```bash
# AI Config Repository aliases
export AI_CONFIG_REPO="$HOME/path/to/claude-config-repo"
alias ai-config="$AI_CONFIG_REPO/setup-project.sh"
alias ai-config-docs="$AI_CONFIG_REPO/serve-docs.sh"
```

**For Fish:**

```fish
# AI Config Repository aliases
set -gx AI_CONFIG_REPO "$HOME/path/to/claude-config-repo"
alias ai-config "$AI_CONFIG_REPO/setup-project.sh"
alias ai-config-docs "$AI_CONFIG_REPO/serve-docs.sh"
```

### Apply Changes

Reload your shell configuration:

```bash
# For Zsh
source ~/.zshrc

# For Bash
source ~/.bashrc

# For Fish
source ~/.config/fish/config.fish
```

Or simply open a new terminal window.

### Verify Aliases

```bash
ai-config --help
ai-config-docs
```

The first command should show the setup script help. The second should start the documentation server at http://localhost:8000.

## Optional: VSCode CLI

To enable automatic extension installation with `--install-extensions`, install the VSCode CLI:

1. Open VSCode
2. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
3. Type "Shell Command: Install 'code' command in PATH"
4. Select it to install

Verify:
```bash
code --version
```

## Next Steps

- **[Quick Start](quick-start.md)** - Deploy your first configuration
- **[Configuration](configuration.md)** - Understand what gets deployed
