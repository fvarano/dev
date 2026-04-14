#!/usr/bin/env bash
# Bootstrap script - installs chezmoi and applies dotfiles
# Requires gh to be installed and authenticated first

set -e

REPO="https://github.com/fvarano/dotfiles.git"

install_chezmoi() {
    if command -v chezmoi &>/dev/null; then
        echo "chezmoi already installed"
        return
    fi

    if command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm chezmoi
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y chezmoi
    elif command -v brew &>/dev/null; then
        brew install chezmoi
    else
        echo "Installing chezmoi via script..."
        sh -c "$(curl -fsLS get.chezmoi.io)"
    fi
}

check_gh_auth() {
    if ! command -v gh &>/dev/null; then
        echo "gh is not installed."
        echo "Run this first: curl -sfL https://raw.githubusercontent.com/fvarano/dotfiles/main/bootstrap/install-gh.sh | bash"
        exit 1
    fi

    if ! gh auth status &>/dev/null; then
        echo "gh is not authenticated."
        echo "Run this first: gh auth login"
        exit 1
    fi
}

main() {
    check_gh_auth

    echo "Installing chezmoi..."
    install_chezmoi

    echo "Initializing and applying dotfiles from $REPO..."
    chezmoi init --apply "$REPO"

    echo ""
    echo "Done!"
    echo "Restart your shell or source your shell config."
}

main "$@"
