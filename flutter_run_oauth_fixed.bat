@echo off
echo ===============================================
echo   NARINO TRAVEL AND FOOD - OAUTH CORRECTO
echo ===============================================
echo.
echo PROBLEMA DETECTADO:
echo - flutter run usa puertos aleatorios (64030, 56498, etc.)
echo - Google OAuth necesita puerto fijo
echo.
echo SOLUCION:
echo - Usar SIEMPRE puerto fijo 8080
echo.
echo ===============================================
echo.

:menu
echo Selecciona el navegador:
echo 1. Chrome
echo 2. Edge
echo 3. Salir
echo.
set /p choice="Ingresa tu opcion (1-3): "

if "%choice%"=="1" goto chrome
if "%choice%"=="2" goto edge
if "%choice%"=="3" goto exit
echo Opcion invalida. Intenta de nuevo.
goto menu

:chrome
echo.
echo Iniciando en Chrome con puerto fijo 8080...
flutter run -d chrome --web-port=8080 --web-hostname=localhost
goto menu

:edge
echo.
echo Iniciando en Edge con puerto fijo 8080...
flutter run -d edge --web-port=8080 --web-hostname=localhost
goto menu

:exit
echo.
echo ===============================================
echo RECORDATORIO:
echo - NUNCA uses "flutter run" sin especificar puerto
echo - SIEMPRE usa este script o especifica --web-port=8080
echo ===============================================
pause
exit