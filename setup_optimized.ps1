# Script para optimizar el entorno de desarrollo
Write-Host "=== Configurando entorno de desarrollo optimizado para Ipi Deli Tour ===" -ForegroundColor Green

# 1. Configurar Chrome para desarrollo
Write-Host "1. Configurando Chrome para desarrollo..." -ForegroundColor Yellow

# Crear directorio temporal si no existe
if (!(Test-Path "C:\temp\chrome-dev-data")) {
    New-Item -Path "C:\temp\chrome-dev-data" -ItemType Directory -Force
    Write-Host "   ✓ Directorio temporal creado" -ForegroundColor Green
}

# 2. Configurar variables de entorno para Flutter Web
Write-Host "2. Configurando variables de entorno..." -ForegroundColor Yellow
$env:FLUTTER_WEB_AUTO_DETECT = "true"
Write-Host "   ✓ Variables configuradas" -ForegroundColor Green

# 3. Optimizar configuración de Flutter
Write-Host "3. Optimizando Flutter..." -ForegroundColor Yellow
flutter config --enable-web
flutter clean
flutter pub get
Write-Host "   ✓ Flutter optimizado" -ForegroundColor Green

# 4. Crear script de inicio rápido
Write-Host "4. Creando script de inicio rápido..." -ForegroundColor Yellow

$quickStartContent = @'
@echo off
echo === Iniciando Ipi Deli Tour en modo desarrollo ===
echo.
echo Configurando Chrome...
start chrome.exe --user-data-dir=C:\temp\chrome-dev-data --disable-web-security --disable-popup-blocking --allow-running-insecure-content
timeout /t 3 /nobreak > nul
echo.
echo Iniciando Flutter Web...
cd /d "c:\Proyectos_Flutter\ipi_deli_tour"
flutter run -d chrome --web-port=4444 --web-hostname=localhost
'@

$quickStartContent | Out-File -FilePath "quick_start.bat" -Encoding ASCII
Write-Host "   ✓ Script creado: quick_start.bat" -ForegroundColor Green

Write-Host @"

=== CONFIGURACIÓN COMPLETADA ===

Para usar el entorno optimizado:
1. Ejecutar: .\quick_start.bat
2. O manualmente con Chrome optimizado

Optimizaciones aplicadas:
✓ Chrome configurado para popups y CORS
✓ Variables de entorno optimizadas  
✓ Flutter Web habilitado y limpio
✓ Script de inicio rápido creado
✓ Puerto fijo (4444) para OAuth

"@ -ForegroundColor Green

Write-Host "¡Listo para desarrollo optimizado!" -ForegroundColor Magenta