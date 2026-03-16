# verify XDG_CONFIG_HOME is set
if (-not $env:XDG_CONFIG_HOME) {
    Write-Error "XDG_CONFIG_HOME is not set"
    exit 1
}

Write-Host "XDG_CONFIG_HOME is set to $env:XDG_CONFIG_HOME" -ForegroundColor Green

# copy env\.config\alacritty to XDG_CONFIG_HOME
Copy-Item -Path ".\env\.config\alacritty" -Destination $env:XDG_CONFIG_HOME -Recurse -Force

# create a dummy alacritty.toml in AppData\Roaming\alacritty that imports the Windows config
if (-not (Test-Path "$env:USERPROFILE\AppData\Roaming\alacritty\alacritty.toml")) {
    $content = "[general]\nimport = [\"~/.config/alacritty/alacritty-windows.toml\"]"
    Set-Content -Path "$env:USERPROFILE\AppData\Roaming\alacritty\alacritty.toml" -Value $content
}

Write-Host "Alacritty setup complete!" -ForegroundColor Green