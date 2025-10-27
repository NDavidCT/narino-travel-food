import 'package:narino_travel_food/models/food.dart';

class Restaurant {
  String? imageUrl;
  String? name;
  String? address;
  String? description;
  int? rating;
  List<Food>? menu;

  Restaurant({
    this.imageUrl,
    this.name,
    this.address,
    this.description,
    this.rating,
    this.menu,
  });

  // Métodos para serialización JSON
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'address': address,
      'description': description,
      'rating': rating,
      'menu': menu?.map((food) => food.toJson()).toList(),
    };
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      imageUrl: json['imageUrl'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
      rating: json['rating'],
      menu: json['menu'] != null
          ? (json['menu'] as List)
              .map((foodJson) => Food.fromJson(foodJson))
              .toList()
          : null,
    );
  }
}

List<Restaurant> restaurants = [
  Restaurant(
    imageUrl: 'assets/images/cuy_asado.jpg',
    name: 'Cuy Asado',
    address: 'El plato tradicional de Nariño',
    description:
        'El cuy asado es uno de los platos más emblemáticos de la gastronomía de Nariño. Su preparación es un arte que se ha transmitido de generación en generación, resultando en una carne tierna y jugosa con una piel crujiente y dorada. Es una experiencia culinaria única.',
    rating: 5,
    menu: [],
  ),
  Restaurant(
    imageUrl: 'assets/images/cerdo_hornado.jpg',
    name: 'Cerdo Hornado',
    address: 'Una delicia de la región andina',
    description:
        'El cerdo hornado, una verdadera delicia andina, se cocina lentamente hasta que su carne se vuelve increíblemente suave. Se sirve con papas, mote y ají, creando una combinación de sabores y texturas que capturan la esencia de la cocina de la región.',
    rating: 4,
    menu: [],
  ),
  Restaurant(
    imageUrl: 'assets/images/frito_pastuso.jpg',
    name: 'Frito Pastuso',
    address: 'El sabor único de la comida pastusa',
    description:
        'El frito pastuso es una explosión de sabor. Compuesto por carne de cerdo frita, papas, mote y un guiso especial, este plato es un pilar de la cocina local. Es una comida contundente y sabrosa que te dejará con ganas de más.',
    rating: 3,
    menu: [],
  ),
  Restaurant(
    imageUrl: 'assets/images/pan_maiz.jpg',
    name: 'Pan de Maíz',
    address: 'Tradición ancestral en cada bocado',
    description:
        'El pan de maíz es una delicia tradicional de Nariño, elaborado con maíz molido y cocido al horno. Su sabor y textura únicos lo convierten en un acompañante perfecto para las comidas típicas de la región.',
    rating: 4,
    menu: [],
  ),
  Restaurant(
    imageUrl: 'assets/images/dulces_tradicionales.jpg',
    name: 'Dulces Tradicionales',
    address: 'Sabores dulces de la cultura nariñense',
    description:
        'Los dulces tradicionales de Nariño, como el manjar blanco, las cocadas y los alfandoques, son parte esencial de la gastronomía local. Cada uno refleja la creatividad y el sabor de la región.',
    rating: 4,
    menu: [],
  ),
  Restaurant(
    imageUrl: 'assets/images/bebidas_tradicionales.jpg',
    name: 'Bebidas Tradicionales',
    address: 'Refrescos y sabores autóctonos',
    description:
        'Las bebidas tradicionales de Nariño, como la chicha, el hervido y el canelazo, acompañan las celebraciones y comidas típicas. Son el reflejo de la identidad y hospitalidad de la región.',
    rating: 4,
    menu: [],
  ),
];
