import 'package:flutter/material.dart';
import 'package:narino_travel_food/l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';
import '../services/favorites_service.dart';
import '../models/destination.dart';
import '../models/restaurant.dart';
import 'destination_page.dart';
import 'restaurant_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with TickerProviderStateMixin {
  void _shareFavorites() {
    final shareText = _favoritesService.generateShareText();
    Share.share(
      shareText,
      subject: AppLocalizations.of(context)!.shareFavorites,
    );
  }

  late TabController _tabController;
  final FavoritesService _favoritesService = FavoritesService();
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  final SortOption _sortOption = SortOption.name;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeFavorites();
  }

  Future<void> _initializeFavorites() async {
    await _favoritesService.initialize();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.sortBy,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildSortOption(SortOption.name,
                AppLocalizations.of(context)!.name, Icons.sort_by_alpha),
            _buildSortOption(SortOption.rating,
                AppLocalizations.of(context)!.rating, Icons.star),
            _buildSortOption(SortOption.dateAdded,
                AppLocalizations.of(context)!.dateAdded, Icons.access_time),
            const SizedBox(height: 10),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.ascendingOrder),
              value: _sortAscending,
              onChanged: (value) {
                setState(() {
                  _sortAscending = value;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(SortOption option, String title, IconData icon) {
    return ListTile(
      leading:
          Icon(icon, color: _sortOption == option ? Colors.green : Colors.grey),
      title: Text(title),
    );
  }

  void _showClearConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.clearFavorites),
        content: Text(AppLocalizations.of(context)!.confirmClearFavorites),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              _favoritesService.clearAllFavorites();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favoritos eliminados')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(AppLocalizations.of(context)!.delete,
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _favoritesService,
          builder: (context, child) => Text(
            '${AppLocalizations.of(context)!.myFavorites} (${_favoritesService.totalFavorites})',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(
              icon: Icon(Icons.place),
              text: AppLocalizations.of(context)!.destinations,
            ),
            Tab(
              icon: Icon(Icons.restaurant),
              text: AppLocalizations.of(context)!.restaurants,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.white),
            onPressed: _showSortOptions,
            tooltip: AppLocalizations.of(context)!.sort,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 'share':
                  _shareFavorites();
                  break;
                case 'clear':
                  _showClearConfirmation();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.green),
                    SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.shareFavorites),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.clear_all, color: Colors.red),
                    SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.clearAll),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Buscar en favoritos...',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // Contenido de las pestañas
          Expanded(
            child: AnimatedBuilder(
              animation: _favoritesService,
              builder: (context, child) {
                if (_favoritesService.isEmpty) {
                  return _buildEmptyState();
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildDestinationsTab(),
                    _buildRestaurantsTab(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.noFavorites,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.exploreAndSave,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              // Cambiar a la pestaña de inicio
              DefaultTabController.of(context).animateTo(1);
            },
            icon: const Icon(Icons.explore, color: Colors.white),
            label: Text(AppLocalizations.of(context)!.explorePlaces,
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationsTab() {
    final destinations = _favoritesService.searchDestinations(_searchQuery);
    final sortedDestinations = _favoritesService
        .getSortedDestinations(_sortOption, ascending: _sortAscending);
    final filteredDestinations = sortedDestinations
        .where((dest) => destinations.contains(dest))
        .toList();

    if (filteredDestinations.isEmpty && _searchQuery.isNotEmpty) {
      return _buildNoResultsFound('destinos');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredDestinations.length,
      itemBuilder: (context, index) {
        return _buildDestinationCard(filteredDestinations[index]);
      },
    );
  }

  Widget _buildRestaurantsTab() {
    final restaurants = _favoritesService.searchRestaurants(_searchQuery);
    final sortedRestaurants = _favoritesService
        .getSortedRestaurants(_sortOption, ascending: _sortAscending);
    final filteredRestaurants =
        sortedRestaurants.where((rest) => restaurants.contains(rest)).toList();

    if (filteredRestaurants.isEmpty && _searchQuery.isNotEmpty) {
      return _buildNoResultsFound('restaurantes');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredRestaurants.length,
      itemBuilder: (context, index) {
        return _buildRestaurantCard(filteredRestaurants[index]);
      },
    );
  }

  Widget _buildNoResultsFound(String type) {
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
            'No se encontraron $type',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta con otros términos de búsqueda',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(Destination destination) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DestinationPage(destination: destination),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: destination.imageUrl != null
                      ? Image.asset(
                          destination.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.place,
                              size: 40,
                              color: Colors.grey.shade400),
                        )
                      : Icon(Icons.place,
                          size: 40, color: Colors.grey.shade400),
                ),
              ),
              const SizedBox(width: 16),
              // Información
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (destination.description != null)
                      Text(
                        destination.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < destination.rating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          '${destination.rating}/5',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Botón eliminar
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  _favoritesService
                      .removeDestinationFromFavorites(destination.name);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('${destination.name} eliminado de favoritos'),
                      action: SnackBarAction(
                        label: 'Deshacer',
                        onPressed: () {
                          _favoritesService
                              .addDestinationToFavorites(destination);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantPage(restaurant: restaurant),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: restaurant.imageUrl != null
                      ? Image.asset(
                          restaurant.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.restaurant,
                              size: 40,
                              color: Colors.grey.shade400),
                        )
                      : Icon(Icons.restaurant,
                          size: 40, color: Colors.grey.shade400),
                ),
              ),
              const SizedBox(width: 16),
              // Información
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ??
                          AppLocalizations.of(context)!.restaurantNoName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (restaurant.address != null)
                      Text(
                        restaurant.address!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < (restaurant.rating ?? 0)
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          '${restaurant.rating ?? 0}/5',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Botón eliminar
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  _favoritesService
                      .removeRestaurantFromFavorites(restaurant.name ?? '');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${restaurant.name ?? 'Restaurante'} eliminado de favoritos'),
                      action: SnackBarAction(
                        label: 'Deshacer',
                        onPressed: () {
                          _favoritesService
                              .addRestaurantToFavorites(restaurant);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
