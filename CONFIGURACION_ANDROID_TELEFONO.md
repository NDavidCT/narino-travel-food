# 📱 CONFIGURACIÓN ANDROID PARA TELÉFONO FÍSICO
*Preparado: 19 de octubre de 2025*

## ✅ CONFIGURACIONES YA COMPLETADAS

### 🔐 Permisos Android (AndroidManifest.xml)
- ✅ **INTERNET**: Para conectividad
- ✅ **ACCESS_FINE_LOCATION**: GPS preciso
- ✅ **ACCESS_COARSE_LOCATION**: Ubicación aproximada
- ✅ **ACCESS_NETWORK_STATE**: Estado de red
- ✅ **usesCleartextTraffic**: Para desarrollo

### 📦 Firebase & Google Services
- ✅ **google-services.json**: Ya configurado
- ✅ **Firebase plugins**: Ya en build.gradle.kts
- ✅ **Application ID**: com.example.ipi_deli_tour

## 🔧 PASOS PARA HABILITAR GOOGLE SIGN-IN EN ANDROID

### Paso 1: Generar SHA-1 Fingerprints

**Comando para Debug (certificado de desarrollo):**
```bash
cd android
./gradlew signingReport
```

**O usando Java directamente:**
```bash
keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
```

### Paso 2: Configurar Firebase Console

1. **Ir a**: https://console.firebase.google.com
2. **Seleccionar tu proyecto**
3. **Ir a**: Project Settings > General
4. **En "Your apps"** encontrar "Android app"
5. **Agregar SHA-1 fingerprints** que obtuviste del paso anterior

### Paso 3: Descargar nuevo google-services.json

1. **Después de agregar SHA-1**
2. **Descargar nuevo** `google-services.json`
3. **Reemplazar** el archivo en `android/app/google-services.json`

## 📱 COMPATIBILIDAD MÓVIL ACTUAL

### ✅ FUNCIONARÁ INMEDIATAMENTE:
- **🗺️ OpenStreetMap**: Mapas interactivos completos
- **📍 30 Destinos**: Todos con coordenadas precisas
- **🧭 Geolocalización**: Ubicación del usuario
- **🚗 Google Maps Links**: Botones "Ver en Mapa" y "Navegar"
- **🎨 UI Completa**: Todas las pantallas y navegación
- **⭐ Favoritos**: Sistema completo (sin necesidad de login)

### ⚠️ NECESITA CONFIGURACIÓN SHA-1:
- **🔐 Google Sign-In**: Requiere pasos anteriores

## 🎯 RESULTADO ESPERADO

**Sin Google Sign-In configurado:**
- ✅ **95% de funcionalidades** operativas
- ✅ **Mapas perfectos**
- ✅ **Navegación completa**
- ❌ Solo autenticación Google fallaría

**Con Google Sign-In configurado:**
- ✅ **100% funcional**
- ✅ **Autenticación completa**

## 🚀 COMANDO PARA PROBAR

```bash
# Conectar teléfono por USB y habilitar depuración USB
flutter devices

# Ejecutar en tu dispositivo
flutter run -d <nombre-del-dispositivo>
```

## 📝 NOTAS IMPORTANTES

1. **Habilitar "Depuración USB"** en tu Android
2. **Instalar controladores USB** si es necesario
3. **La app funcionará casi completamente** sin configurar SHA-1
4. **Google Sign-In** es lo único que necesita configuración adicional

¿Estás listo para que te guíe en los pasos específicos para tu teléfono?