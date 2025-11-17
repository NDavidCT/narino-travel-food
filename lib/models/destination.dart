// Modelo para destinos turísticos (ciudades, pueblos, lugares)
// Incluye información, actividades, ubicación y métodos para JSON
import 'package:narino_travel_food/models/activity.dart';

class Destination {
  String? imageUrl; // URL de la imagen principal del destino
  String? city; // Nombre de la ciudad o lugar
  String? country; // País
  String? description; // Descripción corta (resumen)
  List<Activity>? activities; // Lista de actividades destacadas
  String? historyAndInfo; // Historia y detalles relevantes
  double? latitude; // Ubicación geográfica
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

  // Devuelve el nombre del destino (usando city)
  String get name => city ?? 'Destino sin nombre';

  // Calcula el rating promedio de las actividades
  int get rating {
    if (activities == null || activities!.isEmpty) return 0;
    double avgRating = activities!
            .map((activity) => activity.rating ?? 0)
            .reduce((a, b) => a + b) /
        activities!.length;
    return avgRating.round();
  }

  // Convierte el destino a un mapa para guardar en JSON
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

  // Crea un destino desde un mapa JSON
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
};

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
    historyAndInfo:
        'La Laguna Verde, ubicada en el cráter del volcán Azufral, es famosa por el intenso color esmeralda de sus aguas, resultado de la alta concentración de azufre y minerales volcánicos. Este entorno andino, rodeado de páramos y montañas, es considerado uno de los paisajes más espectaculares de Nariño y Colombia.\n\nAdemás de su belleza natural, la laguna es un sitio de importancia ecológica y cultural, protegido como reserva natural. Es hábitat de especies endémicas y destino de senderismo y turismo ecológico, donde los visitantes pueden aprender sobre la geología volcánica y la biodiversidad de los Andes.\nFuente: Wikipedia, Parques Nacionales Naturales de Colombia.',
  ),
  Destination(
    imageUrl: 'assets/images/la_cocha.jpg',
    city: 'Laguna de la Cocha',
    country: 'Pasto',
    description: 'Navega la hermosa Laguna de la Cocha.',
    activities: laCochaActivities,
    historyAndInfo:
        'La Laguna de La Cocha, también conocida como Lago Guamuez, es el segundo cuerpo de agua natural más grande de Colombia y fue declarada humedal de importancia internacional por el Convenio Ramsar. Ubicada a 2680 metros sobre el nivel del mar y rodeada de montañas, es famosa por su belleza paisajística y por albergar la Isla La Corota, un santuario de fauna y flora con especies endémicas de aves y plantas.\n\nEn sus orillas se asientan comunidades descendientes de los quillasingas, quienes consideran la laguna un lugar sagrado. El turismo ecológico y la pesca de trucha arcoíris son actividades destacadas, y la zona cuenta con reservas naturales privadas gestionadas por los habitantes. La Laguna de La Cocha es un destino ideal para quienes buscan naturaleza, cultura y tranquilidad en el sur de Colombia.\nFuente: Wikipedia Laguna de la Cocha.',
  ),
  Destination(
    imageUrl: 'assets/images/volcan_galeras.jpg',
    city: 'Volcán Galeras',
    country: 'Pasto',
    description: 'Explora el volcán activo más monitoreado de Colombia.',
    historyAndInfo:
        'El Volcán Galeras, ubicado a pocos kilómetros de Pasto, es uno de los volcanes más activos y monitoreados de Colombia. Su imponente presencia ha marcado la historia geológica y cultural de la región, siendo escenario de numerosas erupciones que han influido en la vida de los habitantes y en el desarrollo científico del país. El área circundante es un santuario de fauna y flora, con senderos ecológicos y miradores que permiten apreciar la majestuosidad del cráter y la biodiversidad andina. Además, el Galeras es símbolo de resiliencia y adaptación para las comunidades locales, quienes han aprendido a convivir con la fuerza de la naturaleza y a valorar la riqueza ambiental y educativa que ofrece el volcán.\n\nEl Observatorio Vulcanológico y Sismológico de Pasto realiza monitoreo constante, contribuyendo a la seguridad y al conocimiento científico internacional. Visitar el Galeras es adentrarse en la historia viva de Nariño y en la conexión profunda entre el ser humano y la tierra.',
    activities: galerasActivities,
  ),
  Destination(
    imageUrl: 'assets/images/centro_historico_pasto.jpg',
    city: 'Centro Histórico de Pasto',
    country: 'Pasto',
    description: 'Descubre la arquitectura colonial y cultura pastusa.',
    historyAndInfo:
        'El Centro Histórico de Pasto es el corazón cultural y arquitectónico de la capital nariñense. Sus calles empedradas y edificaciones coloniales narran siglos de historia, desde la época virreinal hasta la actualidad. Aquí se encuentran templos emblemáticos como la Catedral, San Juan Bautista y Nuestra Señora de las Mercedes, que reflejan la riqueza artística y religiosa de la ciudad.\n\nEl centro es escenario de festividades tradicionales, como el Carnaval de Blancos y Negros, declarado Patrimonio Cultural Inmaterial de la Humanidad por la UNESCO. Museos, plazas y mercados ofrecen una experiencia única de turismo cultural, donde se puede disfrutar de la gastronomía local, el arte popular y la hospitalidad pastusa.\n\nRecorrer el Centro Histórico es sumergirse en la identidad de Pasto, en la resistencia de sus habitantes durante la Independencia y en la diversidad de expresiones que han hecho de la ciudad un referente nacional.',
    activities: centroHistoricoActivities,
  ),
  Destination(
    imageUrl: 'assets/images/playas_tumaco.jpg',
    city: 'Playas de Tumaco',
    country: 'Tumaco',
    description: 'Disfruta las playas del Pacífico y cultura afro.',
    historyAndInfo:
        'Las Playas de Tumaco, ubicadas en la costa pacífica de Nariño, son reconocidas por su belleza natural y la riqueza cultural afrodescendiente. El litoral ofrece extensas playas de arena oscura, manglares y estuarios que albergan una biodiversidad única.\n\nTumaco es un puerto estratégico y punto de encuentro de tradiciones ancestrales, música, gastronomía y festividades como el Festival del Currulao. La región ha sido testigo de procesos históricos de resistencia y adaptación, y hoy promueve el turismo sostenible y la conservación de sus ecosistemas marinos.\n\nVisitar Tumaco es descubrir la alegría, el sabor y la resiliencia de sus comunidades, así como la importancia de la integración entre naturaleza y cultura en el Pacífico colombiano.',
    activities: tumacoActivities,
  ),
  Destination(
    imageUrl: 'assets/images/volcan_cumbal.jpeg',
    city: 'Volcán Cumbal',
    country: 'Cumbal',
    description: 'Ascenso al volcán nevado y cultura indígena Pastos.',
    historyAndInfo:
        'El Volcán Cumbal, también conocido como Nevado de Cumbal, es el estratovolcán más alto del sur de Colombia, alcanzando los 4764 metros sobre el nivel del mar. Su cima nevada y sus laderas son fuente de agua y vida para la región, y han sido habitadas por la comunidad indígena Pastos desde tiempos ancestrales.\n\nEl ascenso al volcán permite observar paisajes de páramo, lagunas glaciares y una flora única adaptada a las condiciones extremas. Cumbal es también un lugar de espiritualidad y leyendas, donde los rituales indígenas se mezclan con la admiración por la fuerza de la naturaleza.\n\nLa zona es reconocida por su biodiversidad, la producción agrícola y la importancia geotérmica, siendo objeto de estudios científicos y turísticos. El volcán representa la unión entre tradición, ciencia y aventura en Nariño.',
    activities: cumbalActivities,
  ),
  Destination(
    imageUrl: 'assets/images/laguna_bolsa.jpg',
    city: 'Laguna de La Bolsa',
    country: 'Cumbal',
    description: 'hermosa laguna de aguas cristalinas.',
    historyAndInfo:
        'La Laguna de La Bolsa, ubicada en el municipio de Cumbal, es un espejo de agua de origen glaciar rodeado de montañas y vegetación nativa. Sus aguas cristalinas reflejan la pureza del entorno y son hábitat de aves migratorias y especies endémicas.\n\nLa laguna es fundamental para la regulación hídrica de la región y es considerada sagrada por las comunidades locales, quienes realizan rituales y celebraciones en sus orillas. El sitio es ideal para el ecoturismo, la observación de fauna y la contemplación de paisajes andinos.\n\nLa Bolsa forma parte de la red de humedales de Nariño y contribuye a la conservación ambiental y cultural del territorio.',
    activities: lagunaBolsaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/katza_pi.jpg',
    city: 'Katza Pi',
    country: 'Ricaurte',
    description: 'Relájate en las aguas termales naturales.',
    historyAndInfo:
        'Katza Pi, en Ricaurte, es un complejo de aguas termales naturales que brotan de las entrañas de la tierra, producto de la actividad volcánica de la región. Estas aguas han sido utilizadas por comunidades indígenas y visitantes para la relajación, la salud y el bienestar, gracias a sus propiedades minerales.\n\nEl entorno de Katza Pi está rodeado de paisajes montañosos, vegetación exuberante y senderos ecológicos que invitan al turismo de naturaleza y aventura. El sitio es punto de encuentro para el turismo de bienestar, la cultura ancestral y la integración comunitaria.\n\nKatza Pi representa la armonía entre el ser humano y los recursos naturales, promoviendo el desarrollo sostenible y la preservación de tradiciones milenarias.',
    activities: katzaPiActivities,
  ),
  Destination(
    imageUrl: 'assets/images/rio_telembi.jpg',
    city: 'Río Telembí',
    country: 'Barbacoas',
    description: 'Explora la minería ancestral y cultura afro.',
    historyAndInfo:
        'El Río Telembí, en Barbacoas, es uno de los principales afluentes de la costa pacífica nariñense. Sus aguas han sido testigo de la minería ancestral, la pesca y la navegación, actividades que han marcado la historia y la economía de la región.\n\nLa cuenca del Telembí alberga una biodiversidad extraordinaria, con manglares, selvas y especies endémicas. La cultura afrodescendiente y las comunidades indígenas han desarrollado tradiciones, leyendas y festividades en torno al río, que es símbolo de resiliencia y adaptación.\n\nEl Telembí es vital para la integración regional, la conservación ambiental y el turismo ecológico, siendo un ejemplo de la riqueza natural y cultural del Pacífico colombiano.',
    activities: barbacoasActivities,
  ),
  Destination(
    imageUrl: 'assets/images/cascada_tambo.jpg',
    city: 'Reservas Naturales de El Tambo',
    country: 'El Tambo',
    description: 'Reservas naturales y avistamiento de aves.',
    historyAndInfo:
        'Las Reservas Naturales de El Tambo, ubicadas en el corazón de Nariño, son áreas protegidas que albergan una gran diversidad de aves, mamíferos y plantas endémicas. El Tambo es reconocido por sus paisajes de montaña, ríos y bosques, que ofrecen oportunidades para el ecoturismo, la investigación científica y la educación ambiental.\n\nLa comunidad local participa activamente en la conservación y el manejo sostenible de los recursos, promoviendo el turismo responsable y la preservación de especies vulnerables. Las reservas son refugio de paz y aprendizaje, donde se puede disfrutar de la observación de aves, senderismo y actividades culturales.\n\nEl Tambo es ejemplo de integración entre desarrollo rural y protección ambiental en Nariño.',
    activities: elTamboActivities,
  ),
  Destination(
    imageUrl: 'assets/images/hacienda_alsacia.jpg',
    city: 'Hacienda Alsacia',
    country: 'Tuquerres',
    description:
        'recreación como pesca deportiva, una pista de motos y senderos ecológicos',
    historyAndInfo:
        'La Hacienda Alsacia, ubicada en Tuquerres, es un espacio rural dedicado a la recreación, la agricultura y el turismo ecológico. Ofrece actividades como pesca deportiva, senderos ecológicos y pista de motos, en un entorno de naturaleza y tranquilidad.\n\nLa hacienda es punto de encuentro para familias, turistas y amantes de la vida campestre, promoviendo la preservación de tradiciones agrícolas y el desarrollo sostenible. Sus instalaciones permiten la realización de eventos, talleres y experiencias educativas sobre el campo nariñense.\n\nAlsacia representa la integración entre modernidad y tradición, siendo un referente de turismo rural y conservación ambiental.',
    activities: haciendaAlsaciaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/pedregal_rio.jpg',
    city: 'Pedregal Rio',
    country: 'Imues',
    description: 'hermoso balneario para disfrutar en familia',
    historyAndInfo:
        'Pedregal Río, en Imues, es un balneario natural formado por el cauce del río y rodeado de extensas áreas verdes y vegetación nativa. Es ideal para el descanso, la recreación familiar y el contacto directo con la naturaleza.\n\nEl sitio es conocido por sus aguas limpias, la hospitalidad de la comunidad local y la posibilidad de realizar actividades como natación, picnic y senderismo. Pedregal Río es ejemplo de turismo comunitario y conservación de recursos hídricos en Nariño.',
    activities: pedregalRioActivities,
  ),
  Destination(
    imageUrl: 'assets/images/paramo_paja_blanca.jpg',
    city: 'Paramo Paja Blanca',
    country: 'Gualmatán',
    description: 'hermoso paisaje con frailejones y paramos.',
    historyAndInfo:
        'El Páramo Paja Blanca, en Gualmatán, es una de las áreas protegidas más importantes de Nariño. Alberga gran cantidad de especies nativas, entre ellas el frailejón, y provee de agua a varios municipios de la zona.\n\nEl páramo es escenario de procesos ecológicos fundamentales para la regulación hídrica, la conservación de la biodiversidad y la adaptación al cambio climático. El paisaje invita a la contemplación, la investigación científica y la educación ambiental, siendo clave para la sostenibilidad regional.\n\nPaja Blanca es también espacio de celebraciones culturales y religiosas, integrando la vida comunitaria con la protección de la naturaleza.',
    activities: paramoPajaBlancaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/recreacion_comfamiliar.jpg',
    city: 'centro recreacional Comfamiliar',
    country: 'Chachagüí',
    description:
        'centro recreacional con múltiples actividades para toda la familia.',
    historyAndInfo:
        'El Centro Recreacional Comfamiliar, en Chachagüí, es un complejo turístico que ofrece múltiples actividades para toda la familia. Sus instalaciones incluyen piscinas, zonas de juegos infantiles, áreas deportivas y espacios para eventos, rodeados de naturaleza y tranquilidad.\n\nComfamiliar es referente de turismo familiar en Nariño, promoviendo la integración social, el bienestar y la recreación en un entorno seguro y accesible. El centro contribuye al desarrollo local y a la promoción de estilos de vida saludables.',
    activities: comfamiliarActivities,
  ),
  Destination(
    imageUrl: 'assets/images/laguna_coba_negra.jpg',
    city: 'laguna Coba Negra',
    country: 'Pasto',
    historyAndInfo:
        'La Laguna Coba Negra, ubicada en Pasto, es un área natural protegida de gran importancia ecológica y cultural. Sus aguas oscuras y misteriosas han inspirado leyendas, estudios científicos y actividades de conservación.\n\nLa laguna es vital para la biodiversidad regional, albergando especies de flora y fauna únicas, y contribuyendo a la regulación hídrica y climática. El entorno es ideal para la observación de aves, la investigación ambiental y el turismo ecológico.\n\nCoba Negra es símbolo de la relación entre naturaleza y cultura en Nariño, promoviendo el respeto y la protección de los recursos naturales.',
    description: 'Misteriosa laguna de aguas oscuras y entorno natural.',
    activities: lagunaCobaNegraActivities,
  ),
  Destination(
    imageUrl: 'assets/images/ecoparque.jpg',
    city: 'Haciendas Cafeteras',
    country: 'Buesaco',
    description: 'Ecoparque y Café especial de altura y haciendas cafeteras.',
    historyAndInfo:
        'Las Haciendas Cafeteras de Buesaco son reconocidas a nivel nacional por la producción de café especial de altura, resultado de la combinación entre clima, suelo y tradición agrícola. Los ecoparques ofrecen experiencias de agroturismo, donde los visitantes pueden conocer el proceso de cultivo, cosecha y preparación del café, así como disfrutar de actividades recreativas y educativas.\n\nLa región es ejemplo de innovación rural, integración comunitaria y conservación ambiental, promoviendo el desarrollo sostenible y la valoración de la cultura cafetera en Nariño.',
    activities: narinoActivities,
  ),
  Destination(
    imageUrl: 'assets/images/sombrero_paja.jpeg',
    city: 'Sombreros de Paja Toquilla',
    country: 'Sandoná',
    description: 'Sombreros de paja toquilla patrimonio cultural.',
    historyAndInfo:
        'Sandoná es el principal productor colombiano de sombreros tejidos en paja toquilla, una tradición artesanal que se remonta al siglo XIX. El arte de tejer sombreros y accesorios con fibras naturales de iraca ha sido transmitido por generaciones, convirtiéndose en símbolo de identidad y patrimonio cultural.\n\nLa elaboración de estos artículos artesanales es fuente de ingresos y atractivo turístico, destacando la destreza y creatividad de los artesanos sandoneños. El municipio celebra ferias y festividades dedicadas a la artesanía, promoviendo la integración social y el reconocimiento nacional e internacional.',
    activities: sandonaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/balneario_los_rosales.JPG',
    city: 'Balneario Los Rosales',
    country: 'Samaniego',
    description: 'excelente clima y hermoso balneario para el descanso.',
    historyAndInfo:
        'El Balneario Los Rosales, en Samaniego, es un espacio natural de aguas termales y clima agradable, ideal para el descanso y la recreación. El sitio es punto de encuentro para turistas y locales, promoviendo el turismo sostenible y la integración comunitaria.\n\nLos Rosales ofrece servicios de hospedaje, gastronomía y actividades de bienestar, en un entorno de belleza paisajística y tranquilidad. El balneario es ejemplo de aprovechamiento responsable de los recursos naturales y de desarrollo turístico en Nariño.',
    activities: consacaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/mirador_chimayoy.jpg',
    city: 'Mirador de Chimayoy',
    country: 'Pasto',
    description: 'Mirador de Chimayoy y páramos únicos.',
    historyAndInfo:
        'El Mirador de Chimayoy, situado a pocos kilómetros de Pasto, es un centro ambiental y turístico que ofrece vistas panorámicas de los páramos, montañas y valles andinos. Chimayoy, que en lengua quillasinga significa "ir al encuentro con el sol", es espacio de educación ambiental, investigación y conservación ecológica.\n\nEl lugar cuenta con senderos ecológicos, actividades educativas y proyectos de integración comunitaria, promoviendo la valoración y protección de los ecosistemas de alta montaña. Chimayoy es referente de turismo ecológico y desarrollo sostenible en Nariño.',
    activities: tanguaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/piedra_bolivar.jpg',
    city: 'Piedra de Bolívar',
    country: 'Consaca',
    description: 'Piedra de Bolívar y formaciones rocosas.',
    historyAndInfo:
        'La Piedra de Bolívar, en Consaca, es una formación rocosa de gran valor histórico y simbólico. Conmemora la Batalla de Bomboná, uno de los episodios más importantes de la campaña libertadora en Colombia. El sitio es visitado por su valor histórico, sus paisajes únicos y la posibilidad de realizar actividades de senderismo y observación de flora y fauna.\n\nLa Piedra de Bolívar es símbolo de la identidad andina y de la memoria colectiva de Nariño, integrando historia, naturaleza y turismo cultural.',
    activities: mallamaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/paramo_frailejones.jpg',
    city: 'Paramo de Frailejones',
    country: 'Chiles',
    description: 'Páramos, Volcan y Termales.',
    historyAndInfo:
        'El Páramo de Frailejones, en Chiles, es un ecosistema de alta montaña que alberga especies endémicas de flora y fauna, siendo fuente de agua y vida para la región. El páramo es escenario de procesos ecológicos fundamentales, como la captación y regulación hídrica, la conservación de la biodiversidad y la adaptación al cambio climático.\n\nEl lugar es ideal para el turismo de naturaleza, la investigación científica y la educación ambiental, promoviendo la protección de los recursos naturales y la integración comunitaria.',
    activities: funesActivities,
  ),
  Destination(
    imageUrl: 'assets/images/dedo_de_Dios.jpg',
    city: 'El dedo de Dios',
    country: 'Mallama',
    description: 'majestuoso cerro con formaciones rocosas únicas .',
    historyAndInfo:
        'El Dedo de Dios, en Mallama, es un cerro majestuoso con formaciones rocosas únicas que han inspirado leyendas, rituales y expresiones de espiritualidad. El sitio es apreciado por su belleza natural, la posibilidad de realizar actividades de senderismo y la importancia cultural para las comunidades locales.\n\nEl Dedo de Dios es símbolo de la relación entre el ser humano y la naturaleza, promoviendo el turismo responsable y la valoración del patrimonio geológico y cultural de Nariño.',
    activities: puerresActivities,
  ),
  Destination(
    imageUrl: 'assets/images/cascada_chihuacos.jpg',
    city: 'Cascadas de Chihuacos',
    country: 'Potosi',
    description: 'hermosa cascada en entorno natural y el sol de los pastos',
    historyAndInfo:
        'Las Cascadas de Chihuacos, en Potosí, son un tesoro natural formado por caídas de agua rodeadas de montañas y vegetación nativa. El lugar es ideal para el ecoturismo, la observación de flora y fauna, y la realización de actividades recreativas y educativas.\n\nLas cascadas son símbolo de la riqueza hídrica y paisajística de Nariño, promoviendo la conservación ambiental y el desarrollo sostenible en la región.',
    activities: ospinaActivities,
  ),
  Destination(
    imageUrl: 'assets/images/cascada_la_paila.jpg',
    city: 'Cascada de la Paila',
    country: 'Pupiales',
    description: 'Manglares y ecoturismo marino del Pacífico.',
    historyAndInfo:
        'La Cascada de la Paila, en Pupiales, es un atractivo natural que destaca por la presencia de manglares, aguas cristalinas y biodiversidad marina. El sitio es refugio de especies de flora y fauna, y promueve la conservación ambiental y el ecoturismo marino.\n\nLa Cascada de la Paila es ejemplo de integración entre turismo, educación ambiental y protección de los ecosistemas acuáticos en Nariño.',
    activities: franciscoPizarroActivities,
  ),
  Destination(
    imageUrl: 'assets/images/carnaval_blancos_negros.jpg',
    city: 'Carnaval de Blancos y Negros',
    country: 'Todo el departamento de Nariño',
    description: 'Patrimonio Cultural Inmaterial de la Humanidad.',
    historyAndInfo:
        'El Carnaval de Blancos y Negros, celebrado anualmente en Pasto y otros municipios de Nariño, es una de las fiestas más emblemáticas de Colombia. Declarado Patrimonio Cultural Inmaterial de la Humanidad por la UNESCO, el carnaval tiene raíces prehispánicas, andinas e hispánicas, y se ha consolidado como símbolo de identidad, integración y creatividad.\n\nDurante el carnaval, la ciudad se llena de color, música, carrozas y expresiones artísticas que reivindican el legado afro, indígena y mestizo. El evento incluye el Desfile de las Colonias, el Día de los Negros y el Día de los Blancos, donde la comunidad celebra la diversidad y la unidad.\n\nEl carnaval es motor de desarrollo cultural, turístico y económico, promoviendo la participación ciudadana y el reconocimiento internacional de Nariño.',
    activities: carnavalActivities,
  ),
  Destination(
    imageUrl: 'assets/images/museo_carnaval.jpg',
    city: 'Museo del Carnaval',
    country: 'Pasto',
    description: 'Historia y tradición del Carnaval de Blancos y Negros.',
    historyAndInfo:
        'El Museo del Carnaval, ubicado en Pasto, es un espacio dedicado a la preservación, exhibición y difusión de la historia y tradición del Carnaval de Blancos y Negros. El museo alberga colecciones de carrozas, trajes, fotografías y documentos que narran la evolución del carnaval y su impacto en la cultura nariñense.\n\nEs punto de encuentro para turistas, investigadores y artistas, promoviendo el estudio y la valoración de las expresiones culturales de la región. El museo contribuye al fortalecimiento de la identidad local y al reconocimiento internacional del carnaval.',
    activities: museoCarnavalActivities,
  ),
  Destination(
    imageUrl: 'assets/images/canon_juanambu.jpg',
    city: 'Cañón de Juanambú',
    country: 'Buesaco',
    description: 'Formación geológica espectacular y biodiversidad.',
    historyAndInfo:
        'El Cañón de Juanambú, en Buesaco, es una formación geológica de gran belleza y relevancia histórica. El cañón fue escenario de la Batalla de Juanambú durante la campaña libertadora, y hoy es símbolo de la biodiversidad y el potencial turístico de la región.\n\nEl sitio ofrece oportunidades para el turismo de aventura, el senderismo y la observación de paisajes únicos, integrando historia, naturaleza y desarrollo local.',
    activities: canonJuanambuActivities,
  ),
  Destination(
    imageUrl: 'assets/images/cascada_wilke.jpg',
    city: 'Cascadas de Wilke',
    country: 'La Florida',
    description: 'Cascadas Blanca y Negra en paisaje tropical.',
    historyAndInfo:
        'Las Cascadas de Wilke, en La Florida, son un conjunto de caídas de agua rodeadas de paisajes tropicales y biodiversidad. El entorno es refugio de especies de flora y fauna, y promueve la conservación ambiental y el turismo ecológico.\n\nLas cascadas son ejemplo de la riqueza natural de Nariño y de la importancia de proteger los ecosistemas acuáticos y terrestres.',
    activities: cascadasWilkActivities,
  ),
  Destination(
    imageUrl: 'assets/images/osos_anteojos.jpg',
    city: 'Reserva Osos de Anteojos',
    country: 'La Planada',
    description: 'Observación del oso andino en su hábitat natural.',
    historyAndInfo:
        'La Reserva Osos de Anteojos, ubicada en La Planada, es un área protegida dedicada a la conservación del oso andino, especie emblemática y vulnerable de los Andes colombianos. La reserva es gestionada por la comunidad Awá, quienes han desarrollado proyectos de educación ambiental, investigación y turismo responsable.\n\nEl área alberga una gran diversidad de flora y fauna, siendo clave para la protección de especies amenazadas y la promoción de la integración comunitaria. La reserva es ejemplo de conservación participativa y de la relación armoniosa entre cultura y naturaleza en Nariño.',
    activities: ososAntejosActivities,
  ),
];
// Actividades específicas para Laguna de Azufral
List<Activity> azufralActivities = [
  Activity(
    imageUrl: 'assets/images/observacion_geologica.jpg',
    historyAndInfo:
        'Tesoro natural en San Pablo, caídas de agua rodeadas de montañas y vegetación nativa.',
    name: 'Observación Geológica',
    type: 'Ciencia y Naturaleza',
    startTimes: ['9:00 am'],
    rating: 4,
    price: 5000,
  ),
  Activity(
    historyAndInfo:
        'Especie vulnerable, protegida en la Reserva La Planada, gestionada por la comunidad Awá.',
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
