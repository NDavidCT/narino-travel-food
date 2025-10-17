import 'package:ipi_deli_tour/models/activity.dart';

class Destination {
  String? imageUrl;
  String? city;
  String? country;
  String? description; // Descripción corta (resumen)
  List<Activity>? activities;
  String? historyAndInfo; // Campo para historia y detalles

  Destination({
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,
    this.historyAndInfo,
  });
}

// *** LISTA DE ACTIVIDADES ACTUALIZADA PARA LAS LAJAS (PRECIOS EN COP) ***
List<Activity> lajasActivities = [
  Activity(
    imageUrl: 'assets/images/museo.jpg',
    name: 'Visita al Museo y Artesanías',
    type: 'Cultura e Historia',
    startTimes: ['9:00 am', '4:00 pm'],
    rating: 4,
    price: 5000, // Precio de entrada al museo (Ejemplo en COP)
  ),
  Activity(
    imageUrl: 'assets/images/teleferico.jpg',
    name: 'Paseo en Teleférico',
    type: 'Transporte y Panorámicas',
    startTimes: ['8:00 am', '5:00 pm'],
    rating: 5,
    price: 15000, // Ejemplo de precio (Ejemplo en COP)
  ),
  Activity(
    imageUrl: 'assets/images/mirador.jpg',
    name: 'Vista desde el Mirador',
    type: 'Panorámica',
    startTimes: ['6:00 am', '5:00 pm'],
    rating: 5,
    price: 0,
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/images/santuario_lajas.jpg',
    city: 'Ipiales',
    country: 'Colombia',
    description:
        'Una maravilla arquitectónica neogótica en el cañón del río Guáitara.',
    activities: lajasActivities,
    // ¡TEXTO SIN ASTERISCOS DE FORMATO!
    historyAndInfo:
        'El Santuario de Nuestra Señora del Rosario de Las Lajas es una de las iglesias más impresionantes del mundo. Se levanta majestuosamente dentro del cañón del río Guáitara, cerca de Ipiales.\n\n'
        'Historia Milagrosa: Su origen se remonta a 1754, cuando la imagen de la Virgen del Rosario apareció milagrosamente en una roca. Este suceso fue presenciado por María Mueses de Quiñónez y su hija, Rosa, quien —según la tradición— fue sanada de su sordomudez.\n\n'
        'Arquitectura: La estructura actual, de estilo neogótico, fue construida entre 1916 y 1949. Se apoya sobre un puente de 50 metros de altura que cruza el río, logrando un efecto visual que desafía la gravedad.\n\n'
        'Información Útil para la Visita:\n* Ubicación: Cañón del río Guáitara, a 7 km de Ipiales.\n* Acceso: Se puede llegar en vehículo particular o taxi, y se recomienda usar el teleférico para tener una vista espectacular del santuario y el cañón (costo adicional).\n* Clima: El clima es frío de montaña. Se recomienda llevar ropa abrigada y cómoda para caminar.',
  ),
  Destination(
    imageUrl: 'assets/images/laguna_verde.jpg',
    city: 'Laguna de Azufral',
    country: 'Colombia',
    description: 'Explora la belleza natural de la Laguna Verde.',
    activities: azufralActivities,
  ),
  Destination(
    imageUrl: 'assets/images/la_cocha.jpg',
    city: 'Pasto',
    country: 'Colombia',
    description: 'Navega la hermosa Laguna de la Cocha.',
    activities: laCochaActivities,
  ),
];
// Actividades específicas para Laguna de Azufral
List<Activity> azufralActivities = [
  Activity(
    imageUrl: 'assets/images/observacion_geologica.jpg',
    name: 'Observación Geológica',
    type: 'Ciencia y Naturaleza',
    startTimes: ['9:00 am'],
    rating: 4,
    price: 5000,
  ),
  Activity(
    imageUrl: 'assets/images/fotografia_paisajes.jpg',
    name: 'Fotografía de Paisajes',
    type: 'Fotografía',
    startTimes: ['6:30 am', '4:00 pm'],
    rating: 5,
    price: 0,
  ),
];

// Actividades específicas para La Cocha (Pasto)
List<Activity> laCochaActivities = [
  Activity(
    imageUrl: 'assets/images/paseo_bote.jpg',
    name: 'Paseo en Bote por la Laguna',
    type: 'Náutica',
    startTimes: ['8:00 am', '2:00 pm'],
    rating: 5,
    price: 20000,
  ),
  Activity(
    imageUrl: 'assets/images/artesanias_locales.jpg',
    name: 'Visita a las Artesanías Locales',
    type: 'Cultura',
    startTimes: ['10:00 am'],
    rating: 4,
    price: 0,
  ),
  Activity(
    imageUrl: 'assets/images/avistamiento_aves.jpg',
    name: 'Avistamiento de Aves',
    type: 'Observación de Vida Silvestre',
    startTimes: ['6:00 am'],
    rating: 5,
    price: 10000,
  ),
];

// (Las actividades ya están definidas en `lajasActivities`)
