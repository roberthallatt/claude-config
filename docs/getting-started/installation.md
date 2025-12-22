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

## Make Setup Script Executable

```bash
chmod +x setup-project.sh
chmod +x install-vscode-extensions.sh
```

## Verify Installation

```bash
./setup-project.sh --help
```

You should see the usage documentation for the setup script.

## Optional: VSCode CLI

To enable automatic extension installation, install the VSCode CLI:

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
