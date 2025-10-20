import 'package:flutter/material.dart';
import 'package:narino_travel_food/models/restaurant.dart';

class RestaurantPage extends StatelessWidget {
  final Restaurant? restaurant;

  const RestaurantPage({super.key, this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant?.name ?? 'Detalles del Restaurante'),
        // --- AÑADIMOS LOS BOTONES AQUÍ ---
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Lógica para guardar el restaurante como favorito
              print('Restaurante ${restaurant?.name} agregado a favoritos');
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Lógica para compartir el restaurante
              print('Compartir restaurante ${restaurant?.name}');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                // Contenedor principal con la imagen de fondo
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(restaurant?.imageUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Botón de regreso (ya estaba aquí y lo dejamos)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    restaurant?.name ?? 'Nombre no disponible',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    restaurant?.address ?? 'Dirección no disponible',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Acerca del Restaurante',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    restaurant?.description ?? 'Descripción no disponible.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
