// Servicio para obtener ubicación y calcular distancias
// Utiliza Geolocator y LatLng para trabajar con coordenadas geográficas
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'dart:math';

class MapsService {
  // Coordenada central de Nariño
  static const LatLng narinoCenter =
      LatLng(1.2136, -77.2811); // Centro de Nariño

  // Mapa de coordenadas de destinos principales
  static const Map<String, LatLng> destinationCoordinates = {
    'Santuario de las Lajas': LatLng(0.8147, -77.5936),
    'Centro Histórico de Pasto': LatLng(1.2136, -77.2811),
    'Volcán Galeras': LatLng(1.2200, -77.3600),
    'Playas de Tumaco': LatLng(1.8014, -78.7642),
    'Volcán Cumbal': LatLng(0.9500, -77.8700),
    'Laguna de La Bolsa': LatLng(0.9600, -77.8500),
    'Katza Pi': LatLng(1.1500, -77.4000),
    'Río Telembí': LatLng(1.6500, -78.1500),
    'Hacienda Alsacia': LatLng(0.8200, -77.6100),
    'Pedregal Rio': LatLng(0.9800, -77.4500),
    'Paramo Paja Blanca': LatLng(0.8800, -77.7200),
    'Centro Recreacional Comfamiliar': LatLng(1.1800, -77.3200),
    'Laguna Coba Negra': LatLng(1.2500, -77.2500),
    // Agregar más coordenadas según necesites
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
