// Servicio para gestionar favoritos (destinos y restaurantes)
// Permite guardar, cargar y ordenar favoritos usando SharedPreferences
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../models/restaurant.dart';

// Opciones de ordenamiento para favoritos
enum SortOption { name, dateAdded, rating }

class FavoritesService extends ChangeNotifier {
  // Singleton para acceso global
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  List<Destination> _favoriteDestinations = [];
  List<Restaurant> _favoriteRestaurants = [];

  // Claves para guardar en SharedPreferences
  static const String _destinationsKey = 'favorite_destinations';
  static const String _restaurantsKey = 'favorite_restaurants';

  // Getters para acceder a favoritos
  List<Destination> get favoriteDestinations =>
      List.unmodifiable(_favoriteDestinations);
  List<Restaurant> get favoriteRestaurants =>
      List.unmodifiable(_favoriteRestaurants);

  int get totalFavorites =>
      _favoriteDestinations.length + _favoriteRestaurants.length;
  bool get isEmpty => totalFavorites == 0;
  bool get isNotEmpty => totalFavorites > 0;

  // Inicializa el servicio cargando favoritos guardados
  Future<void> initialize() async {
    await _loadFavorites();
  }

  // Carga favoritos desde SharedPreferences
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Cargar destinos favoritos
      final destinationsJson = prefs.getStringList(_destinationsKey) ?? [];
      _favoriteDestinations = destinationsJson
          .map((json) => Destination.fromJson(jsonDecode(json)))
          .toList();

      // Cargar restaurantes favoritos
      final restaurantsJson = prefs.getStringList(_restaurantsKey) ?? [];
      _favoriteRestaurants = restaurantsJson
          .map((json) => Restaurant.fromJson(jsonDecode(json)))
          .toList();

      notifyListeners();
    } catch (e) {
      print('Error cargando favoritos: $e');
    }
  }

  // Guardar favoritos en SharedPreferences
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Guardar destinos
      final destinationsJson = _favoriteDestinations
          .map((dest) => jsonEncode(dest.toJson()))
          .toList();
      await prefs.setStringList(_destinationsKey, destinationsJson);

      // Guardar restaurantes
      final restaurantsJson = _favoriteRestaurants
          .map((rest) => jsonEncode(rest.toJson()))
          .toList();
      await prefs.setStringList(_restaurantsKey, restaurantsJson);
    } catch (e) {
      print('Error guardando favoritos: $e');
    }
  }

  // MÉTODOS PARA DESTINOS

  /// Verifica si un destino es favorito
  bool isDestinationFavorite(String destinationName) {
    return _favoriteDestinations.any((dest) => dest.name == destinationName);
  }

  /// Alterna el estado de favorito de un destino
  Future<bool> toggleDestinationFavorite(Destination destination) async {
    bool isFavorite = isDestinationFavorite(destination.name);

    if (isFavorite) {
      return await removeDestinationFromFavorites(destination.name);
    } else {
      return await addDestinationToFavorites(destination);
    }
  }

  /// Agrega un destino a favoritos
  Future<bool> addDestinationToFavorites(Destination destination) async {
    if (!isDestinationFavorite(destination.name)) {
      _favoriteDestinations.add(destination);
      await _saveFavorites();
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Remueve un destino de favoritos
  Future<bool> removeDestinationFromFavorites(String destinationName) async {
    final index = _favoriteDestinations
        .indexWhere((dest) => dest.name == destinationName);
    if (index != -1) {
      _favoriteDestinations.removeAt(index);
      await _saveFavorites();
      notifyListeners();
      return true;
    }
    return false;
  }

  // MÉTODOS PARA RESTAURANTES

  /// Verifica si un restaurante es favorito
  bool isRestaurantFavorite(String restaurantName) {
    return _favoriteRestaurants.any((rest) => rest.name == restaurantName);
  }

  /// Alterna el estado de favorito de un restaurante
  Future<bool> toggleRestaurantFavorite(Restaurant restaurant) async {
    String restaurantName = restaurant.name ?? '';
    bool isFavorite = isRestaurantFavorite(restaurantName);

    if (isFavorite) {
      return await removeRestaurantFromFavorites(restaurantName);
    } else {
      return await addRestaurantToFavorites(restaurant);
    }
  }

  /// Agrega un restaurante a favoritos
  Future<bool> addRestaurantToFavorites(Restaurant restaurant) async {
    String restaurantName = restaurant.name ?? '';
    if (!isRestaurantFavorite(restaurantName)) {
      _favoriteRestaurants.add(restaurant);
      await _saveFavorites();
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Remueve un restaurante de favoritos
  Future<bool> removeRestaurantFromFavorites(String restaurantName) async {
    final index =
        _favoriteRestaurants.indexWhere((rest) => rest.name == restaurantName);
    if (index != -1) {
      _favoriteRestaurants.removeAt(index);
      await _saveFavorites();
      notifyListeners();
      return true;
    }
    return false;
  }

  // MÉTODOS DE BÚSQUEDA Y FILTRADO

  /// Busca destinos favoritos que contengan la query
  List<Destination> searchDestinations(String query) {
    if (query.isEmpty) return _favoriteDestinations;

    return _favoriteDestinations
        .where((dest) =>
            dest.name.toLowerCase().contains(query.toLowerCase()) ||
            (dest.description?.toLowerCase().contains(query.toLowerCase()) ??
                false))
        .toList();
  }

  /// Busca restaurantes favoritos que contengan la query
  List<Restaurant> searchRestaurants(String query) {
    if (query.isEmpty) return _favoriteRestaurants;

    return _favoriteRestaurants
        .where((rest) =>
            (rest.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
            (rest.address?.toLowerCase().contains(query.toLowerCase()) ??
                false))
        .toList();
  }

  // ORDENAMIENTO

  /// Devuelve destinos ordenados según la opción y orden especificados
  List<Destination> getSortedDestinations(SortOption sortBy,
      {bool ascending = true}) {
    List<Destination> sorted = List.from(_favoriteDestinations);

    switch (sortBy) {
      case SortOption.name:
        sorted.sort((a, b) =>
            ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
        break;
      case SortOption.rating:
        sorted.sort((a, b) => ascending
            ? a.rating.compareTo(b.rating)
            : b.rating.compareTo(a.rating));
        break;
      case SortOption.dateAdded:
        // Para implementar esto necesitaríamos agregar fecha de creación
        // Por ahora usamos el orden actual
        if (!ascending) sorted = sorted.reversed.toList();
        break;
    }

    return sorted;
  }

  /// Devuelve restaurantes ordenados según la opción y orden especificados
  List<Restaurant> getSortedRestaurants(SortOption sortBy,
      {bool ascending = true}) {
    List<Restaurant> sorted = List.from(_favoriteRestaurants);

    switch (sortBy) {
      case SortOption.name:
        sorted.sort((a, b) => ascending
            ? (a.name ?? '').compareTo(b.name ?? '')
            : (b.name ?? '').compareTo(a.name ?? ''));
        break;
      case SortOption.rating:
        sorted.sort((a, b) => ascending
            ? (a.rating ?? 0).compareTo(b.rating ?? 0)
            : (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      case SortOption.dateAdded:
        if (!ascending) sorted = sorted.reversed.toList();
        break;
    }

    return sorted;
  }

  // FUNCIONALIDAD DE COMPARTIR

  /// Genera un texto para compartir en redes sociales
  String generateShareText() {
    if (isEmpty) {
      return "¡Descubre los mejores destinos y restaurantes de Nariño! 🇨🇴\n\n📱 Descarga Nariño Travel & Food";
    }

    StringBuffer shareText = StringBuffer();
    shareText.writeln("🌟 Mis lugares favoritos en Nariño 🇨🇴\n");

    if (_favoriteDestinations.isNotEmpty) {
      shareText.writeln("🏞️ DESTINOS TURÍSTICOS:");
      for (int i = 0; i < _favoriteDestinations.length; i++) {
        final dest = _favoriteDestinations[i];
        shareText.writeln("${i + 1}. ${dest.name} ⭐${dest.rating}/5");
      }
      shareText.writeln();
    }

    if (_favoriteRestaurants.isNotEmpty) {
      shareText.writeln("🍽️ RESTAURANTES:");
      for (int i = 0; i < _favoriteRestaurants.length; i++) {
        final rest = _favoriteRestaurants[i];
        shareText.writeln(
            "${i + 1}. ${rest.name ?? 'Sin nombre'} ⭐${rest.rating ?? 0}/5");
      }
      shareText.writeln();
    }

    shareText.writeln(
        "📱 Descarga Nariño Travel & Food y descubre más lugares increíbles!");
    return shareText.toString();
  }

  // LIMPIAR TODOS LOS FAVORITOS

  /// Limpia todos los destinos y restaurantes favoritos
  Future<void> clearAllFavorites() async {
    _favoriteDestinations.clear();
    _favoriteRestaurants.clear();
    await _saveFavorites();
    notifyListeners();
  }

  /// Limpia solo los destinos favoritos
  Future<void> clearDestinations() async {
    _favoriteDestinations.clear();
    await _saveFavorites();
    notifyListeners();
  }

  /// Limpia solo los restaurantes favoritos
  Future<void> clearRestaurants() async {
    _favoriteRestaurants.clear();
    await _saveFavorites();
    notifyListeners();
  }
}
