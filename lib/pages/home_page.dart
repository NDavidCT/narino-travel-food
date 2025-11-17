// Pantalla de inicio principal
// Contiene la navegación y acceso a las secciones principales
import 'package:flutter/material.dart';
import 'package:narino_travel_food/l10n/app_localizations.dart';
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
    return Scaffold(
      // Usamos Stack para poner la imagen de fondo y el contenido encima
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
              // Si la imagen falla, muestra color de fondo
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
              children: <Widget>[
                // Título principal
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    AppLocalizations.of(context)!.whatAreYouLookingFor,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Color ahora visible
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                // Subtítulo de destinos
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    AppLocalizations.of(context)!.popularDestinations,
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
                // Subtítulo de restaurantes
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    AppLocalizations.of(context)!.featuredRestaurants,
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
