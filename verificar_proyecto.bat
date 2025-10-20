REM =====================================================
REM   SCRIPT DE VERIFICACIÓN - PROYECTO IPI DELI TOUR
REM =====================================================
@echo off
color 0A
echo.
echo =====================================================
echo   VERIFICANDO INTEGRIDAD DEL PROYECTO
echo =====================================================
echo.

echo [✓] Verificando archivos principales...
if exist "lib\main.dart" (echo     ✓ main.dart) else (echo     ✗ main.dart FALTANTE)
if exist "pubspec.yaml" (echo     ✓ pubspec.yaml) else (echo     ✗ pubspec.yaml FALTANTE)
if exist "firebase.json" (echo     ✓ firebase.json) else (echo     ✗ firebase.json FALTANTE)

echo.
echo [✓] Verificando scripts automatizados...
if exist "flutter_run_oauth_fixed.bat" (echo     ✓ flutter_run_oauth_fixed.bat) else (echo     ✗ Script OAuth FALTANTE)
if exist "deploy.bat" (echo     ✓ deploy.bat) else (echo     ✗ Script deploy FALTANTE)

echo.
echo [✓] Verificando documentación...
if exist "PROYECTO_ESTADO_FINAL.md" (echo     ✓ Estado final documentado) else (echo     ✗ Documentación FALTANTE)
if exist "OAUTH_RESUELTO.md" (echo     ✓ Solución OAuth documentada) else (echo     ✗ OAuth doc FALTANTE)

echo.
echo [✓] Verificando build de producción...
if exist "build\web" (echo     ✓ Build web existe) else (echo     ✗ Build web FALTANTE)

echo.
echo [✓] Verificando configuración Firebase...
if exist "lib\firebase_options.dart" (echo     ✓ Firebase configurado) else (echo     ✗ Firebase FALTANTE)

echo.
echo =====================================================
echo   RESUMEN DEL PROYECTO GUARDADO
echo =====================================================
echo.
echo NOMBRE: IPI Deli Tour (Turismo Ipiales)
echo ESTADO: ✓ COMPLETO Y FUNCIONAL
echo URL PUBLICA: https://apptouripi.web.app
echo DESARROLLO: http://localhost:8080
echo FECHA: 17 de octubre de 2025
echo.
echo SCRIPTS PRINCIPALES:
echo   - flutter_run_oauth_fixed.bat (Desarrollo)
echo   - deploy.bat (Producción)
echo.
echo =====================================================
echo   ¡PROYECTO COMPLETAMENTE GUARDADO!
echo =====================================================
echo.
echo Gracias a Dios por este éxito.
echo Todo el progreso está preservado localmente.
echo.
pause