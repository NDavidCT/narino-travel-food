# Chrome optimizado para desarrollo Flutter
# Uso: .\chrome_dev.ps1 [URL]

$url = if ($args[0]) { $args[0] } else { "http://localhost:4444" }
$chromeArgs = @(
    "--user-data-dir=C:\temp\chrome-flutter-dev"
    "--disable-web-security"
    "--disable-features=VizDisplayCompositor"
    "--allow-running-insecure-content"
    "--disable-popup-blocking"
    "--disable-background-timer-throttling"
    "--disable-backgrounding-occluded-windows"
    "--disable-renderer-backgrounding"
    "--disable-field-trial-config"
    "--disable-ipc-flooding-protection"
    "--autoplay-policy=no-user-gesture-required"
    "--enable-precise-memory-info"
    "--enable-features=NetworkService,NetworkServiceLogging"
    "$url"
)

Write-Host "ðŸŒ Lanzando Chrome optimizado para Flutter..." -ForegroundColor Green
Write-Host "URL: $url" -ForegroundColor Yellow

Start-Process -FilePath "" -ArgumentList $chromeArgs
