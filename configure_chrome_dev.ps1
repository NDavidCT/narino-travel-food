# Script para configurar Chrome automáticamente para desarrollo Flutter
# Ejecutar como: .\configure_chrome_dev.ps1

Write-Host "🚀 Configurando Chrome para desarrollo Flutter..." -ForegroundColor Green

# 1. Crear directorio para perfil de desarrollo
$chromeDevProfile = "C:\temp\chrome-flutter-dev"
if (-not (Test-Path $chromeDevProfile)) {
    New-Item -ItemType Directory -Path $chromeDevProfile -Force | Out-Null
    Write-Host "✓ Creado directorio de perfil: $chromeDevProfile" -ForegroundColor Yellow
}

# 2. Detectar Chrome instalado
$chromePaths = @(
    "${env:ProgramFiles}\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "${env:LOCALAPPDATA}\Google\Chrome\Application\chrome.exe"
)

$chromePath = $null
foreach ($path in $chromePaths) {
    if (Test-Path $path) {
        $chromePath = $path
        break
    }
}

if (-not $chromePath) {
    Write-Host "❌ Chrome no encontrado. Instala Chrome y vuelve a ejecutar este script." -ForegroundColor Red
    exit 1
}

Write-Host "✓ Chrome encontrado: $chromePath" -ForegroundColor Yellow

# 3. Crear script de lanzamiento optimizado
$launchScript = @"
# Chrome optimizado para desarrollo Flutter
# Uso: .\chrome_dev.ps1 [URL]

`$url = if (`$args[0]) { `$args[0] } else { "http://localhost:4444" }
`$chromeArgs = @(
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
    "`$url"
)

Write-Host "🌐 Lanzando Chrome optimizado para Flutter..." -ForegroundColor Green
Write-Host "URL: `$url" -ForegroundColor Yellow

Start-Process -FilePath "$chromePath" -ArgumentList `$chromeArgs
"@

$scriptPath = "chrome_dev.ps1"
Set-Content -Path $scriptPath -Value $launchScript -Encoding UTF8
Write-Host "✓ Script creado: $scriptPath" -ForegroundColor Yellow

# 4. Configurar política de ejecución temporal si es necesario
$currentPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ($currentPolicy -eq 'Restricted') {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Write-Host "✓ Política de ejecución configurada" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 Configuración completada!" -ForegroundColor Green
Write-Host ""
Write-Host "Uso:" -ForegroundColor Cyan
Write-Host "  Para ejecutar tu app Flutter:" -ForegroundColor White
Write-Host "    .\chrome_dev.ps1 http://localhost:4444" -ForegroundColor Gray
Write-Host ""
Write-Host "  Para desarrollo general:" -ForegroundColor White
Write-Host "    .\chrome_dev.ps1" -ForegroundColor Gray
Write-Host ""
Write-Host "Ventajas de este Chrome optimizado:" -ForegroundColor Cyan
Write-Host "  + Popups siempre permitidos" -ForegroundColor Green
Write-Host "  + Cookies permitidas en localhost" -ForegroundColor Green
Write-Host "  + CORS deshabilitado" -ForegroundColor Green
Write-Host "  + Sin throttling de background" -ForegroundColor Green
Write-Host "  + Autoplay habilitado" -ForegroundColor Green