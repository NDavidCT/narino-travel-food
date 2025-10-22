import 'package:narino_travel_food/models/destination.dart';
import 'package:narino_travel_food/models/restaurant.dart';

class SearchService {
  // Método para buscar destinos por nombre, ciudad o descripción
  static List<Destination> searchDestinations(String query) {
    if (query.isEmpty) return [];

    final queryLower = query.toLowerCase();
    return destinations.where((destination) {
      return destination.city!.toLowerCase().contains(queryLower) ||
          destination.description!.toLowerCase().contains(queryLower) ||
          destination.country!.toLowerCase().contains(queryLower);
    }).toList();
  }

  // Método para buscar restaurantes por nombre o descripción
  static List<Restaurant> searchRestaurants(String query) {
    if (query.isEmpty) return [];

    final queryLower = query.toLowerCase();
    return restaurants.where((restaurant) {
      return restaurant.name!.toLowerCase().contains(queryLower) ||
          restaurant.description!.toLowerCase().contains(queryLower) ||
          restaurant.address!.toLowerCase().contains(queryLower);
    }).toList();
  }

  // Búsqueda combinada que retorna un mapa con ambos resultados
  static Map<String, List<dynamic>> searchAll(String query) {
    return {
      'destinations': searchDestinations(query),
      'restaurants': searchRestaurants(query),
    };
  }
}
