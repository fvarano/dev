#!/usr/bin/env pwsh
# Bootstrap script - installs chezmoi and applies dotfiles
# Requires gh to be installed and authenticated first

$ErrorActionPreference = "Stop"

$Repo = "https://github.com/fvarano/dotfiles.git"

function Test-GhAuth {
    if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
        Write-Host "gh is not installed." -ForegroundColor Red
        Write-Host "Run this first: irm https://raw.githubusercontent.com/fvarano/dotfiles/main/bootstrap/install-gh.ps1 | iex" -ForegroundColor Yellow
        exit 1
    }

    if (-not (gh auth status 2>$null)) {
        Write-Host "gh is not authenticated." -ForegroundColor Red
        Write-Host "Run this first: gh auth login" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "Installing chezmoi..." -ForegroundColor Cyan

if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
    Write-Host "chezmoi already installed" -ForegroundColor Green
} elseif (Get-Command winget -ErrorAction SilentlyContinue) {
    winget install --id chezmoi.chezmoi --accept-source-agreements --accept-package-agreements
} elseif (Get-Command choco -ErrorAction SilentlyContinue) {
    choco install chezmoi -y
} elseif (Get-Command scoop -ErrorAction SilentlyContinue) {
    scoop install chezmoi
} else {
    Write-Host "No supported package manager found." -ForegroundColor Red
    Write-Host "Please install one of: winget, choco, or scoop" -ForegroundColor Yellow
    exit 1
}

Test-GhAuth

Write-Host "Initializing and applying dotfiles from $Repo..." -ForegroundColor Cyan
chezmoi init --apply $Repo

Write-Host ""
Write-Host "Done!" -ForegroundColor Green
Write-Host "Restart your shell." -ForegroundColor Cyan
