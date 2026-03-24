# Bootstrap Scripts

Bootstrap scripts to set up a new machine with chezmoi dotfiles.

## Usage

### 1. Install gh and authenticate

**Linux/macOS:**

```bash
curl -sfL https://raw.githubusercontent.com/fvarano/dev/main/bootstrap/prepare.sh | bash
gh auth login
```

**Windows:**

```powershell
irm https://raw.githubusercontent.com/fvarano/dev/main/bootstrap/prepare.ps1 | iex
gh auth login
```

### 2. Install chezmoi and deploy dotfiles

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply fvarano
```

## What it does

1. **prepare.sh / prepare.ps1** - Installs gh CLI
2. **apply.sh / apply.ps1** - Installs chezmoi and applies dotfiles

## Resources

- [chezmoi docs](https://www.chezmoi.io/)
- [My dotfiles repo](https://github.com/fvarano/dotfiles)
