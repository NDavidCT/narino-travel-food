// Modelo para actividades turísticas (ej: tours, eventos, etc.)
// Incluye información básica y métodos para convertir a JSON
class Activity {
  String? imageUrl; // URL de la imagen de la actividad
  String? name; // Nombre de la actividad
  String? type; // Tipo de actividad (ej: cultural, aventura)
  List<String>? startTimes; // Horarios de inicio
  int? rating; // Calificación de la actividad
  int? price; // Precio por persona
  String? historyAndInfo; // Historia e información relevante

  Activity({
    this.imageUrl,
    this.name,
    this.type,
    this.startTimes,
    this.rating,
    this.price,
    this.historyAndInfo,
  });

  // Convierte la actividad a un mapa para guardar en JSON
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'type': type,
      'startTimes': startTimes,
      'rating': rating,
      'price': price,
      'historyAndInfo': historyAndInfo,
    };
  }

  // Crea una actividad desde un mapa JSON
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      imageUrl: json['imageUrl'],
      name: json['name'],
      type: json['type'],
      startTimes: json['startTimes'] != null
          ? List<String>.from(json['startTimes'])
          : null,
      rating: json['rating'],
      price: json['price'],
      historyAndInfo: json['historyAndInfo'],
    );
  }
}
