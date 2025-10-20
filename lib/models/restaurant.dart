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
];
