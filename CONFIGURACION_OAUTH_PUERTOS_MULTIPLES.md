# 🔧 CONFIGURACIÓN GOOGLE OAUTH - PUERTOS MÚLTIPLES
*Experimento: 19 de octubre de 2025*

## 🎯 OBJETIVO
Permitir que `flutter run` funcione con puertos aleatorios manteniendo Google OAuth operativo.

## 📋 CONFIGURACIÓN GOOGLE CLOUD CONSOLE

### 🌐 Authorized JavaScript origins (AGREGAR TODOS):
```
http://localhost:3000
http://localhost:4000
http://localhost:5000
http://localhost:8000
http://localhost:8080
http://localhost:8888
http://localhost:9000
http://127.0.0.1:3000
http://127.0.0.1:4000
http://127.0.0.1:5000
http://127.0.0.1:8000
http://127.0.0.1:8080
http://127.0.0.1:8888
http://127.0.0.1:9000
```

### 🔄 Authorized redirect URIs (AGREGAR TODOS):
```
http://localhost:3000
http://localhost:4000
http://localhost:5000
http://localhost:8000
http://localhost:8080
http://localhost:8888
http://localhost:9000
http://127.0.0.1:3000
http://127.0.0.1:4000
http://127.0.0.1:5000
http://127.0.0.1:8000
http://127.0.0.1:8080
http://127.0.0.1:8888
http://127.0.0.1:9000
```

## 🎯 RANGOS DE PUERTOS QUE USA FLUTTER

Según la documentación del proyecto, Flutter ha usado:
- 64030
- 56498
- 4444 (original)
- 8080 (actual)

### 🌐 PUERTOS ADICIONALES COMUNES:
```
http://localhost:50000
http://localhost:51000
http://localhost:52000
http://localhost:53000
http://localhost:54000
http://localhost:55000
http://localhost:56000
http://localhost:57000
http://localhost:58000
http://localhost:59000
http://localhost:60000
http://localhost:61000
http://localhost:62000
http://localhost:63000
http://localhost:64000
http://localhost:65000
```

## 🚀 INSTRUCCIONES PASO A PASO

### Paso 1: Ir a Google Cloud Console
```
https://console.cloud.google.com/apis/credentials
```

### Paso 2: Buscar OAuth Client ID
```
Client ID: 187733989912-4tl32be27591kovqe935jir5kpmrduiv.apps.googleusercontent.com
```

### Paso 3: Copiar todas las URLs de arriba
- Authorized JavaScript origins
- Authorized redirect URIs

### Paso 4: Probar
```bash
flutter run
```

## ✅ VENTAJAS DE ESTA CONFIGURACIÓN

1. **Flexibilidad total**: `flutter run` puede usar cualquier puerto
2. **Sin scripts necesarios**: Comando simple
3. **OAuth funcional**: Cubrimos rangos amplios de puertos
4. **Desarrollo eficiente**: Sin configuración manual cada vez

## 🔄 PLAN DE REVERSA

Si no funciona, volver a la configuración original:
- Solo `http://localhost:8080` en Google Console
- Usar `.\flutter_run_oauth_fixed.bat`

## 📝 NOTAS TÉCNICAS

- Flutter typically uses ports in ranges: 50000-65535
- OAuth validation is exact match only
- Multiple URLs are allowed in Google Console
- No performance impact on production