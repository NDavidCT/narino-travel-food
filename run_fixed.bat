@echo off
echo ===============================================
echo   SOLUCION OAUTH - Ipi Deli Tour
echo ===============================================
echo.
echo PROBLEMA IDENTIFICADO:
echo - redirect_uri_mismatch en Google OAuth
echo - flutter run usa puertos aleatorios
echo.
echo SOLUCION:
echo - Usar puerto fijo 3000
echo - Configurar Google Cloud Console
echo.
echo ===============================================
echo.
echo Matando procesos Chrome anteriores...
taskkill /F /IM chrome.exe 2>nul
echo.
echo Iniciando Flutter en puerto 3000...
cd /d "c:\Proyectos_Flutter\ipi_deli_tour"
flutter run -d chrome --web-port=3000 --web-hostname=localhost --verbose
echo.
echo ===============================================
echo   CONFIGURACION NECESARIA:
echo ===============================================
echo.
echo Ve a Google Cloud Console:
echo https://console.cloud.google.com/apis/credentials
echo.
echo Agrega estos origenes autorizados:
echo - http://localhost:3000
echo - http://127.0.0.1:3000
echo.
echo ===============================================
pause