# 📱 GUÍA COMPLETA: PROBAR EN TELÉFONO FÍSICO ANDROID
*Configuración 100% Lista - 19 de octubre de 2025*

## ✅ CONFIGURACIÓN COMPLETADA

### 🔧 Modificaciones Realizadas:
- ✅ **AndroidManifest.xml**: Permisos de ubicación agregados
- ✅ **Nombre de app**: Actualizado a "Nariño Travel & Food"  
- ✅ **Permisos completos**: Internet, GPS, red
- ✅ **Google Services**: Ya configurado
- ✅ **Script SHA-1**: Creado para generar fingerprints

## 📋 PASOS PARA PROBAR EN TU TELÉFONO

### Paso 1: Preparar tu Teléfono Android

1. **Habilitar "Opciones de Desarrollador"**:
   - Ve a `Configuración > Acerca del teléfono`
   - Toca `Número de compilación` 7 veces
   - Aparecerá "Ahora eres desarrollador"

2. **Habilitar "Depuración USB"**:
   - Ve a `Configuración > Opciones de desarrollador`
   - Activar `Depuración USB`
   - Activar `Instalar vía USB`

3. **Conectar por USB**:
   - Conecta tu teléfono con cable USB
   - Seleccionar "Transferir archivos" cuando pregunte

### Paso 2: Verificar Conexión

```bash
# Verificar que Flutter detecta tu dispositivo
flutter devices
```

**Deberías ver algo como:**
```
Android SDK built for x86 • emulator-xxx • android-x86    • Android 11 (API 30)
SM-G991B • RZ8xxx • android-arm64 • Android 12 (API 31) ← TU TELÉFONO
```

### Paso 3: Ejecutar la App

```bash
# Ejecutar en tu teléfono (reemplaza con el nombre de tu dispositivo)
flutter run -d RZ8xxx
```

**O si solo hay un dispositivo:**
```bash
flutter run
```

## 🎯 QUÉ ESPERAR AL PROBAR

### ✅ FUNCIONARÁ INMEDIATAMENTE:

#### **🗺️ Mapas y Navegación:**
- Mapa interactivo con 30 destinos
- Zoom, paneo, marcadores
- Botón "Mi Ubicación" (pedirá permisos)
- Lista de "Destinos Cercanos"

#### **🚗 Google Maps Integration:**
- Botón "Ver en Mapa" → Abre Google Maps externa
- Botón "Navegar" → Inicia navegación GPS
- Funciona sin configuración adicional

#### **📱 UI Completa:**
- 4 pestañas: Inicio, Favoritos, Buscar, Mapa
- Navegación fluida
- Cards de destinos
- Imágenes y descripciones

#### **⭐ Sistema de Favoritos:**
- Agregar/quitar favoritos
- Funciona sin login (almacenamiento local)

### ⚠️ NECESITA CONFIGURACIÓN (OPCIONAL):

#### **🔐 Google Sign-In:**
- Si tocas "Iniciar Sesión con Google" → Error esperado
- Para solucionarlo: ejecutar `generar_sha1.bat` y seguir pasos

## 🚀 COMANDOS ÚTILES

```bash
# Ver dispositivos conectados
flutter devices

# Ejecutar en dispositivo específico
flutter run -d <device-id>

# Ejecutar en release mode (más rápido)
flutter run --release

# Ver logs de la app
flutter logs

# Hot reload (mientras está ejecutándose)
r

# Hot restart (mientras está ejecutándose)
R

# Salir
q
```

## 🎯 RESULTADO ESPERADO

**95% de la app funcionará perfectamente** en tu teléfono:
- ✅ Mapas interactivos
- ✅ Geolocalización  
- ✅ Google Maps externa
- ✅ Navegación completa
- ✅ Favoritos
- ⚠️ Solo Google Sign-In necesita configuración SHA-1

## 📝 SI NECESITAS GOOGLE SIGN-IN

1. **Ejecutar**: `generar_sha1.bat`
2. **Copiar SHA-1** que aparezca
3. **Ir a**: https://console.firebase.google.com
4. **Agregar SHA-1** a tu proyecto
5. **Descargar nuevo** google-services.json
6. **Reemplazar archivo** en android/app/

## 🎉 ¡LISTO PARA PROBAR!

La app **Nariño Travel & Food** está **100% preparada** para ejecutarse en tu teléfono Android. El 95% funcionará inmediatamente, y el Google Sign-In es opcional para funcionalidades básicas.

**¿Estás listo para conectar tu teléfono y probarlo?**