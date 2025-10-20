# CARACTERÍSTICAS TÉCNICAS - Nariño Travel & Food

## 🔧 **CONFIGURACIÓN DE DESARROLLO**

### **Flutter**
- SDK: '>=3.2.6 <4.0.0'
- Nombre: narino_travel_food
- Versión: 2.0.0+1

### **Firebase Configuration**
- Project ID: narino-travel-food
- OAuth Port: 8080
- Hosting URL: narino-travel-food.web.app

### **Google Maps Integration**
```dart
// Coordenadas de 24 destinos principales
static const Map<String, LatLng> destinationCoordinates = {
  'Santuario de las Lajas': LatLng(0.8147, -77.5936),
  'Centro Histórico de Pasto': LatLng(1.2136, -77.2811),
  'Laguna de la Cocha': LatLng(1.1500, -77.3000),
  'Volcán Galeras': LatLng(1.2200, -77.3600),
  'Playas de Tumaco': LatLng(1.8014, -78.7642),
  // ... 19 destinos más
};
```

## 📱 **ESTRUCTURA DE ARCHIVOS PRINCIPALES**

```
lib/
├── main.dart                    # Entry point
├── firebase_options.dart        # Firebase config
├── models/
│   ├── destination.dart         # 30 destinos + actividades
│   └── activity.dart           # Modelo de actividades
├── pages/
│   ├── main_screen.dart        # 4 pestañas navegación
│   ├── home_page.dart          # Página principal
│   ├── map_page.dart           # OpenStreetMap
│   ├── destination_page.dart   # Detalles + Google Maps
│   ├── auth_page.dart          # Autenticación
│   ├── login_screen.dart       # Login
│   ├── register_screen.dart    # Registro
│   ├── search_page.dart        # Búsqueda
│   └── favorites_page.dart     # Favoritos
├── services/
│   ├── maps_service.dart       # OpenStreetMap service
│   ├── google_maps_service.dart # Google Maps deep linking
│   └── google_sign_in_service.dart # OAuth
└── widgets/
    ├── destination_carousel.dart
    └── restaurant_carousel.dart
```

## 🗺️ **SISTEMA DE MAPAS DUAL**

### **OpenStreetMap (Gratuito)**
```dart
dependencies:
  flutter_map: ^6.1.0
  latlong2: ^0.9.1
  geolocator: ^10.1.0
```

**Funcionalidades:**
- Mapa interactivo principal
- 30 marcadores de destinos
- Geolocalización del usuario
- Cálculo de distancias
- Zoom automático

### **Google Maps (Premium)**
```dart
dependencies:
  url_launcher: ^6.2.2
```

**Funcionalidades:**
- Deep linking sin API costs
- Navegación turn-by-turn
- Vista de ubicaciones específicas
- Botones en páginas de destinos

## 🎨 **TEMA Y DISEÑO**

### **Colores Principales**
```dart
// Verde de Nariño (naturaleza)
Colors.green[600]   // Botones principales
Colors.green[50]    // Fondos claros
Colors.green[300]   // Bordes
Colors.green[700]   // Texto oscuro
```

### **Navegación**
```dart
final List<Widget> _pages = [
  const SearchPage(),     // Índice 0
  const HomePage(),       // Índice 1 (inicial)
  const FavoritesPage(),  // Índice 2
  const MapPage(),        // Índice 3 (NUEVO)
];
```

## 🔐 **AUTENTICACIÓN OAUTH**

### **Google Sign-In Configuration**
```yaml
firebase_auth: ^4.17.9
google_sign_in: ^6.2.1
```

### **Configuración Web**
```html
<!-- web/index.html -->
<script src="https://apis.google.com/js/platform.js"></script>
```

### **OAuth Settings**
- Redirect URI: http://localhost:8080
- Web Client ID: Configurado en Firebase
- Android/iOS: Configurado en google-services.json

## 📊 **DATOS DE DESTINOS**

### **30 Destinos Implementados**
Cada destino incluye:
```dart
class Destination {
  String? imageUrl;
  String? city;           // Nombre del destino
  String? country;        // Colombia
  String? description;    // Descripción corta
  List<Activity>? activities; // Lista de actividades
  String? historyAndInfo; // Historia detallada
}
```

### **Actividades con Precios**
```dart
class Activity {
  String? imageUrl;
  String? name;
  String? type;
  List<String>? startTimes;
  int? rating;
  int? price; // Precios en COP (Pesos Colombianos)
}
```

## 🌐 **COMANDOS DE DESARROLLO**

### **Ejecución Local**
```bash
flutter run -d chrome --web-port 8080
```

### **Build para Producción**
```bash
flutter build web
```

### **Deploy a Firebase**
```bash
firebase deploy
```

### **Análisis de Código**
```bash
flutter analyze
```

## 🔧 **CONFIGURACIÓN DE PUERTOS**

### **OAuth Configuration**
- Puerto local: 8080
- Hostname: localhost
- URL completa: http://localhost:8080

### **Firebase Hosting**
- URL de producción: narino-travel-food.web.app
- Configuración en firebase.json

## 📁 **ASSETS Y RECURSOS**

### **Imágenes**
```
assets/
└── images/
    ├── senderismo_volcan.jpg
    ├── observacion_geologica_galeras.jpg
    ├── playa_morro.jpg
    ├── gastronomia_afro.jpg
    └── [más imágenes de actividades]
```

### **Configuración en pubspec.yaml**
```yaml
flutter:
  assets:
    - assets/images/
```

---

**DOCUMENTACIÓN TÉCNICA COMPLETA**
*Fecha: 18 de Octubre 2025*