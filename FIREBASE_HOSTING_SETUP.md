# 🌐 CONFIGURACIÓN FIREBASE HOSTING

## 🎯 PROCESO DE CONFIGURACIÓN

Tu proyecto ya tiene Firebase configurado. Para habilitar Hosting:

### 1️⃣ **CONFIGURACIÓN MANUAL**
Ejecuta en terminal:
```bash
firebase init hosting
```

**Respuestas recomendadas:**
- Ready to proceed? → **Y** (Yes)
- Select project → **Selecciona tu proyecto existente**
- Public directory → **build/web**
- Single-page app? → **Y** (Yes)
- Overwrite index.html? → **N** (No)

### 2️⃣ **BUILD Y DEPLOY**
```bash
# Build para producción
flutter build web --release

# Deploy a Firebase Hosting
firebase deploy --only hosting
```

### 3️⃣ **RESULTADO**
Tu app estará disponible en:
```
https://TU_PROYECTO_ID.firebaseapp.com
```

## 🔄 **FLUJO DIARIO DE ACTUALIZACIONES**

```bash
# 1. Hacer cambios en tu código
# 2. Build
flutter build web --release

# 3. Deploy
firebase deploy --only hosting

# ¡Listo! Cambios en vivo
```

## ⚡ **AUTOMATIZACIÓN CON SCRIPT**

Puedes crear un script `deploy.bat`:
```batch
@echo off
echo Building Flutter web...
flutter build web --release
echo Deploying to Firebase...
firebase deploy --only hosting
echo Deploy complete!
pause
```

## 🎯 **VENTAJAS PARA TU PROYECTO**

- ✅ **Gratis**: Hasta 10GB storage
- ✅ **Rápido**: CDN global
- ✅ **SSL**: HTTPS automático
- ✅ **Integración**: Usa tu Firebase existente
- ✅ **OAuth**: Funcionará perfectamente
- ✅ **Actualizaciones**: Deploy en segundos

## 📱 **URLs FINALES**

- **Desarrollo**: `http://localhost:8080` (local)
- **Producción**: `https://tu-proyecto.firebaseapp.com` (público)

**¡Tu app de turismo de Ipiales estará en vivo para que todos la vean!**