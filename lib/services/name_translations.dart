// Nombres en inglés de destinos y restaurantes (la clave es el nombre en español)
import 'package:flutter/widgets.dart';

const Map<String, String> _englishNames = {
  // Destinos
  'Santuario de Nuestra Señora de Las Lajas':
      'Sanctuary of Our Lady of Las Lajas',
  'Laguna de Azufral': 'Azufral Lagoon',
  'Laguna de la Cocha': 'La Cocha Lagoon',
  'Volcán Galeras': 'Galeras Volcano',
  'Centro Histórico de Pasto': 'Historic Center of Pasto',
  'Playas de Tumaco': 'Tumaco Beaches',
  'Volcán Cumbal': 'Cumbal Volcano',
  'Laguna de La Bolsa': 'La Bolsa Lagoon',
  'Katza Pi': 'Katza Pi',
  'Río Telembí': 'Telembí River',
  'Reservas Naturales de El Tambo': 'El Tambo Nature Reserves',
  'Hacienda Alsacia': 'Alsacia Estate',
  'Pedregal Rio': 'Pedregal River',
  'Paramo Paja Blanca': 'Paja Blanca Páramo',
  'centro recreacional Comfamiliar': 'Comfamiliar Recreation Center',
  'laguna Coba Negra': 'Coba Negra Lagoon',
  'Haciendas Cafeteras': 'Coffee Estates',
  'Sombreros de Paja Toquilla': 'Toquilla Straw Hats',
  'Balneario Los Rosales': 'Los Rosales Swimming Resort',
  'Mirador de Chimayoy': 'Chimayoy Viewpoint',
  'Piedra de Bolívar': "Bolívar's Rock",
  'Termales de Chiles': 'Chiles Hot Springs',
  'El dedo de Dios': "God's Finger",
  'Cascadas de Chihuacos': 'Chihuacos Waterfalls',
  'Cascada de la Paila': 'La Paila Waterfall',
  'Carnaval de Blancos y Negros': 'Blacks and Whites Carnival',
  'Museo del Carnaval': 'Carnival Museum',
  'Cañón de Juanambú': 'Juanambú Canyon',
  'Cascadas de Wilke': 'Wilke Waterfalls',
  'Osos de Anteojos': 'Spectacled Bears',
  'Cascada la Chilidoña': 'La Chilidoña Waterfall',
  'Finca Carmen Amelia': 'Carmen Amelia Farm',
  // Restaurantes
  'Cuy Asado': 'Roasted Guinea Pig',
  'Cerdo Hornado': 'Roasted Pork',
  'Frito Pastuso': 'Pasto-Style Fried Pork',
  'Pan de Maíz': 'Corn Bread',
  'Dulces Tradicionales': 'Traditional Sweets',
  'Bebidas Tradicionales': 'Traditional Drinks',
};

// Borrador de nombres en Kichwa (pendiente de revisión por un hablante nativo)
const Map<String, String> _kichwaNames = {
  'Santuario de Nuestra Señora de Las Lajas': 'Las Lajas Mamapak Wasi',
  'Laguna de Azufral': 'Azufral Kucha',
  'Laguna de la Cocha': 'La Cocha Kucha',
  'Volcán Galeras': 'Galeras Nina Urku',
  'Centro Histórico de Pasto': 'Pasto Ñawpa Llakta',
  'Playas de Tumaco': 'Tumaco Mama Kucha Kuchu',
  'Volcán Cumbal': 'Cumbal Nina Urku',
  'Laguna de La Bolsa': 'La Bolsa Kucha',
  'Katza Pi': 'Katza Pi',
  'Río Telembí': 'Telembí Mayu',
  'Reservas Naturales de El Tambo': 'El Tambo Sacha Waykakuna',
  'Hacienda Alsacia': 'Alsacia Hacienda',
  'Pedregal Rio': 'Pedregal Mayu',
  'Paramo Paja Blanca': 'Paja Blanca Paramu',
  'centro recreacional Comfamiliar': 'Comfamiliar Pukllana Wasi',
  'laguna Coba Negra': 'Coba Negra Kucha',
  'Haciendas Cafeteras': 'Kapi Hacienda kuna',
  'Sombreros de Paja Toquilla': 'Toquilla Ukukuna Muyu',
  'Balneario Los Rosales': 'Los Rosales Armana Wasi',
  'Mirador de Chimayoy': 'Chimayoy Rikuna Urku',
  'Piedra de Bolívar': 'Bolívar Rumi',
  'Termales de Chiles': 'Chiles Rupak Yaku',
  'El dedo de Dios': 'Taytapak Ruka',
  'Cascadas de Chihuacos': 'Chihuacos Pachakuna',
  'Cascada de la Paila': 'La Paila Paccha',
  'Carnaval de Blancos y Negros': 'Yurak Yana Karnaval',
  'Museo del Carnaval': 'Karnaval Museo',
  'Cañón de Juanambú': 'Juanambú Wayku',
  'Cascadas de Wilke': 'Wilke Pachakuna',
  'Osos de Anteojos': 'Ukumari kuna',
  'Cascada la Chilidoña': 'La Chilidoña Paccha',
  'Finca Carmen Amelia': 'Carmen Amelia Chakra',
  'Cuy Asado': 'Kankashka Kuy',
  'Cerdo Hornado': 'Hornado Kuchi',
  'Frito Pastuso': 'Pasto Frito',
  'Pan de Maíz': 'Sara Tanta',
  'Dulces Tradicionales': 'Ñawpa Mishki Mikuykuna',
  'Bebidas Tradicionales': 'Ñawpa Upyanakuna',
};
// Devuelve el nombre en inglés o Kichwa según el idioma; si no existe, el original.
String localizedName(BuildContext context, String? name) {
  final original = name ?? '';
  switch (Localizations.localeOf(context).languageCode) {
    case 'en':
      return _englishNames[original] ?? original;
    case 'qu':
      return _kichwaNames[original] ?? original;
    default:
      return original;
  }
}