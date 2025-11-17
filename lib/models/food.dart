// Modelo para alimentos típicos (platos, bebidas, etc.)
// Incluye información básica y métodos para convertir a JSON
class Food {
  String? imageUrl; // URL de la imagen del alimento
  String? name; // Nombre del alimento
  double? price; // Precio
  String? description; // Descripción del alimento

  Food({
    this.imageUrl,
    this.name,
    this.price,
    this.description,
  });

  // Convierte el alimento a un mapa para guardar en JSON
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'description': description,
    };
  }

  // Crea un alimento desde un mapa JSON
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      imageUrl: json['imageUrl'],
      name: json['name'],
      price: json['price']?.toDouble(),
      description: json['description'],
    );
  }
}
