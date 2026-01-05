#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        log_success "Running on macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        
        # Detect Linux distribution
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            DISTRO="$ID"
            VERSION="$VERSION_ID"
            log_success "Running on Linux: $PRETTY_NAME"
        else
            DISTRO="unknown"
            log_warning "Could not detect Linux distribution"
        fi
    else
        log_error "Unsupported operating system: $OSTYPE"
        log_error "This script supports macOS and Linux only"
        exit 1
    fi
}

# Install package manager and dependencies based on OS
install_dependencies() {
    if [[ "$OS" == "macos" ]]; then
        install_homebrew_macos
        install_ansible_macos
    else
        install_ansible_linux
    fi
}

# Install Homebrew (macOS only)
install_homebrew_macos() {
    if ! command -v brew &> /dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        
        log_success "Homebrew installed"
    else
        log_success "Homebrew already installed"
        brew update
    fi
}

# Install Ansible (macOS)
install_ansible_macos() {
    if ! command -v ansible-playbook &> /dev/null; then
        log_info "Installing Ansible via Homebrew..."
        brew install ansible
        log_success "Ansible installed"
    else
        log_success "Ansible already installed"
    fi
}

# Install Ansible (Linux)
install_ansible_linux() {
    if ! command -v ansible-playbook &> /dev/null; then
        log_info "Installing Ansible..."
        
        case "$DISTRO" in
            "ubuntu"|"debian")
                sudo apt update
                sudo apt install -y software-properties-common
                sudo add-apt-repository --yes --update ppa:ansible/ansible
                sudo apt install -y ansible
                ;;
            "fedora")
                sudo dnf install -y ansible
                ;;
            "centos"|"rhel")
                sudo yum install -y epel-release
                sudo yum install -y ansible
                ;;
            "arch"|"manjaro")
                sudo pacman -Sy --noconfirm ansible
                ;;
            *)
                log_warning "Unknown distribution: $DISTRO"
                log_info "Attempting to install via pip..."
                if command -v python3 &> /dev/null; then
                    python3 -m pip install --user ansible
                    export PATH="$HOME/.local/bin:$PATH"
                    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
                else
                    log_error "Could not install Ansible. Please install it manually."
                    exit 1
                fi
                ;;
        esac
        
        log_success "Ansible installed"
    else
        log_success "Ansible already installed"
    fi
}

# Get the directory of this script
get_script_dir() {
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do
        DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
}

# Run the Ansible playbook
run_ansible() {
    log_info "Running Ansible playbook..."
    cd "$SCRIPT_DIR"
    
    # Parse command line arguments for tags
    ANSIBLE_ARGS=""
    if [[ $# -gt 0 && -n "$1" ]]; then
        ANSIBLE_ARGS="--tags $1"
        log_info "Running with tags: $1"
    else
        log_info "Running with all tags"
    fi
    
    ansible-playbook playbook.yml $ANSIBLE_ARGS
    log_success "Ansible playbook completed"
}

# Display usage information
show_usage() {
    echo "Usage: $0 [tags]"
    echo
    echo "Examples:"
    echo "  $0                    # Run full bootstrap"
    if [[ "$OS" == "macos" ]]; then
        echo "  $0 homebrew          # Install only Homebrew packages"
        echo "  $0 macos             # Configure only macOS settings"
        echo "  $0 homebrew,dotfiles # Install Homebrew packages and dotfiles"
    else
        echo "  $0 packages          # Install only Linux packages"
        echo "  $0 packages,dotfiles # Install packages and dotfiles"
    fi
    echo "  $0 dotfiles          # Install only dotfiles"
    echo "  $0 vscode            # Install only VSCode extensions"
    echo
    if [[ "$OS" == "macos" ]]; then
        echo "Available tags: homebrew, dotfiles, macos, vscode"
    else
        echo "Available tags: packages, dotfiles, vscode"
    fi
}

# Main function
main() {
    echo "🚀 Cross-Platform System Bootstrap Script"
    echo "========================================="
    
    # Detect OS first
    detect_os
    
    # Show usage if help is requested
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        show_usage
        exit 0
    fi
    
    get_script_dir
    
    log_info "Starting system bootstrap process..."
    
    install_dependencies
    run_ansible "$1"
    
    echo
    log_success "🎉 Bootstrap complete!"
    echo
    echo "Next steps:"
    echo "1. Restart your terminal to apply shell changes"
    if [[ "$OS" == "macos" ]]; then
        echo "2. Some macOS settings may require a logout/login or restart"
    else
        echo "2. Some system settings may require a logout/login or restart"
    fi
    echo "3. VSCode extensions will be available next time you open VSCode"
    echo
    echo "To run specific parts later:"
    if [[ "$OS" == "macos" ]]; then
        echo "  ./bootstrap.sh homebrew    # Install packages"
        echo "  ./bootstrap.sh macos       # Configure system"
    else
        echo "  ./bootstrap.sh packages    # Install packages"
    fi
    echo "  ./bootstrap.sh dotfiles    # Install dotfiles"
    echo "  ./bootstrap.sh vscode      # Install extensions"
}

# Run main function with all arguments
main "$@"