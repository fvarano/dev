# verify XDG_CONFIG_HOME is set
if (-not $env:XDG_CONFIG_HOME) {
    Write-Error "XDG_CONFIG_HOME is not set"
    exit 1
}

Write-Host "XDG_CONFIG_HOME is set to $env:XDG_CONFIG_HOME" -ForegroundColor Green

# copy env\.config\alacritty to XDG_CONFIG_HOME
Copy-Item -Path ".\env\.config\alacritty" -Destination $env:XDG_CONFIG_HOME -Recurse -Force

$windows_alacritty_path = "$env:USERPROFILE\AppData\Roaming\alacritty"

# create alacritty directory if it doesn't exist
if (-not (Test-Path $windows_alacritty_path)) {
    New-Item -ItemType Directory -Path $windows_alacritty_path
}

# create a dummy alacritty.toml in $windows_alacritty_path that imports the Windows config
$content = "[general]`nimport = [`"~/.config/alacritty/alacritty-windows.toml`"]"
Set-Content -Path "$windows_alacritty_path\alacritty.toml" -Value $content

Write-Host "Alacritty setup complete!" -ForegroundColor Green