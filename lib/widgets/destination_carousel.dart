import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:narino_travel_food/models/destination.dart';
import 'package:narino_travel_food/pages/destination_page.dart';
import 'animated_favorite_button.dart';

class DestinationCarousel extends StatefulWidget {
  const DestinationCarousel({super.key});

  @override
  State<DestinationCarousel> createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<DestinationCarousel> {
  final ScrollController _scrollController = ScrollController();

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 220.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 220.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showAllDestinations() {
    Navigator.pushNamed(context, '/all-destinations');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Destinos turísticos de Nariño', // <--- CAMBIO AQUÍ
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: _showAllDestinations,
                child: Text(
                  'Ver todos',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 320.0,
          child: Stack(
            children: [
              ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: destinations.length,
                itemBuilder: (BuildContext context, int index) {
                  Destination destination = destinations[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DestinationPage(
                          destination: destination,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 210.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                            bottom: 5.0,
                            child: Container(
                              height: 110.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${destination.activities?.length} actividades',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Expanded(
                                      child: Text(
                                        destination.description ?? '',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11.0,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
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
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image(
                                    height: 180.0,
                                    width: 180.0,
                                    image:
                                        AssetImage(destination.imageUrl ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Botón de favoritos
                                Positioned(
                                  top: 10.0,
                                  right: 10.0,
                                  child: DestinationFavoriteButton(
                                    destination: destination,
                                    size: 20,
                                  ),
                                ),
                                Positioned(
                                  left: 10.0,
                                  bottom: 10.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            160.0, // Ancho disponible para el texto
                                        child: Text(
                                          destination.city ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                18.0, // Reducido de 24 a 18
                                            fontWeight: FontWeight.w600,
                                            letterSpacing:
                                                1.0, // Reducido de 1.2 a 1.0
                                            height:
                                                1.1, // Altura de línea compacta
                                          ),
                                          maxLines:
                                              2, // Permitir hasta 2 líneas
                                          overflow: TextOverflow
                                              .ellipsis, // Puntos suspensivos si es muy largo
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            FontAwesomeIcons.locationArrow,
                                            size: 10.0,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            destination.country ?? '',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Flecha izquierda
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.green,
                        size: 24,
                      ),
                      onPressed: _scrollLeft,
                    ),
                  ),
                ),
              ),
              // Flecha derecha
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_right,
                        color: Colors.green,
                        size: 24,
                      ),
                      onPressed: _scrollRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
