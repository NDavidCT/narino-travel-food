// Pantalla de mapa interactivo
// Permite visualizar ubicaciones y destinos turísticos en el mapa
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:narino_travel_food/services/maps_service.dart';

class MapPage extends StatefulWidget {
  // Permite centrar el mapa en un destino seleccionado
  final String? selectedDestination;

  const MapPage({super.key, this.selectedDestination});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Controlador del mapa
  final MapController _controller = MapController();
  // Lista de marcadores en el mapa
  List<Marker> _markers = [];
  // Posición actual mostrada en el mapa
  LatLng _currentPosition = MapsService.narinoCenter;
  // Ubicación del usuario
  LatLng? _userLocation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Inicializa el mapa y obtiene la ubicación
    _initializeMap();
  }

  // Inicializa el mapa y los marcadores
  Future<void> _initializeMap() async {
    // Obtener ubicación actual
    LatLng? userLocation = await MapsService.getCurrentLocation();
    if (userLocation != null) {
      _userLocation = userLocation;
      _currentPosition = userLocation;
    }

    // Generar marcadores para destinos
    _generateDestinationMarkers();

    // Si hay un destino seleccionado, centrar en él
    if (widget.selectedDestination != null) {
      LatLng? destinationCoord =
          MapsService.destinationCoordinates[widget.selectedDestination];
      if (destinationCoord != null) {
        _currentPosition = destinationCoord;
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Genera los marcadores para los destinos y la ubicación del usuario
  void _generateDestinationMarkers() {
    _markers = MapsService.destinationCoordinates.entries.map((entry) {
      return Marker(
        point: entry.value,
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _onDestinationTapped(entry.key),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.place,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      );
    }).toList();

    // Agregar marcador de ubicación actual si existe
    if (_userLocation != null) {
      _markers.add(
        Marker(
          point: _userLocation!,
          width: 40,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[700],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      );
    }
  }

  // Muestra información del destino al tocar un marcador
  void _onDestinationTapped(String destinationName) {
    // Mostrar información del destino
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                destinationName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<double?>(
                future:
                    MapsService.getDistanceFromCurrentLocation(destinationName),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Text(
                      'Distancia: ${snapshot.data!.toStringAsFixed(1)} km',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    );
                  }
                  return const Text('Calculando distancia...');
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Aquí podrías navegar a la página del destino
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                ),
                child: const Text('Ver destino',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  // Mueve el mapa a una posición específica
  void _animateToPosition(LatLng position) {
    _controller.move(position, 15.0);
  }

  // Centra el mapa en la ubicación actual del usuario
  void _goToCurrentLocation() async {
    LatLng? userLocation = await MapsService.getCurrentLocation();
    if (userLocation != null) {
      _userLocation = userLocation;
      _generateDestinationMarkers();
      _animateToPosition(userLocation);
      setState(() {});
    }
  }

  // Construye la interfaz principal del mapa
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Nariño - GRATIS'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _goToCurrentLocation,
            tooltip: 'Mi ubicación',
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Mapa Gratuito'),
                  content: const Text(
                      'Este mapa usa OpenStreetMap - completamente gratis y sin límites!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.green),
                  SizedBox(height: 10),
                  Text('Cargando mapa gratuito...'),
                ],
              ),
            )
          : FlutterMap(
              mapController: _controller,
              options: MapOptions(
                center: _currentPosition,
                zoom: 8.0,
                minZoom: 5.0,
                maxZoom: 18.0,
              ),
              children: [
                // Capa de tiles de OpenStreetMap (GRATIS!)
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.narino_travel_food',
                ),
                // Capa de marcadores
                MarkerLayer(
                  markers: _markers,
                ),
              ],
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Botón para acercar el mapa
          FloatingActionButton(
            heroTag: "zoom_in",
            mini: true,
            backgroundColor: Colors.green[700],
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              double currentZoom = _controller.zoom;
              _controller.move(_controller.center, currentZoom + 1);
            },
          ),
          const SizedBox(height: 10),
          // Botón para alejar el mapa
          FloatingActionButton(
            heroTag: "zoom_out",
            mini: true,
            backgroundColor: Colors.green[700],
            child: const Icon(Icons.remove, color: Colors.white),
            onPressed: () {
              double currentZoom = _controller.zoom;
              _controller.move(_controller.center, currentZoom - 1);
            },
          ),
          const SizedBox(height: 10),
          // Botón para ver todo el departamento
          FloatingActionButton(
            heroTag: "view_all",
            backgroundColor: Colors.green[700],
            child: const Icon(Icons.map, color: Colors.white),
            onPressed: () {
              // Mostrar todos los destinos
              _controller.move(MapsService.narinoCenter, 8.0);
            },
          ),
          const SizedBox(height: 10),
          // Botón para ver destinos cercanos
          FloatingActionButton(
            heroTag: "nearby",
            backgroundColor: Colors.orange[700],
            child: const Icon(Icons.near_me, color: Colors.white),
            onPressed: () async {
              // Mostrar destinos cercanos
              List<String> nearby =
                  await MapsService.getNearbyDestinations(50.0); // 50km radius
              if (nearby.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Destinos Cercanos'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: nearby
                          .map((destination) => ListTile(
                                leading: const Icon(Icons.place,
                                    color: Colors.green),
                                title: Text(destination),
                                onTap: () {
                                  Navigator.pop(context);
                                  LatLng? coord = MapsService
                                      .destinationCoordinates[destination];
                                  if (coord != null) {
                                    _controller.move(coord, 15.0);
                                  }
                                },
                              ))
                          .toList(),
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('No se encontraron destinos cercanos')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
