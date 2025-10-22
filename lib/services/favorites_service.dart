import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../models/restaurant.dart';

// Enum fuera de la clase
enum SortOption { name, dateAdded, rating }

class FavoritesService extends ChangeNotifier {
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  List<Destination> _favoriteDestinations = [];
  List<Restaurant> _favoriteRestaurants = [];

  // Keys para SharedPreferences
  static const String _destinationsKey = 'favorite_destinations';
  static const String _restaurantsKey = 'favorite_restaurants';

  // Getters
  List<Destination> get favoriteDestinations =>
      List.unmodifiable(_favoriteDestinations);
  List<Restaurant> get favoriteRestaurants =>
      List.unmodifiable(_favoriteRestaurants);

  int get totalFavorites =>
      _favoriteDestinations.length + _favoriteRestaurants.length;
  bool get isEmpty => totalFavorites == 0;
  bool get isNotEmpty => totalFavorites > 0;

  // Inicializar el servicio cargando favoritos guardados
  Future<void> initialize() async {
    await _loadFavorites();
  }

  // Cargar favoritos desde SharedPreferences
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

  bool isDestinationFavorite(String destinationName) {
    return _favoriteDestinations.any((dest) => dest.name == destinationName);
  }

  Future<bool> toggleDestinationFavorite(Destination destination) async {
    bool isFavorite = isDestinationFavorite(destination.name);

    if (isFavorite) {
      return await removeDestinationFromFavorites(destination.name);
    } else {
      return await addDestinationToFavorites(destination);
    }
  }

  Future<bool> addDestinationToFavorites(Destination destination) async {
    if (!isDestinationFavorite(destination.name)) {
      _favoriteDestinations.add(destination);
      await _saveFavorites();
      notifyListeners();
      return true;
    }
    return false;
  }

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

  bool isRestaurantFavorite(String restaurantName) {
    return _favoriteRestaurants.any((rest) => rest.name == restaurantName);
  }

  Future<bool> toggleRestaurantFavorite(Restaurant restaurant) async {
    String restaurantName = restaurant.name ?? '';
    bool isFavorite = isRestaurantFavorite(restaurantName);

    if (isFavorite) {
      return await removeRestaurantFromFavorites(restaurantName);
    } else {
      return await addRestaurantToFavorites(restaurant);
    }
  }

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

  List<Destination> searchDestinations(String query) {
    if (query.isEmpty) return _favoriteDestinations;

    return _favoriteDestinations
        .where((dest) =>
            dest.name.toLowerCase().contains(query.toLowerCase()) ||
            (dest.description?.toLowerCase().contains(query.toLowerCase()) ??
                false))
        .toList();
  }

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

  Future<void> clearAllFavorites() async {
    _favoriteDestinations.clear();
    _favoriteRestaurants.clear();
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> clearDestinations() async {
    _favoriteDestinations.clear();
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> clearRestaurants() async {
    _favoriteRestaurants.clear();
    await _saveFavorites();
    notifyListeners();
  }
}
