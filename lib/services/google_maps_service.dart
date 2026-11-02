// Servicio para abrir ubicaciones en Google Maps
// Permite mostrar destinos turísticos en el mapa usando coordenadas o nombre
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class GoogleMapsService {
  // Mapa de coordenadas para destinos principales
  static const Map<String, LatLng> destinationCoordinates = {
    'Santuario de las Lajas': LatLng(0.8147, -77.5936),
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
    'Trapiches de Panela': LatLng(1.1400, -77.4800),
    'Mirador de Chimayoy': LatLng(1.262117, -77.285140),
    'Piedra de Bolívar': LatLng(1.186010, -77.462789),
    'Termales de Chiles': LatLng(0.810049, -77.862713),
    'Cascada la Chilidoña': LatLng(0.921353, -77.444429),
    'Cascada de la Paila': LatLng(0.908906, -77.637185),
    'Lagunas Glaciales': LatLng(0.9100, -77.7500),
    'Telares Indígenas': LatLng(0.8500, -77.8200),
    'Reservas de Biodiversidad': LatLng(1.0500, -77.6800),
    'Manglares del Pacífico': LatLng(1.9200, -78.8500),
  };

  /// Abre Google Maps con las coordenadas del destino especificado
  /// Si no se encuentran las coordenadas, busca por nombre
  static Future<void> openDestinationInGoogleMaps(
      String destinationName) async {
    LatLng? coordinates = destinationCoordinates[destinationName];

    String url;
    if (coordinates != null) {
      // Usar coordenadas específicas para mayor precisión
      url =
          'https://www.google.com/maps?q=${coordinates.latitude},${coordinates.longitude}';
    } else {
      // Fallback: buscar por nombre + "Nariño Colombia"
      String searchQuery =
          Uri.encodeComponent('$destinationName Nariño Colombia');
      url = 'https://www.google.com/maps/search/$searchQuery';
    }

    await _launchURL(url);
  }

  /// Abre Google Maps con coordenadas específicas
  static Future<void> openCoordinatesInGoogleMaps(
      double latitude, double longitude,
      {String? label}) async {
    String url;
    if (label != null) {
      // Con etiqueta personalizada
      String encodedLabel = Uri.encodeComponent(label);
      url = 'https://www.google.com/maps?q=$latitude,$longitude($encodedLabel)';
    } else {
      // Solo coordenadas
      url = 'https://www.google.com/maps?q=$latitude,$longitude';
    }

    await _launchURL(url);
  }

  /// Abre Google Maps para navegar desde la ubicación actual hasta el destino
  static Future<void> openNavigationToDestination(
      String destinationName) async {
    LatLng? coordinates = destinationCoordinates[destinationName];

    String url;
    if (coordinates != null) {
      // Navegación directa con coordenadas
      url =
          'https://www.google.com/maps/dir/?api=1&destination=${coordinates.latitude},${coordinates.longitude}&travelmode=driving';
    } else {
      // Navegación por búsqueda
      String searchQuery =
          Uri.encodeComponent('$destinationName Nariño Colombia');
      url =
          'https://www.google.com/maps/dir/?api=1&destination=$searchQuery&travelmode=driving';
    }

    await _launchURL(url);
  }

  // Método privado para lanzar la URL en el navegador
  static Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      // Primero intentar abrir en Google Maps app
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Si no funciona, abrir en navegador predeterminado
        await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
        );
      }
    } catch (e) {
      print('Error al abrir Google Maps: $e');
      // En caso de error, intentar abrir en navegador web estándar
      try {
        await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
        );
      } catch (e2) {
        print('Error al abrir URL: $e2');
      }
    }
  }

  /// Obtiene las coordenadas de un destino si están disponibles
  static LatLng? getCoordinatesForDestination(String destinationName) {
    return destinationCoordinates[destinationName];
  }

  /// Verifica si un destino tiene coordenadas disponibles
  static bool hasCoordinatesForDestination(String destinationName) {
    return destinationCoordinates.containsKey(destinationName);
  }
}
