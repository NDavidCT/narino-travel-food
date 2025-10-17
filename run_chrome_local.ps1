<#
Simple helper to run the Flutter web app on a fixed port.
Usage:
  .\run_chrome_local.ps1 -Port 59047
If you omit -Port the script will use 59047 by default.
#>
param(
    [int]$Port = 59047
)

Write-Host "Running flutter clean"
flutter clean

Write-Host "Starting flutter on Chrome with web-port=$Port"
flutter run -d chrome --web-port=$Port
