# INSTRUCCIONES DE RESTAURACIÓN - Nariño Travel & Food

## 📋 **CÓMO RESTAURAR ESTE PROYECTO**

### **1. REQUISITOS PREVIOS**
Asegúrate de tener instalado:
- Flutter SDK (>=3.2.6)
- Dart SDK
- Chrome (para desarrollo web)
- Firebase CLI
- Git

### **2. RESTAURAR DESDE COPIA DE SEGURIDAD**

#### **Paso 1: Copiar archivos**
```powershell
# Navegar al directorio de proyectos
cd C:\Proyectos_Flutter

# Copiar el backup a un nuevo directorio
Copy-Item -Path "narino_travel_food_backup_2025-10-18_22-04-29" -Destination "narino_travel_food_restaurado" -Recurse

# Entrar al directorio restaurado
cd narino_travel_food_restaurado
```

#### **Paso 2: Instalar dependencias**
```bash
flutter pub get
```

#### **Paso 3: Verificar configuración**
```bash
flutter analyze
flutter doctor
```

### **3. CONFIGURACIÓN DE FIREBASE**

#### **Opción A: Usar Firebase existente**
- Los archivos `firebase_options.dart` y `google-services.json` ya están configurados
- El proyecto Firebase: `narino-travel-food`

#### **Opción B: Crear nuevo proyecto Firebase**
```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Login a Firebase
firebase login

# Inicializar nuevo proyecto
firebase init

# Configurar Hosting y Authentication
```

### **4. CONFIGURACIÓN OAUTH (IMPORTANTE)**

#### **Google Sign-In Setup**
1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crear/seleccionar proyecto
3. Habilitar Google Sign-In API
4. Configurar OAuth consent screen
5. Crear credenciales OAuth 2.0

#### **Redirect URIs necesarios:**
```
http://localhost:8080
https://narino-travel-food.web.app
```

### **5. EJECUCIÓN DEL PROYECTO**

#### **Desarrollo Local**
```bash
# Ejecutar en Chrome (puerto 8080 para OAuth)
flutter run -d chrome --web-port 8080

# O usar el script batch incluido
.\flutter_run_oauth_fixed.bat
```

#### **Build para Producción**
```bash
flutter build web
```

#### **Deploy a Firebase**
```bash
firebase deploy
```

### **6. SOLUCIÓN DE PROBLEMAS COMUNES**

#### **Error: Assets no encontrados**
Algunos assets de imágenes pueden faltar. Para solucionarlo:
```bash
# Crear directorio de imágenes
mkdir assets\images

# Agregar imágenes placeholder o las reales
# Las rutas están definidas en lib/models/destination.dart
```

#### **Error: OAuth redirect**
Verificar que:
- Puerto 8080 esté configurado
- Firebase OAuth settings sean correctos
- Google Cloud Console tenga los redirect URIs

#### **Error: Firebase connection**
```bash
# Reconfigurar Firebase
firebase logout
firebase login
firebase use --add
```

### **7. ARCHIVOS IMPORTANTES**

#### **Configuración Principal**
- `pubspec.yaml` - Dependencias y metadatos
- `firebase.json` - Configuración de hosting
- `lib/firebase_options.dart` - Configuración Firebase

#### **Archivos de OAuth**
- `android/app/google-services.json` - Android config
- `web/index.html` - Web OAuth scripts

#### **Archivos de Datos**
- `lib/models/destination.dart` - 30 destinos
- `lib/services/maps_service.dart` - OpenStreetMap
- `lib/services/google_maps_service.dart` - Google Maps

### **8. TESTING**

#### **Verificar funcionalidades principales:**
1. ✅ Login con Google funciona
2. ✅ Navegación entre pestañas
3. ✅ Mapa OpenStreetMap carga
4. ✅ Botones Google Maps abren correctamente
5. ✅ Destinos se muestran correctamente

#### **Comandos de test:**
```bash
# Análisis de código
flutter analyze

# Test unitarios (si existen)
flutter test

# Verificar assets
flutter assemble web
```

### **9. PERSONALIZACIÓN**

#### **Cambiar datos del proyecto:**
1. Editar `pubspec.yaml` - nombre y descripción
2. Modificar `lib/models/destination.dart` - destinos
3. Actualizar assets en `assets/images/`
4. Cambiar colores en archivos de páginas

#### **Agregar nuevos destinos:**
```dart
// En lib/models/destination.dart
Destination(
  city: 'Nuevo Destino',
  country: 'Colombia',
  description: 'Descripción...',
  activities: nuevasActividades,
  historyAndInfo: 'Historia...',
)
```

#### **Agregar coordenadas para mapas:**
```dart
// En lib/services/google_maps_service.dart
'Nuevo Destino': LatLng(latitud, longitud),
```

### **10. RECURSOS ADICIONALES**

#### **Documentación incluida:**
- `PROYECTO_RESUMEN_COMPLETO.md` - Resumen completo
- `DOCUMENTACION_TECNICA.md` - Detalles técnicos
- Este archivo - Instrucciones de restauración

#### **Enlaces útiles:**
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Console](https://console.firebase.google.com/)
- [Google Cloud Console](https://console.cloud.google.com/)

---

## 🚀 **INICIO RÁPIDO**

```bash
# 1. Restaurar proyecto
cd C:\Proyectos_Flutter
Copy-Item -Path "narino_travel_food_backup_2025-10-18_22-04-29" -Destination "mi_proyecto_restaurado" -Recurse
cd mi_proyecto_restaurado

# 2. Instalar dependencias
flutter pub get

# 3. Ejecutar
flutter run -d chrome --web-port 8080
```

**¡PROYECTO LISTO PARA USAR!** ✅

*Instrucciones actualizadas: 18 de Octubre 2025*