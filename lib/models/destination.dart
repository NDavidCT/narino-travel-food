import 'package:narino_travel_food/models/activity.dart';

class Destination {
  String? imageUrl;
  String? city;
  String? country;
  String? description; // Descripción corta (resumen)
  List<Activity>? activities;
  String? historyAndInfo; // Campo para historia y detalles
  double? latitude;
  double? longitude;

  Destination({
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,
    this.historyAndInfo,
    this.latitude,
    this.longitude,
  });

  // Getter para obtener el nombre (usamos city como identificador principal)
  String get name => city ?? 'Destino sin nombre';

  // Getter para rating (calculamos promedio de actividades)
  int get rating {
    if (activities == null || activities!.isEmpty) return 0;
    double avgRating = activities!
            .map((activity) => activity.rating ?? 0)
            .reduce((a, b) => a + b) /
        activities!.length;
    return avgRating.round();
  }

  // Métodos para serialización JSON
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'city': city,
      'country': country,
      'description': description,
      'historyAndInfo': historyAndInfo,
      'latitude': latitude,
      'longitude': longitude,
      'activities': activities?.map((activity) => activity.toJson()).toList(),
    };
  }

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      imageUrl: json['imageUrl'],
      city: json['city'],
      country: json['country'],
      description: json['description'],
      historyAndInfo: json['historyAndInfo'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      activities: json['activities'] != null
          ? (json['activities'] as List)
              .map((activityJson) => Activity.fromJson(activityJson))
              .toList()
          : null,
    );
  }
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

// Actividades para Laguna de La Bolsa
List<Activity> lagunaBolsaActivities = [
  Activity(
    imageUrl: 'assets/images/laguna_bolsa.jpg',
    name: 'Contemplación de la Laguna',
    type: 'Naturaleza',
    startTimes: ['7:00 am', '4:00 pm'],
    rating: 5,
    price: 0,
  ),
  Activity(
    imageUrl: 'assets/images/fotografia_paisajes.jpg',
    name: 'Fotografía de Paisaje',
    type: 'Fotografía',
    startTimes: ['6:00 am', '5:30 pm'],
    rating: 4,
    price: 5000,
  ),
];

// Actividades para Katza Pi
List<Activity> katzaPiActivities = [
  Activity(
    imageUrl: 'assets/images/katza_pi.jpg',
    name: 'Baños Termales',
    type: 'Relajación',
    startTimes: ['8:00 am', '6:00 pm'],
    rating: 5,
    price: 15000,
  ),
  Activity(
    imageUrl: 'assets/images/observacion_geologica.jpg',
    name: 'Observación Geológica',
    type: 'Educativo',
    startTimes: ['10:00 am'],
    rating: 4,
    price: 8000,
  ),
];

// Actividades para Hacienda Alsacia
List<Activity> haciendaAlsaciaActivities = [
  Activity(
    imageUrl: 'assets/images/hacienda_alsacia.jpg',
    name: 'Pesca Deportiva',
    type: 'Pesca',
    startTimes: ['6:00 am', '2:00 pm'],
    rating: 4,
    price: 25000,
  ),
  Activity(
    imageUrl: 'assets/images/hacienda_alsacia.jpg',
    name: 'Pista de Motos',
    type: 'Aventura',
    startTimes: ['9:00 am'],
    rating: 5,
    price: 30000,
  ),
  Activity(
    imageUrl: 'assets/images/hacienda_alsacia.jpg',
    name: 'Senderos Ecológicos',
    type: 'Caminata',
    startTimes: ['7:00 am', '3:00 pm'],
    rating: 4,
    price: 10000,
  ),
];

// Actividades para Pedregal Rio
List<Activity> pedregalRioActivities = [
  Activity(
    imageUrl: 'assets/images/pedregal_rio.jpg',
    name: 'Balneario Familiar',
    type: 'Recreación',
    startTimes: ['9:00 am'],
    rating: 4,
    price: 8000,
  ),
  Activity(
    imageUrl: 'assets/images/pedregal_rio.jpg',
    name: 'Piscina Natural',
    type: 'Natación',
    startTimes: ['10:00 am', '3:00 pm'],
    rating: 5,
    price: 5000,
  ),
];

// Actividades para Páramo Paja Blanca
List<Activity> paramoPajaBlancaActivities = [
  Activity(
    imageUrl: 'assets/images/paramo_paja_blanca.jpg',
    name: 'Observación de Frailejones',
    type: 'Naturaleza',
    startTimes: ['7:00 am'],
    rating: 5,
    price: 0,
  ),
  Activity(
    imageUrl: 'assets/images/paramo_frailejones.jpg',
    name: 'Caminata por el Páramo',
    type: 'Senderismo',
    startTimes: ['8:00 am'],
    rating: 4,
    price: 12000,
  ),
];

// Actividades para Centro Recreacional Comfamiliar
List<Activity> comfamiliarActivities = [
  Activity(
    imageUrl: 'assets/images/recreacion_comfamiliar.jpg',
    name: 'Actividades Familiares',
    type: 'Recreación',
    startTimes: ['9:00 am'],
    rating: 5,
    price: 15000,
  ),
  Activity(
    imageUrl: 'assets/images/recreacion_comfamiliar.jpg',
    name: 'Piscinas',
    type: 'Natación',
    startTimes: ['10:00 am', '2:00 pm'],
    rating: 4,
    price: 8000,
  ),
];

// Actividades para Laguna Coba Negra
List<Activity> lagunaCobaNegraActivities = [
  Activity(
    imageUrl: 'assets/images/laguna_coba_negra.jpg',
    name: 'Contemplación de la Laguna',
    type: 'Naturaleza',
    startTimes: ['7:00 am', '4:00 pm'],
    rating: 5,
    price: 0,
  ),
  Activity(
    imageUrl: 'assets/images/laguna_coba_negra.jpg',
    name: 'Leyendas Locales',
    type: 'Cultura',
    startTimes: ['10:00 am'],
    rating: 4,
    price: 5000,
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/images/santuario_lajas.jpg',
    city: 'Santuario de Nuestra Señora de Las Lajas',
    country: 'Ipiales',
    latitude: -0.807982,
    longitude: -77.585879,
    description:
        'El Santuario de Nuestra Señora de Las Lajas es una proeza de la ingeniería y la estética neogótica, encajado dramáticamente en la garganta del cañón del río Guáitara en Nariño, Colombia.',
    activities: lajasActivities,
    historyAndInfo:
        'La edificación actual, construida entre 1916 y 1949, exhibe un riguroso estilo neogótico y se distingue por su cimentación: se levanta espectacularmente sobre un puente de piedra de dos arcos que une los abruptos lados del cañón. Esta solución arquitectónica no solo salva el abismo, sino que integra la estructura a la pared rocosa natural, creando una silueta imponente que le ha valido el reconocimiento como una de las Maravillas de Colombia y un ejemplo de diseño sobresaliente a nivel mundial.',
  ),
  Destination(
    imageUrl: 'assets/images/laguna_verde.jpg',
    city: 'Laguna de Azufral',
    country: 'Túquerres',
    description: 'Explora la belleza natural de la Laguna Verde.',
    activities: azufralActivities,
  ),
  Destination(
    imageUrl: 'assets/images/la_cocha.jpg',
    city: 'Laguna de la Cocha',
    country: 'Pasto',
    description: 'Navega la hermosa Laguna de la Cocha.',
    activities: laCochaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/volcan_galeras.jpg',
    city: 'Volcán Galeras',
    country: 'Pasto',
    description: 'Explora el volcán activo más monitoreado de Colombia.',
    activities: galerasActivities,
  ),
  Destination(
    imageUrl: 'assets/images/centro_historico_pasto.jpg',
    city: 'Centro Histórico de Pasto',
    country: 'Pasto',
    description: 'Descubre la arquitectura colonial y cultura pastusa.',
    activities: centroHistoricoActivities,
  ),
  Destination(
    imageUrl: 'assets/images/playas_tumaco.jpg',
    city: 'Playas de Tumaco',
    country: 'Tumaco',
    description: 'Disfruta las playas del Pacífico y cultura afro.',
    activities: tumacoActivities,
  ),
  Destination(
    imageUrl: 'assets/images/volcan_cumbal.jpeg',
    city: 'Volcán Cumbal',
    country: 'Cumbal',
    description: 'Ascenso al volcán nevado y cultura indígena Pastos.',
    activities: cumbalActivities,
  ),
  Destination(
    imageUrl: 'assets/images/laguna_bolsa.jpg',
    city: 'Laguna de La Bolsa',
    country: 'Cumbal',
    description: 'hermosa laguna de aguas cristalinas.',
    activities: lagunaBolsaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/katza_pi.jpg',
    city: 'Katza Pi',
    country: 'Ricaurte',
    description: 'Relájate en las aguas termales naturales.',
    activities: katzaPiActivities,
  ),
  Destination(
    imageUrl: 'assets/images/rio_telembi.jpg',
    city: 'Río Telembí',
    country: 'Barbacoas',
    description: 'Explora la minería ancestral y cultura afro.',
    activities: barbacoasActivities,
  ),
  Destination(
    imageUrl: 'assets/images/cascada_tambo.jpg',
    city: 'Reservas Naturales de El Tambo',
    country: 'El Tambo',
    description: 'Reservas naturales y avistamiento de aves.',
    activities: elTamboActivities,
  ),
  Destination(
    imageUrl: 'assets/images/hacienda_alsacia.jpg',
    city: 'Hacienda Alsacia',
    country: 'Tuquerres',
    description:
        'recreación como pesca deportiva, una pista de motos y senderos ecológicos',
    activities: haciendaAlsaciaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/pedregal_rio.jpg',
    city: 'Pedregal Rio',
    country: 'Imues',
    description: 'hermoso balneario para disfrutar en familia',
    activities: pedregalRioActivities,
  ),
  Destination(
    imageUrl: 'assets/images/paramo_paja_blanca.jpg',
    city: 'Paramo Paja Blanca',
    country: 'Gualmatán',
    description: 'hermoso paisaje con frailejones y paramos.',
    activities: paramoPajaBlancaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/recreacion_comfamiliar.jpg',
    city: 'centro recreacional Comfamiliar',
    country: 'Chachagüí',
    description:
        'centro recreacional con múltiples actividades para toda la familia.',
    activities: comfamiliarActivities,
  ),
  Destination(
    imageUrl: 'assets/images/laguna_coba_negra.jpg',
    city: 'laguna Coba Negra',
    country: 'Pasto',
    description: 'Misteriosa laguna de aguas oscuras y entorno natural.',
    activities: lagunaCobaNegraActivities,
  ),
  Destination(
    imageUrl: 'assets/images/ecoparque.jpg',
    city: 'Haciendas Cafeteras',
    country: 'Buesaco',
    description: 'Ecoparque y Café especial de altura y haciendas cafeteras.',
    activities: narinoActivities,
  ),
  Destination(
    imageUrl: 'assets/images/sombrero_paja.jpeg',
    city: 'Sombreros de Paja Toquilla',
    country: 'Sandoná',
    description: 'Sombreros de paja toquilla patrimonio cultural.',
    activities: sandonaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/balneario_los_rosales.JPG',
    city: 'Balneario Los Rosales',
    country: 'Samaniego',
    description: 'excelente clima y hermoso balneario para el descanso.',
    activities: consacaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/mirador_chimayoy.jpg',
    city: 'Mirador de Chimayoy',
    country: 'Pasto',
    description: 'Mirador de Chimayoy y páramos únicos.',
    activities: tanguaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/piedra_bolivar.jpg',
    city: 'Piedra de Bolívar',
    country: 'Consaca',
    description: 'Piedra de Bolívar y formaciones rocosas.',
    activities: mallamaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/paramo_frailejones.jpg',
    city: 'Paramo de Frailejones',
    country: 'Chiles',
    description: 'Páramos, Volcan y Termales.',
    activities: funesActivities,
  ),
  Destination(
    imageUrl: 'assets/images/dedo_de_Dios.jpg',
    city: 'El dedo de Dios',
    country: 'Mallama',
    description: 'majestuoso cerro con formaciones rocosas únicas .',
    activities: puerresActivities,
  ),
  Destination(
    imageUrl: 'assets/images/cascada_chihuacos.jpg',
    city: 'Cascadas de Chihuacos',
    country: 'Potosi',
    description: 'hermosa cascada en entorno natural y el sol de los pastos',
    activities: ospinaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/cascada_la_paila.jpg',
    city: 'Cascada de la Paila',
    country: 'Pupiales',
    description: 'Manglares y ecoturismo marino del Pacífico.',
    activities: franciscoPizarroActivities,
  ),
  Destination(
    imageUrl: 'assets/images/carnaval_blancos_negros.jpg',
    city: 'Carnaval de Blancos y Negros',
    country: 'Todo el departamento de Nariño',
    description: 'Patrimonio Cultural Inmaterial de la Humanidad.',
    activities: carnavalActivities,
  ),
  Destination(
    imageUrl: 'assets/images/museo_carnaval.jpg',
    city: 'Museo del Carnaval',
    country: 'Pasto',
    description: 'Historia y tradición del Carnaval de Blancos y Negros.',
    activities: museoCarnavalActivities,
  ),
  Destination(
    imageUrl: 'assets/images/canon_juanambu.jpg',
    city: 'Cañón de Juanambú',
    country: 'Buesaco',
    description: 'Formación geológica espectacular y biodiversidad.',
    activities: canonJuanambuActivities,
  ),
  Destination(
    imageUrl: 'assets/images/cascada_wilke.jpg',
    city: 'Cascadas de Wilke',
    country: 'La Florida',
    description: 'Cascadas Blanca y Negra en paisaje tropical.',
    activities: cascadasWilkActivities,
  ),
  Destination(
    imageUrl: 'assets/images/osos_anteojos.jpg',
    city: 'Reserva Osos de Anteojos',
    country: 'La Planada',
    description: 'Observación del oso andino en su hábitat natural.',
    activities: ososAntejosActivities,
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

// Actividades para Volcán Galeras
List<Activity> galerasActivities = [
  Activity(
    imageUrl: 'assets/images/senderismo_volcan.jpg',
    name: 'Senderismo Volcánico',
    type: 'Aventura',
    startTimes: ['6:00 am'],
    rating: 4,
    price: 25000,
  ),
  Activity(
    imageUrl: 'assets/images/observacion_geologica_galeras.jpg',
    name: 'Observación Geológica',
    type: 'Ciencia',
    startTimes: ['8:00 am'],
    rating: 5,
    price: 15000,
  ),
];

// Actividades para Centro Histórico de Pasto
List<Activity> centroHistoricoActivities = [
  Activity(
    imageUrl: 'assets/images/tour_historico.jpg',
    name: 'Tour Histórico Cultural',
    type: 'Cultura',
    startTimes: ['9:00 am', '2:00 pm'],
    rating: 4,
    price: 12000,
  ),
  Activity(
    imageUrl: 'assets/images/museos_pasto.jpg',
    name: 'Visita a Museos',
    type: 'Cultura',
    startTimes: ['10:00 am'],
    rating: 4,
    price: 8000,
  ),
];

// Actividades para Tumaco
List<Activity> tumacoActivities = [
  Activity(
    imageUrl: 'assets/images/playa_morro.jpg',
    name: 'Playa El Morro',
    type: 'Playa',
    startTimes: ['8:00 am'],
    rating: 5,
    price: 0,
  ),
  Activity(
    imageUrl: 'assets/images/gastronomia_afro.jpg',
    name: 'Gastronomía Afro',
    type: 'Gastronomía',
    startTimes: ['12:00 pm'],
    rating: 5,
    price: 20000,
  ),
];

// Actividades para Volcán Cumbal
List<Activity> cumbalActivities = [
  Activity(
    imageUrl: 'assets/images/ascenso_cumbal.jpg',
    name: 'Ascenso al Volcán',
    type: 'Montañismo',
    startTimes: ['4:00 am'],
    rating: 5,
    price: 35000,
  ),
  Activity(
    imageUrl: 'assets/images/cultura_pastos.jpg',
    name: 'Cultura Indígena Pastos',
    type: 'Cultura',
    startTimes: ['10:00 am'],
    rating: 4,
    price: 10000,
  ),
];

// Actividades para La Cruz
List<Activity> laCruzActivities = [
  Activity(
    imageUrl: 'assets/images/mirador_la_cruz.jpg',
    name: 'Mirador Natural',
    type: 'Paisaje',
    startTimes: ['6:00 am', '5:00 pm'],
    rating: 5,
    price: 0,
  ),
  Activity(
    imageUrl: 'assets/images/tour_cafetero.jpg',
    name: 'Tour Cafetero',
    type: 'Agroturismo',
    startTimes: ['8:00 am'],
    rating: 4,
    price: 18000,
  ),
];

// Actividades para Ricaurte
List<Activity> ricaurteActivities = [
  Activity(
    imageUrl: 'assets/images/aguas_termales.jpg',
    name: 'Aguas Termales',
    type: 'Bienestar',
    startTimes: ['8:00 am', '2:00 pm'],
    rating: 5,
    price: 15000,
  ),
];

// Actividades para Barbacoas
List<Activity> barbacoasActivities = [
  Activity(
    imageUrl: 'assets/images/mineria_ancestral.jpg',
    name: 'Minería Ancestral',
    type: 'Cultura',
    startTimes: ['9:00 am'],
    rating: 4,
    price: 12000,
  ),
  Activity(
    imageUrl: 'assets/images/rio_telembi.jpg',
    name: 'Navegación Río Telembí',
    type: 'Náutica',
    startTimes: ['7:00 am'],
    rating: 4,
    price: 20000,
  ),
];

// Actividades para El Tambo
List<Activity> elTamboActivities = [
  Activity(
    imageUrl: 'assets/images/avistamiento_aves_tambo.jpg',
    name: 'Avistamiento de Aves',
    type: 'Ecoturismo',
    startTimes: ['6:00 am'],
    rating: 5,
    price: 15000,
  ),
];

// Actividades para Aldana
List<Activity> aldanaActivities = [
  Activity(
    imageUrl: 'assets/images/paramos_aldana.jpg',
    name: 'Caminata en Páramos',
    type: 'Ecoturismo',
    startTimes: ['7:00 am'],
    rating: 4,
    price: 10000,
  ),
];

// Actividades para Sapuyes
List<Activity> sapuyesActivities = [
  Activity(
    imageUrl: 'assets/images/termales_sapuyes.jpg',
    name: 'Termas de Sapuyes',
    type: 'Bienestar',
    startTimes: ['9:00 am'],
    rating: 4,
    price: 12000,
  ),
  Activity(
    imageUrl: 'assets/images/agroturismo_organico.jpg',
    name: 'Agroturismo Orgánico',
    type: 'Agroturismo',
    startTimes: ['8:00 am'],
    rating: 4,
    price: 8000,
  ),
];

// Actividades para Gualmatán
List<Activity> gualmatanActivities = [
  Activity(
    imageUrl: 'assets/images/festival_cebolla.jpg',
    name: 'Festival de la Cebolla',
    type: 'Cultura',
    startTimes: ['10:00 am'],
    rating: 4,
    price: 5000,
  ),
];

// Actividades para Chachagüí
List<Activity> chachaguiActivities = [
  Activity(
    imageUrl: 'assets/images/artesanias_barniz.jpg',
    name: 'Taller de Barniz',
    type: 'Artesanías',
    startTimes: ['9:00 am'],
    rating: 4,
    price: 15000,
  ),
];

// Actividades para Yacuanquer
List<Activity> yacuanquerActivities = [
  Activity(
    imageUrl: 'assets/images/observatorio_galeras.jpg',
    name: 'Observatorio Volcánico',
    type: 'Ciencia',
    startTimes: ['8:00 am'],
    rating: 5,
    price: 10000,
  ),
];

// Actividades para Nariño
List<Activity> narinoActivities = [
  Activity(
    imageUrl: 'assets/images/cafe_especial.jpg',
    name: 'Degustación de Café',
    type: 'Gastronomía',
    startTimes: ['9:00 am', '2:00 pm'],
    rating: 5,
    price: 12000,
  ),
  Activity(
    imageUrl: 'assets/images/haciendas_cafeteras.jpg',
    name: 'Tour Haciendas Cafeteras',
    type: 'Agroturismo',
    startTimes: ['8:00 am'],
    rating: 4,
    price: 20000,
  ),
];

// Actividades para Sandoná
List<Activity> sandonaActivities = [
  Activity(
    imageUrl: 'assets/images/sombreros_toquilla.jpg',
    name: 'Taller de Sombreros',
    type: 'Artesanías',
    startTimes: ['9:00 am'],
    rating: 4,
    price: 18000,
  ),
];

// Actividades para Consacá
List<Activity> consacaActivities = [
  Activity(
    imageUrl: 'assets/images/trapiches_panela.jpg',
    name: 'Proceso de Panela',
    type: 'Agroturismo',
    startTimes: ['8:00 am'],
    rating: 4,
    price: 10000,
  ),
];

// Actividades para Tangua
List<Activity> tanguaActivities = [
  Activity(
    imageUrl: 'assets/images/mirador_chimayoy.jpg',
    name: 'Mirador de Chimayoy',
    type: 'Paisaje',
    startTimes: ['6:00 am'],
    rating: 5,
    price: 0,
  ),
];

// Actividades para Mallama
List<Activity> mallamaActivities = [
  Activity(
    imageUrl: 'assets/images/piedra_bolivar.jpg',
    name: 'Piedra de Bolívar',
    type: 'Historia',
    startTimes: ['8:00 am'],
    rating: 4,
    price: 5000,
  ),
];

// Actividades para Funes
List<Activity> funesActivities = [
  Activity(
    imageUrl: 'assets/images/lagunas_glaciales.jpg',
    name: 'Lagunas Glaciales',
    type: 'Montañismo',
    startTimes: ['5:00 am'],
    rating: 5,
    price: 25000,
  ),
];

// Actividades para Puerres
List<Activity> puerresActivities = [
  Activity(
    imageUrl: 'assets/images/telares_indigenas.jpg',
    name: 'Telares Indígenas',
    type: 'Artesanías',
    startTimes: ['9:00 am'],
    rating: 4,
    price: 12000,
  ),
];

// Actividades para Ospina
List<Activity> ospinaActivities = [
  Activity(
    imageUrl: 'assets/images/investigacion_biodiversidad.jpg',
    name: 'Investigación Científica',
    type: 'Ciencia',
    startTimes: ['7:00 am'],
    rating: 4,
    price: 15000,
  ),
];

// Actividades para Francisco Pizarro
List<Activity> franciscoPizarroActivities = [
  Activity(
    imageUrl: 'assets/images/manglares_pacifico.jpg',
    name: 'Tour de Manglares',
    type: 'Ecoturismo',
    startTimes: ['8:00 am'],
    rating: 5,
    price: 18000,
  ),
  Activity(
    imageUrl: 'assets/images/tortugas_marinas.jpg',
    name: 'Observación de Tortugas',
    type: 'Vida Silvestre',
    startTimes: ['7:00 pm'],
    rating: 5,
    price: 22000,
  ),
];

// Actividades para Carnaval de Blancos y Negros
List<Activity> carnavalActivities = [
  Activity(
    imageUrl: 'assets/images/desfiles_carnaval.jpg',
    name: 'Desfiles del Carnaval',
    type: 'Cultura',
    startTimes: ['2:00 pm'],
    rating: 5,
    price: 0,
  ),
  Activity(
    imageUrl: 'assets/images/comparsas.jpg',
    name: 'Comparsas y Murgas',
    type: 'Espectáculo',
    startTimes: ['10:00 am'],
    rating: 5,
    price: 0,
  ),
];

// Actividades para Museo del Carnaval
List<Activity> museoCarnavalActivities = [
  Activity(
    imageUrl: 'assets/images/exposicion_carnaval.jpg',
    name: 'Exposición Permanente',
    type: 'Cultura',
    startTimes: ['9:00 am', '2:00 pm'],
    rating: 4,
    price: 8000,
  ),
];

// Actividades para Cañón de Juanambú
List<Activity> canonJuanambuActivities = [
  Activity(
    imageUrl: 'assets/images/senderismo_canon.jpg',
    name: 'Senderismo en el Cañón',
    type: 'Aventura',
    startTimes: ['7:00 am'],
    rating: 5,
    price: 15000,
  ),
  Activity(
    imageUrl: 'assets/images/rapel_canon.jpg',
    name: 'Rapel y Escalada',
    type: 'Deportes Extremos',
    startTimes: ['8:00 am'],
    rating: 5,
    price: 30000,
  ),
];

// Actividades para Cascadas de Wilk
List<Activity> cascadasWilkActivities = [
  Activity(
    imageUrl: 'assets/images/cascada_blanca.jpg',
    name: 'Cascada Blanca',
    type: 'Naturaleza',
    startTimes: ['8:00 am'],
    rating: 5,
    price: 8000,
  ),
  Activity(
    imageUrl: 'assets/images/cascada_negra.jpg',
    name: 'Cascada Negra',
    type: 'Naturaleza',
    startTimes: ['10:00 am'],
    rating: 5,
    price: 8000,
  ),
];

// Actividades para Reserva Osos de Anteojos
List<Activity> ososAntejosActivities = [
  Activity(
    imageUrl: 'assets/images/observacion_osos.jpg',
    name: 'Observación de Osos Andinos',
    type: 'Vida Silvestre',
    startTimes: ['6:00 am'],
    rating: 5,
    price: 35000,
  ),
  Activity(
    imageUrl: 'assets/images/conservacion_osos.jpg',
    name: 'Programa de Conservación',
    type: 'Educación Ambiental',
    startTimes: ['9:00 am'],
    rating: 4,
    price: 15000,
  ),
];

// (Las actividades ya están definidas en `lajasActivities`)
