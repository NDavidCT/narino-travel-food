@echo off
echo === Iniciando Ipi Deli Tour en modo desarrollo ===
echo.
echo IMPORTANTE: Usando puerto fijo 4444 para OAuth
echo.
echo Configurando Chrome optimizado...
start chrome.exe --user-data-dir=C:\temp\chrome-dev-data --disable-web-security --disable-popup-blocking --allow-running-insecure-content
timeout /t 3 /nobreak > nul
echo.
echo Iniciando Flutter Web en puerto 4444...
cd /d "c:\Proyectos_Flutter\ipi_deli_tour"
flutter run -d chrome --web-port=4444 --web-hostname=localhost --debug