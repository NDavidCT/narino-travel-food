@echo off
echo ===============================================
echo   DEPLOY NARIÑO TRAVEL & FOOD A FIREBASE
echo ===============================================
echo.
echo Construyendo aplicacion Flutter para web...
flutter build web --release
echo.
echo Desplegando a Firebase Hosting...
firebase deploy --only hosting --project apptouripi
echo.
echo ===============================================
echo   DEPLOY COMPLETADO
echo ===============================================
echo.
echo Tu app estara disponible en:
echo https://apptouripi.web.app
echo.
pause