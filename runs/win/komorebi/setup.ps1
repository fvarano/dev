# verify XDG_CONFIG_HOME is set
if (-not $env:XDG_CONFIG_HOME) {
    Write-Error "XDG_CONFIG_HOME is not set"
    exit 1
}

Write-Host "XDG_CONFIG_HOME is set to $env:XDG_CONFIG_HOME" -ForegroundColor Green

# permanently set KOMOREBI_CONFIG_HOME to %USERPROFILE%\.config
$env:KOMOREBI_CONFIG_HOME = "$env:XDG_CONFIG_HOME\komorebi"
[Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", $env:KOMOREBI_CONFIG_HOME, "User")

# create komorebi directory if it doesn't exist
if (-not (Test-Path $env:KOMOREBI_CONFIG_HOME)) {
    New-Item -ItemType Directory -Path $env:KOMOREBI_CONFIG_HOME
}

# copy env\.config\komorebi to XDG_CONFIG_HOME
Copy-Item -Path "$env:USERPROFILE\.config\komorebi" -Destination $env:XDG_CONFIG_HOME -Recurse -Force

# copy env\.config\whkd to XDG_CONFIG_HOME
Copy-Item -Path "$env:USERPROFILE\.config\whkd" -Destination $env:XDG_CONFIG_HOME -Recurse -Force

Write-Host "Komorebi setup complete!" -ForegroundColor Green

winget install LGUG2Z.komorebi
winget install LGUG2Z.whkd

Write-Host "Komorebi and whkd installed!" -ForegroundColor Green
