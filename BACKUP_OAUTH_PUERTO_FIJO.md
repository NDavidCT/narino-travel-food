# 🔐 BACKUP CONFIGURACIÓN OAUTH PUERTO FIJO
*Fecha: 19 de octubre de 2025*

## 📋 CONFIGURACIÓN QUE FUNCIONA (PUERTO FIJO 8080)

### 🎯 Google Cloud Console - OAuth 2.0 Client ID
```
Client ID: 187733989912-4tl32be27591kovqe935jir5kpmrduiv.apps.googleusercontent.com
```

### 🌐 Authorized JavaScript origins (FUNCIONANDO):
```
http://localhost:8080
http://127.0.0.1:8080
```

### 🔄 Authorized redirect URIs (FUNCIONANDO):
```
http://localhost:8080
```

### 🚀 Comando que funciona:
```bash
.\flutter_run_oauth_fixed.bat
# (Usa puerto fijo 8080)
```

### ✅ Estado: PROBADO Y FUNCIONANDO
- [x] Google Sign-In operativo
- [x] Sin errores redirect_uri_mismatch
- [x] Autenticación exitosa

## 🎯 OBJETIVO DEL EXPERIMENTO

Configurar para que funcione con:
```bash
flutter run
# (Con puertos aleatorios)
```

## 📝 NOTAS DE RESTAURACIÓN

Si el experimento no funciona, para volver a este estado:
1. Mantener solo `http://localhost:8080` en Google Console
2. Usar `.\flutter_run_oauth_fixed.bat`
3. Todo debería funcionar como antes