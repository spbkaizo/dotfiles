# dotfiles

Cross-platform dotfiles and system configuration for macOS and Linux.

## Quick Start (Ansible - Recommended)

For a complete system bootstrap on **any supported OS**:

```bash
./bootstrap.sh
```

### What happens automatically:

**macOS:**
- Install Homebrew (if not present)
- Install Ansible via Homebrew
- Configure system preferences
- Install applications via Homebrew casks

**Linux (Ubuntu/Debian/Fedora/Arch):**
- Install Ansible via system package manager
- Install essential development packages
- Configure system appropriately for the distribution

**Both platforms:**
- Install and configure dotfiles
- Install VSCode and extensions
- Set up development environment

### Selective Installation

You can run specific parts using tags:

**macOS:**
```bash
./bootstrap.sh homebrew          # Install only Homebrew packages
./bootstrap.sh macos             # Configure only macOS settings
./bootstrap.sh homebrew,dotfiles # Multiple tags
```

**Linux:**
```bash
./bootstrap.sh packages          # Install only system packages
./bootstrap.sh packages,dotfiles # Install packages and dotfiles
```

**Cross-platform:**
```bash
./bootstrap.sh dotfiles          # Install only dotfiles
./bootstrap.sh vscode            # Install only VSCode extensions
```

### Manual Ansible Usage

If you prefer to run Ansible directly:

```bash
# Full playbook
ansible-playbook playbook.yml

# macOS-specific tags
ansible-playbook playbook.yml --tags homebrew
ansible-playbook playbook.yml --tags macos

# Linux-specific tags  
ansible-playbook playbook.yml --tags packages

# Cross-platform tags
ansible-playbook playbook.yml --tags dotfiles
ansible-playbook playbook.yml --tags vscode
```

## Legacy Installation (Make)

For traditional dotfiles-only installation:

```bash
make install
```

This copies dotfiles to the right place with proper permissions.

## What Gets Installed

### Dotfiles
- `.vimrc` - Vim configuration
- `.zshrc` - Zsh shell configuration
- `.zlogin` - Zsh login configuration
- `.tmux.conf` - Tmux configuration
- `.Xdefaults` - X11 defaults
- `.ssh/config` - SSH client configuration

### Package Management

**macOS (Homebrew):**
- Development tools (ansible, go, python, etc.)
- Media tools (ffmpeg, youtube-dl, etc.)
- Networking tools (nmap, wireshark, etc.)
- Security tools (gnupg, yubico tools, etc.)
- Applications (VSCode, Chrome, Signal, etc.)

**Linux (Distribution packages):**
- Essential system tools (curl, wget, git, etc.)
- Development tools (gcc, python, nodejs, docker, etc.)
- Media tools (ffmpeg, vlc, etc.) - optional
- Snap packages (code, postman, etc.) - optional

### System Configuration

**macOS:**
- Finder preferences (show hidden files, path bar, etc.)
- Dock preferences (auto-hide, tile size, etc.)
- Keyboard preferences (key repeat, disable autocorrect)
- Trackpad preferences (tap to click)
- Screenshot preferences

**Linux:**
- Package manager configuration
- Development environment setup
- Shell configuration

### VSCode Extensions (Cross-platform)
- Language support (Go, Python, YAML)
- Development tools (Ansible, Makefile Tools)
- Utilities (JSON prettify, Hugo support)
- Auto-installs VSCode if not present

## Requirements

**Supported Operating Systems:**
- macOS (tested on recent versions)
- Ubuntu/Debian (18.04+)
- Fedora (30+)
- CentOS/RHEL (7+)
- Arch Linux/Manjaro

**Prerequisites:**
- Internet connection
- Administrator/sudo privileges (for package installation)
- Bash shell

## Customization

Edit the following files to customize your setup:
- `ansible/inventory/hosts.yml` - Variables and feature flags
- `ansible/roles/*/tasks/main.yml` - Individual role configurations  
- `ansible/roles/*/vars/main.yml` - Package lists and settings
- `Brewfile` - Package list (still used as reference)

### Configuration Variables

Key variables in `ansible/inventory/hosts.yml`:
- `install_media_packages: true/false` - Install media tools (Linux)
- `install_snap_packages: true/false` - Install snap packages (Linux)
- `install_vscode_if_missing: true/false` - Auto-install VSCode
- `set_zsh_as_default: true/false` - Change default shell to zsh

## Supported Distributions

**Tested Linux distributions:**
- Ubuntu 20.04+, Debian 10+
- Fedora 35+
- CentOS 8+, RHEL 8+
- Arch Linux, Manjaro

**Package managers supported:**
- macOS: Homebrew
- Debian/Ubuntu: APT
- Fedora/CentOS/RHEL: DNF/YUM
- Arch/Manjaro: Pacman
