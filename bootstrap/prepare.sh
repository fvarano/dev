#!/usr/bin/env bash
# Install gh CLI and delta
# Usage: curl -sfL https://raw.githubusercontent.com/fvarano/dev/main/bootstrap/prepare.sh | bash

set -e

install_gh() {
    if command -v gh &>/dev/null; then
        echo "gh is already installed: $(gh --version)"
        return
    fi

    echo "Installing gh..."

    if command -v apt-get &>/dev/null; then
        (type -p wget >/dev/null || sudo apt-get install -y wget)
        sudo mkdir -p -m 755 /etc/apt/keyrings
        local out=$(mktemp)
        wget -nv -O "$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg
        cat "$out" | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
        sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
        sudo mkdir -p -m 755 /etc/apt/sources.list.d
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt-get update && sudo apt-get install -y gh
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm github-cli
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y gh
    elif command -v brew &>/dev/null; then
        brew install gh
    else
        echo "Could not install gh automatically."
        echo "Please install gh manually: https://github.com/cli/cli#installation"
        exit 1
    fi
}

install_delta() {
    if command -v delta &>/dev/null; then
        echo "delta is already installed"
        return
    fi

    echo "Installing delta..."

    if command -v apt-get &>/dev/null; then
        (type -p wget >/dev/null || sudo apt-get install -y wget)
        wget https://github.com/dandavison/delta/releases/latest/download/delta-*-amd64.deb -O /tmp/delta.deb
        sudo dpkg -i /tmp/delta.deb
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm git-delta
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y git-delta
    elif command -v brew &>/dev/null; then
        brew install git-delta
    else
        echo "Could not install delta automatically."
        echo "Install manually or remove from chezmoi config."
    fi
}

install_gh
install_delta

echo ""
echo "Done!"
echo ""
echo "Next step: Authenticate with GitHub"
echo "  gh auth login"
echo ""
