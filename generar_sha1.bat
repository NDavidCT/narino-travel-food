@echo off
echo ================================================
echo    GENERAR SHA-1 FINGERPRINTS PARA ANDROID
echo ================================================
echo.
echo Este script genera las SHA-1 fingerprints necesarias
echo para configurar Google Sign-In en Firebase Console.
echo.
echo ================================================

echo.
echo 1. Generando SHA-1 con Gradle (RECOMENDADO)...
echo ================================================
cd android
echo Ejecutando: gradlew signingReport
call gradlew signingReport

echo.
echo ================================================
echo 2. Generando SHA-1 con Keytool (ALTERNATIVO)...
echo ================================================
echo Ejecutando keytool para debug keystore...

keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

echo.
echo ================================================
echo           PASOS SIGUIENTES
echo ================================================
echo.
echo 1. Copia las SHA-1 fingerprints de arriba
echo 2. Ve a Firebase Console: https://console.firebase.google.com
echo 3. Project Settings ^> General ^> Your apps ^> Android
echo 4. Agrega las SHA-1 fingerprints
echo 5. Descarga nuevo google-services.json
echo 6. Reemplaza android/app/google-services.json
echo.
echo ================================================
pause