# run all scripts in runs/win
Get-ChildItem -Path "runs\win" -Filter "*.ps1" | ForEach-Object {
    Write-Host "Running $($_.Name)"
    & $_.FullName
}