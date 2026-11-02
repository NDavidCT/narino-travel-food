// Servicio para obtener ubicación y calcular distancias
// Utiliza Geolocator y LatLng para trabajar con coordenadas geográficas
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'dart:math';

class MapsService {
  // Coordenada central de Nariño
  static const LatLng narinoCenter =
      LatLng(1.2136, -77.2811); // Centro de Nariño

  // Vista inicial que muestra todo el departamento
  static const LatLng narinoOverviewCenter = LatLng(1.25, -77.9);
  static const double narinoOverviewZoom = 8.0;

  // Coordenadas de los destinos (misma fuente que GoogleMapsService).
  // La clave es el nombre exacto del destino; sin coordenada no hay marcador.
  static const Map<String, LatLng> destinationCoordinates = {
    'Santuario de Nuestra Señora de Las Lajas': LatLng(0.8147, -77.5936),
    'Centro Histórico de Pasto': LatLng(1.2136, -77.2811),
    'Laguna de la Cocha': LatLng(1.13941, -77.15388),
    'Volcán Galeras': LatLng(1.2200, -77.3600),
    'Playas de Tumaco': LatLng(1.830055, -78.731882),
    'Volcán Cumbal': LatLng(0.951786, -77.886942),
    'Laguna de La Bolsa': LatLng(0.940998, -77.825046),
    'Katza Pi': LatLng(1.206999, -77.987930),
    'Río Telembí': LatLng(1.675634, -78.136483),
    'Reservas Naturales de El Tambo': LatLng(1.4200, -77.3500),
    'Hacienda Alsacia': LatLng(1.05476, -77.67494),
    'Pedregal Rio': LatLng(1.054463, -77.453726),
    'Paramo Paja Blanca': LatLng(0.977242, -77.581805),
    'centro recreacional Comfamiliar': LatLng(1.408815, -77.289457),
    'laguna Coba Negra': LatLng(1.177056, -77.343465),
    'Haciendas Cafeteras': LatLng(1.423751, -77.148218),
    'Sombreros de Paja Toquilla': LatLng(1.289059, -77.469398),
    'Mirador de Chimayoy': LatLng(1.262117, -77.285140),
    'Piedra de Bolívar': LatLng(1.186010, -77.462789),
    'Termales de Chiles': LatLng(0.810049, -77.862713),
    'Cascada la Chilidoña': LatLng(0.921353, -77.444429),
    'Finca Carmen Amelia': LatLng(1.011026, -77.454944),
    'Cascada de la Paila': LatLng(0.908906, -77.637185),
    'Osos de Anteojos': LatLng(1.0015472143141955, -77.40047853135017),
  };
  // Obtener ubicación actual del usuario usando Geolocator (GRATIS)
  static Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled =
        await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // Los servicios de ubicación están deshabilitados
    }

    geolocator.LocationPermission permission =
        await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission == geolocator.LocationPermission.denied) {
        return null; // Permisos denegados
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      return null; // Permisos denegados permanentemente
    }

    geolocator.Position position =
        await geolocator.Geolocator.getCurrentPosition(
      desiredAccuracy: geolocator.LocationAccuracy.high,
    );
    return LatLng(position.latitude, position.longitude);
  }

  // Calcular distancia entre dos puntos usando fórmula Haversine
  static double calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371; // Radio de la Tierra en km

    double lat1Rad = start.latitude * (pi / 180);
    double lat2Rad = end.latitude * (pi / 180);
    double deltaLatRad = (end.latitude - start.latitude) * (pi / 180);
    double deltaLngRad = (end.longitude - start.longitude) * (pi / 180);

    double a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
        cos(lat1Rad) *
            cos(lat2Rad) *
            sin(deltaLngRad / 2) *
            sin(deltaLngRad / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distancia en kilómetros
  }

  // Calcular distancia desde ubicación actual a un destino
  static Future<double?> getDistanceFromCurrentLocation(
      String destinationName) async {
    LatLng? currentLocation = await getCurrentLocation();
    LatLng? destinationCoord = destinationCoordinates[destinationName];

    if (currentLocation != null && destinationCoord != null) {
      return calculateDistance(currentLocation, destinationCoord);
    }
    return null;
  }

  // Obtener destinos cercanos (dentro de X kilómetros)
  static Future<List<String>> getNearbyDestinations(double radiusKm) async {
    LatLng? currentLocation = await getCurrentLocation();
    if (currentLocation == null) return [];

    List<String> nearbyDestinations = [];

    destinationCoordinates.forEach((name, coord) {
      double distance = calculateDistance(currentLocation, coord);
      if (distance <= radiusKm) {
        nearbyDestinations.add(name);
      }
    });

    return nearbyDestinations;
  }

  // Obtener el destino más cercano
  static Future<String?> getClosestDestination() async {
    LatLng? currentLocation = await getCurrentLocation();
    if (currentLocation == null) return null;

    String? closestDestination;
    double minDistance = double.infinity;

    destinationCoordinates.forEach((name, coord) {
      double distance = calculateDistance(currentLocation, coord);
      if (distance < minDistance) {
        minDistance = distance;
        closestDestination = name;
      }
    });

    return closestDestination;
  }
}
