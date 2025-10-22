class Food {
  String? imageUrl;
  String? name;
  double? price;
  String? description;

  Food({
    this.imageUrl,
    this.name,
    this.price,
    this.description,
  });

  // Métodos para serialización JSON
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'description': description,
    };
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      imageUrl: json['imageUrl'],
      name: json['name'],
      price: json['price']?.toDouble(),
      description: json['description'],
    );
  }
}
