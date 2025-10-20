import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:narino_travel_food/firebase_options.dart';

// Importamos las páginas principales
import 'package:narino_travel_food/pages/auth_page.dart';
import 'package:narino_travel_food/pages/main_screen.dart';
import 'package:narino_travel_food/pages/all_destinations_page.dart';
import 'package:narino_travel_food/pages/map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    runApp(ErrorApp(error: e.toString()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nariño Travel & Food',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:
            Colors.green, // Verde para representar la naturaleza de Nariño
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
        // Optimizaciones de rendimiento
        useMaterial3: true,
        splashFactory: InkRipple.splashFactory,
      ),
      // Rutas de la aplicación
      routes: {
        '/all-destinations': (context) => const AllDestinationsPage(),
        '/map': (context) => const MapPage(),
      },
      // Restaurar la funcionalidad completa con AuthPage
      home: const AuthPage(),
    );
  }
}

// Widget de error en caso de que Firebase no se inicialice correctamente
class ErrorApp extends StatelessWidget {
  final String error;

  const ErrorApp({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              const SizedBox(height: 16),
              const Text(
                'Error de inicialización',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla de prueba simple
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nariño Travel & Food'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              '¡App Funcionando!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nariño Travel & Food está activa',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
