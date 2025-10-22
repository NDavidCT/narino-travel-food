class Activity {
  String? imageUrl;
  String? name;
  String? type;
  List<String>? startTimes;
  int? rating;
  int? price; // <<-- Tipo 'int' (entero) es el correcto para COP

  Activity({
    this.imageUrl,
    this.name,
    this.type,
    this.startTimes,
    this.rating,
    this.price,
  });

  // Métodos para serialización JSON
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'type': type,
      'startTimes': startTimes,
      'rating': rating,
      'price': price,
    };
  }

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
    );
  }
}
