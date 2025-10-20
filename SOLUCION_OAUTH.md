# 🔧 Solución OAuth - redirect_uri_mismatch

## ❌ Problema Identificado
**Error:** `redirect_uri_mismatch` - La aplicación intenta autenticar desde un puerto no autorizado.

**Causa:** `flutter run` usa puertos aleatorios, pero Google OAuth está configurado solo para `localhost:4444`.

## ✅ Soluciones

### Opción 1: Usar Puerto Fijo (RECOMENDADO)
```bash
flutter run -d chrome --web-port=4444 --web-hostname=localhost
```

### Opción 2: Usar Script Optimizado
```bash
.\quick_start.bat
```

### Opción 3: Actualizar quick_start.bat
El script debe incluir el puerto específico.

## 🔧 Configuración de Google Cloud Console

**Authorized JavaScript origins:**
- http://localhost:4444
- http://127.0.0.1:4444

**Authorized redirect URIs:**
- http://localhost:4444
- http://127.0.0.1:4444

## 🎯 Comando Correcto
**❌ No usar:** `flutter run -d chrome` (puerto aleatorio)
**✅ Usar:** `flutter run -d chrome --web-port=4444 --web-hostname=localhost`

## 📝 Script Actualizado
Voy a actualizar quick_start.bat para garantizar el puerto correcto.