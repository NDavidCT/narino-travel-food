# 🌐 PLAN DE PUBLICACIÓN WEB GRATUITA

## 🎯 **FIREBASE HOSTING - 100% GRATIS**

### **✅ VENTAJAS:**
- ✅ **Costo**: $0 para siempre
- ✅ **SSL**: Automático (HTTPS)
- ✅ **Dominio**: `tu-app.web.app` o `tu-app.firebaseapp.com`
- ✅ **CDN**: Velocidad mundial
- ✅ **Ya tienes Firebase**: Configurado en tu proyecto

### **📋 PASOS PARA PUBLICAR:**

#### **1. Instalar Firebase CLI**
```bash
npm install -g firebase-tools
```

#### **2. Login en Firebase**
```bash
firebase login
```

#### **3. Inicializar proyecto**
```bash
firebase init hosting
```

#### **4. Compilar para web**
```bash
flutter build web
```

#### **5. Configurar firebase.json**
```json
{
  "hosting": {
    "public": "build/web",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [{
      "source": "**",
      "destination": "/index.html"
    }]
  }
}
```

#### **6. Desplegar**
```bash
firebase deploy
```

### **🌍 RESULTADO:**
- **URL pública**: `https://apptouripi.web.app`
- **Acceso mundial**: Cualquier persona puede usar tu app
- **Sin límites**: Tráfico ilimitado (plan gratuito generoso)

---

## 🔄 **PARA ANDROID (OPCIONAL - $25 USD)**

### **Google Play Store:**
1. **Generar APK firmado**
2. **Crear cuenta desarrollador** ($25 una sola vez)
3. **Subir a Play Store**
4. **Revisión**: 1-3 días
5. **Publicación mundial**

---

## 📊 **COMPARACIÓN RÁPIDA:**

| Plataforma | Costo | Tiempo | Audiencia |
|------------|-------|--------|-----------|
| **Web (Firebase)** | $0 | 30 min | Mundial ⭐ |
| **Android (Play)** | $25 | 3 días | Android |
| **iOS (App Store)** | $99/año | 7 días | iOS |

---

## 🎯 **RECOMENDACIÓN:**
**EMPEZAR CON WEB** (Firebase Hosting) - Es gratis e inmediato.
Después considerar Android si quieres estar en Play Store.
