import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ipi_deli_tour/models/activity.dart';
import 'package:ipi_deli_tour/models/destination.dart';

class DestinationPage extends StatefulWidget {
  final Destination destination;

  const DestinationPage({super.key, required this.destination});
  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
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
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // TÍTULO DE LA SECCIÓN
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: Text(
                    'Acerca del Destino',
                    style: TextStyle(
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

                // TÍTULO DE HISTORIA E INFORMACIÓN RELEVANTE
                if (widget.destination.historyAndInfo != null)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    child: Text(
                      'Historia e Información Relevante',
                      style: TextStyle(
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                  child: Text(
                    'Actividades destacadas',
                    style: TextStyle(
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
