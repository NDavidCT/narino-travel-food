import 'package:flutter/material.dart';
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
  late TabController _tabController;
  final FavoritesService _favoritesService = FavoritesService();
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  SortOption _sortOption = SortOption.name;
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
            const Text(
              'Ordenar por',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildSortOption(SortOption.name, 'Nombre', Icons.sort_by_alpha),
            _buildSortOption(SortOption.rating, 'Calificación', Icons.star),
            _buildSortOption(
                SortOption.dateAdded, 'Fecha agregado', Icons.access_time),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Orden ascendente'),
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
      trailing: _sortOption == option
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        setState(() {
          _sortOption = option;
        });
        Navigator.pop(context);
      },
    );
  }

  Future<void> _shareFavorites() async {
    final shareText = _favoritesService.generateShareText();
    await Share.share(
      shareText,
      subject: 'Mis lugares favoritos en Nariño 🇨🇴',
    );
  }

  void _showClearConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpiar favoritos'),
        content: const Text(
            '¿Estás seguro de que quieres eliminar todos tus favoritos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
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
            child:
                const Text('Eliminar', style: TextStyle(color: Colors.white)),
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
            'Mis Favoritos (${_favoritesService.totalFavorites})',
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
          tabs: const [
            Tab(
              icon: Icon(Icons.place),
              text: 'Destinos',
            ),
            Tab(
              icon: Icon(Icons.restaurant),
              text: 'Restaurantes',
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.white),
            onPressed: _showSortOptions,
            tooltip: 'Ordenar',
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
              const PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Compartir favoritos'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.clear_all, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Limpiar todo'),
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
            'Aún no tienes favoritos',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '¡Explora destinos y restaurantes increíbles\ny guarda los que más te gusten!',
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
            label: const Text('Explorar lugares',
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
                      restaurant.name ?? 'Restaurante sin nombre',
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
