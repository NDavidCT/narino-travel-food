import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:narino_travel_food/models/activity.dart';
import 'package:narino_travel_food/models/destination.dart';
import 'package:narino_travel_food/services/google_maps_service.dart';
import 'package:narino_travel_food/services/favorites_service.dart';
import 'package:narino_travel_food/widgets/reviews_section.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import 'package:timeago/timeago.dart' as timeago;

class DestinationPage extends StatefulWidget {
  final Destination destination;

  const DestinationPage({super.key, required this.destination});
  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage>
    with TickerProviderStateMixin {
  final FavoritesService _favoritesService = FavoritesService();
  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heartAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
          parent: _heartAnimationController, curve: Curves.elasticOut),
    );
    _favoritesService.initialize();
    // Configurar locale español para timeago
    timeago.setLocaleMessages('es', timeago.EsMessages());
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  Future<void> _toggleFavorite() async {
    bool wasAdded =
        await _favoritesService.toggleDestinationFavorite(widget.destination);

    if (wasAdded) {
      _heartAnimationController.forward().then((_) {
        _heartAnimationController.reverse();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.destination.name} agregado a favoritos ❤️'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.destination.name} eliminado de favoritos'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () {
              _favoritesService.addDestinationToFavorites(widget.destination);
            },
          ),
        ),
      );
    }
  }

  void _shareDestination() {
    final shareText = '''
🏞️ ${widget.destination.name} - Nariño, Colombia

${widget.destination.description ?? 'Un destino increíble para visitar'}

⭐ Calificación: ${widget.destination.rating}/5

📱 Descarga Nariño Travel & Food y descubre más destinos increíbles en Nariño 🇨🇴
    ''';

    Share.share(shareText,
        subject: '${widget.destination.name} - Nariño Travel & Food');
  }

  // Widget para construir las estrellas de calificación de forma visual
  Widget _buildRatingStars(int rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < rating) {
        stars.add(const Icon(Icons.star, color: Colors.amber, size: 20));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 20));
      }
    }
    return Row(children: stars);
  }

  // Widget para construir las tarjetas de actividad
  Widget _buildActivityCard(Activity activity) {
    return Stack(
      children: <Widget>[
        // TARJETA DE FONDO (detalles)
        Container(
          margin: const EdgeInsets.fromLTRB(60.0, 5.0, 20.0, 5.0),
          height: 170.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Padding(
            // CAMBIO: Aumentamos el padding izquierdo a 150.0
            padding: const EdgeInsets.fromLTRB(150.0, 20.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        activity.name ?? 'Actividad',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '\$ ${activity.price} COP',
                          style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'por persona',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  activity.type ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                _buildRatingStars(activity.rating ?? 0),
                const SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (activity.startTimes != null &&
                                activity.startTimes!.isNotEmpty)
                            ? activity.startTimes![0]
                            : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (activity.startTimes != null &&
                                activity.startTimes!.length > 1)
                            ? activity.startTimes![1]
                            : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // IMAGEN FRONTAL (miniatura de actividad)
        Positioned(
          left: 20.0,
          top: 15.0,
          bottom: 15.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              width: 160.0, // <-- CAMBIO CLAVE: Imagen más ancha (160.0)
              image: AssetImage(activity.imageUrl ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.7,
            actions: [
              // Botón de favoritos con animación
              AnimatedBuilder(
                animation: _favoritesService,
                builder: (context, child) {
                  bool isFavorite = _favoritesService
                      .isDestinationFavorite(widget.destination.name);
                  return ScaleTransition(
                    scale: _heartAnimation,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 28,
                      ),
                      onPressed: _toggleFavorite,
                      tooltip: isFavorite
                          ? 'Quitar de favoritos'
                          : 'Agregar a favoritos',
                    ),
                  );
                },
              ),
              // Botón de compartir
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white, size: 24),
                onPressed: _shareDestination,
                tooltip: 'Compartir destino',
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                widget.destination.city ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                children: <Widget>[
                  // IMAGEN DE FONDO
                  Image(
                    image: AssetImage(widget.destination.imageUrl ?? ''),
                    fit: BoxFit.contain,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  // GRADIENTE DE SOMBRA
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black54,
                          Colors.black26,
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                  // INFO EN LA PARTE SUPERIOR DE LA IMAGEN
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.destination.city ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  FontAwesomeIcons.locationArrow,
                                  size: 15.0,
                                  color: Colors.white70,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  widget.destination.country ?? '',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // ICONO DE GOOGLE MAPS - Esquina superior derecha
                  Positioned(
                    top: 60.0,
                    right: 20.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25.0),
                          onTap: () async {
                            // Abrir Google Maps con las coordenadas del destino
                            await GoogleMapsService.openDestinationInGoogleMaps(
                                widget.destination.city ?? '');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.map,
                                  color: Colors.green,
                                  size: 24.0,
                                ),
                                SizedBox(width: 6.0),
                                Text(
                                  'Maps',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // TÍTULO DE LA SECCIÓN
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: Text(
                    AppLocalizations.of(context)?.aboutDestination ??
                        'Acerca del Destino',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // DESCRIPCIÓN CORTA
                if (widget.destination.description != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    child: Text(
                      widget.destination.description ?? '',
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.grey[700], height: 1.4),
                    ),
                  ),

                // BOTONES DE MAPA Y NAVEGACIÓN
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Row(
                    children: [
                      // BOTÓN VER EN MAPA
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await GoogleMapsService
                                  .openDestinationInGoogleMaps(
                                      widget.destination.city ?? '');
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('No se pudo abrir el mapa: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.map_outlined, size: 20),
                          label: Text('Ver en Mapa'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[50],
                            foregroundColor: Colors.green[700],
                            elevation: 2,
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                  color: Colors.green[300]!, width: 1),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 12.0),

                      // BOTÓN NAVEGAR
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await GoogleMapsService
                                  .openNavigationToDestination(
                                      widget.destination.city ?? '');
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'No se pudo abrir la navegación: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.navigation, size: 20),
                          label: Text('Navegar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            foregroundColor: Colors.white,
                            elevation: 3,
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // TÍTULO DE HISTORIA E INFORMACIÓN RELEVANTE
                if (widget.destination.historyAndInfo != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    child: Text(
                      AppLocalizations.of(context)?.historyAndInfo ??
                          'Historia e Información Relevante',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // TEXTO DETALLADO
                if (widget.destination.historyAndInfo != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    child: Text(
                      widget.destination.historyAndInfo ?? '',
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.grey[700], height: 1.6),
                    ),
                  ),

                // TÍTULO DE ACTIVIDADES
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: Text(
                    AppLocalizations.of(context)?.featuredActivities ??
                        'Actividades destacadas',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Lista de tarjetas de actividad
                if (widget.destination.activities != null)
                  ...widget.destination.activities!.map((activity) {
                    return _buildActivityCard(activity);
                  }),

                // SECCIÓN DE RESEÑAS
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                  child: Text(
                    AppLocalizations.of(context)?.reviewsAndOpinions ??
                        'Reseñas y opiniones',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ReviewsSection(
                  placeId: widget.destination.name,
                  placeName: widget.destination.name,
                ),

                // Espacio extra al final para scroll
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
