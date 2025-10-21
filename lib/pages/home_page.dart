import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:narino_travel_food/widgets/destination_carousel.dart';
import 'package:narino_travel_food/widgets/restaurant_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // Hemos renombrado la clase de estado a _HomePageState por convención
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nariño Travel & Food',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        actions: [
          // Mostrar información del usuario
          if (user != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  'Hola, ${user.displayName ?? user.email?.split('@')[0] ?? "Usuario"}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          // Botón de cerrar sesión
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand, // Esto hace que el Stack ocupe toda la pantalla
        children: <Widget>[
          // --- WIDGET DE IMAGEN DE FONDO (CON FALLBACK) ---
          // Intentamos cargar la imagen local:
          Image.asset(
            'assets/images/fondo_turismo.jpg',
            fit: BoxFit.cover, // Para que la imagen cubra todo el espacio
            // Si la imagen no se encuentra (asset no cargado), usamos un color:
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color:
                    Colors.red.shade300, // Color de fallback si la imagen falla
                child: const Center(
                    child: Text("Cargando Fondo...",
                        style: TextStyle(color: Colors.white))),
              );
            },
          ),

          // --- CAPA DE SOMBRA PARA MEJORAR EL CONTRASTE ---
          Container(
            color:
                Colors.black.withOpacity(0.3), // Sombra oscura semitransparente
          ),

          // --- CONTENIDO ORIGINAL DE TU PÁGINA ---
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '¿Qué te gustaria encontrar?',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Color ahora visible
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Destinos populares',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Color ahora visible
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                // Aquí se cargan las imágenes de DestinationCarousel
                DestinationCarousel(),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Restaurantes destacados',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Color ahora visible
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                // Aquí se cargan las imágenes de RestaurantCarousel
                RestaurantCarousel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
