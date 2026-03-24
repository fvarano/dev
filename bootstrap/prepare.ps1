#!/usr/bin/env pwsh
# Install gh CLI and delta on Windows
# Usage: irm https://raw.githubusercontent.com/fvarano/dev/main/bootstrap/prepare.ps1 | iex

$ErrorActionPreference = "Stop"

Write-Host "Installing gh..." -ForegroundColor Cyan

if (Get-Command gh -ErrorAction SilentlyContinue) {
    Write-Host "gh is already installed: $(gh --version)" -ForegroundColor Green
} else {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id GitHub.cli --accept-source-agreements --accept-package-agreements
    } elseif (Get-Command choco -ErrorAction SilentlyContinue) {
        choco install gh -y
    } elseif (Get-Command scoop -ErrorAction SilentlyContinue) {
        scoop install gh
    } else {
        Write-Host "Could not install gh automatically." -ForegroundColor Red
        Write-Host "Please install gh manually: https://github.com/cli/cli#installation" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "Installing delta..." -ForegroundColor Cyan

if (Get-Command delta -ErrorAction SilentlyContinue) {
    Write-Host "delta is already installed" -ForegroundColor Green
} else {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id dandavison.delta --accept-source-agreements --accept-package-agreements
    } elseif (Get-Command choco -ErrorAction SilentlyContinue) {
        choco install git-delta -y
    } elseif (Get-Command scoop -ErrorAction SilentlyContinue) {
        scoop install git-delta
    } else {
        Write-Host "Could not install delta automatically." -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Green
Write-Host ""
Write-Host "Next step: Authenticate with GitHub" -ForegroundColor Cyan
Write-Host "  gh auth login" -ForegroundColor Yellow
Write-Host ""
