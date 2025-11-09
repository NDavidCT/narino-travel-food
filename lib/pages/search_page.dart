import 'package:flutter/material.dart';
import 'package:narino_travel_food/l10n/app_localizations.dart';
import 'package:narino_travel_food/models/destination.dart';
import 'package:narino_travel_food/models/restaurant.dart';
import 'package:narino_travel_food/services/search_service.dart';
import 'package:narino_travel_food/pages/destination_page.dart';
import 'package:narino_travel_food/pages/restaurant_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Destination> _destinationResults = [];
  List<Restaurant> _restaurantResults = [];
  bool _isSearching = false;
  bool _hasSearched = false;

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _destinationResults = [];
        _restaurantResults = [];
        _hasSearched = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // Simular un pequeño delay para mejor UX
    Future.delayed(const Duration(milliseconds: 300), () {
      final results = SearchService.searchAll(query);
      setState(() {
        _destinationResults = results['destinations'] as List<Destination>;
        _restaurantResults = results['restaurants'] as List<Restaurant>;
        _isSearching = false;
        _hasSearched = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buscar en Nariño',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.green.shade50,
            child: TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Buscar destinos, restaurantes...',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              ),
            ),
          ),

          // Resultados de búsqueda
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!_hasSearched) {
      return _buildInitialState();
    }

    if (_destinationResults.isEmpty && _restaurantResults.isEmpty) {
      return _buildNoResults();
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Resultados de destinos
        if (_destinationResults.isNotEmpty) ...[
          _buildSectionHeader('Destinos (${_destinationResults.length})'),
          const SizedBox(height: 8),
          ..._destinationResults
              .map((destination) => _buildDestinationCard(destination)),
          const SizedBox(height: 20),
        ],

        // Resultados de restaurantes
        if (_restaurantResults.isNotEmpty) ...[
          _buildSectionHeader('Restaurantes (${_restaurantResults.length})'),
          const SizedBox(height: 8),
          ..._restaurantResults
              .map((restaurant) => _buildRestaurantCard(restaurant)),
        ],
      ],
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.whatAreYouLookingFor,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.searchNarino,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildQuickSearchButtons(),
        ],
      ),
    );
  }

  Widget _buildQuickSearchButtons() {
    final quickSearches = [
      'Pasto',
      'Las Lajas',
      'Laguna',
      'Restaurantes',
      'Iglesia'
    ];

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: quickSearches.map((search) {
        return ElevatedButton(
          onPressed: () {
            _searchController.text = search;
            _performSearch(search);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade100,
            foregroundColor: Colors.green.shade700,
            elevation: 0,
          ),
          child: Text(search),
        );
      }).toList(),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No se encontraron resultados',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta con otras palabras clave',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.green.shade700,
      ),
    );
  }

  Widget _buildDestinationCard(Destination destination) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            destination.imageUrl!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey.shade300,
                child: const Icon(Icons.location_on),
              );
            },
          ),
        ),
        title: Text(
          destination.city!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          destination.description!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DestinationPage(destination: destination),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            restaurant.imageUrl!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey.shade300,
                child: const Icon(Icons.restaurant),
              );
            },
          ),
        ),
        title: Text(
          restaurant.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restaurant.address!),
            Row(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < restaurant.rating!
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(width: 8),
                Text('${restaurant.rating}/5'),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantPage(restaurant: restaurant),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
