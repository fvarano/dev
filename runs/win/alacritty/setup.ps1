# verify XDG_CONFIG_HOME is set
if (-not $env:XDG_CONFIG_HOME) {
    Write-Error "XDG_CONFIG_HOME is not set"
    exit 1
}

Write-Host "XDG_CONFIG_HOME is set to $env:XDG_CONFIG_HOME" -ForegroundColor Green

# copy env\.config\alacritty to XDG_CONFIG_HOME
Copy-Item -Path "$env:USERPROFILE\.config\alacritty" -Destination $env:XDG_CONFIG_HOME -Recurse -Force

Write-Host "Alacritty setup complete!" -ForegroundColor Green