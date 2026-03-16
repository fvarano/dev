# set XDG_CONFIG_HOME to %USERPROFILE%\.config 
$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
[Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", $env:XDG_CONFIG_HOME, "User")

# launch komorebi setup script
& "$PSScriptRoot\komorebi\setup.ps1"

# launch nushell setup script
& "$PSScriptRoot\nushell\setup.ps1"

# launch nushell setup script
& "$PSScriptRoot\alacritty\setup.ps1"
