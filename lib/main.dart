import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:narino_travel_food/firebase_options.dart';
import 'dart:html' as html;

// Importamos las páginas principales
import 'package:narino_travel_food/pages/auth_page.dart';
import 'package:narino_travel_food/pages/all_destinations_page.dart';
import 'package:narino_travel_food/pages/map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Intentar inicializar Firebase con múltiples estrategias
  bool firebaseInitialized = false;
  
  try {
    print('🔥 Estrategia 1: Verificando Firebase apps...');
    
    // Verificar de forma más segura si Firebase está disponible
    final apps = Firebase.apps;
    print('📱 Apps encontradas: ${apps.length}');
    
    if (apps.isEmpty) {
      print('📱 Inicializando Firebase...');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('✅ Firebase inicializado correctamente');
    } else {
      print('✅ Firebase ya estaba inicializado');
    }
    
    firebaseInitialized = true;
    
  } catch (e) {
    print('❌ Estrategia 1 falló: $e');
    
    try {
      print('� Estrategia 2: Inicialización directa...');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      firebaseInitialized = true;
      print('✅ Firebase inicializado en estrategia 2');
    } catch (e2) {
      print('❌ Estrategia 2 también falló: $e2');
      firebaseInitialized = false;
    }
  }

  // Ejecutar la app según el resultado
  if (firebaseInitialized) {
    print('🚀 Iniciando app CON Firebase...');
    runApp(const MyApp());
  } else {
    print('🔄 Iniciando app SIN Firebase...');
    runApp(const MyAppWithoutFirebase());
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
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
        useMaterial3: true,
        splashFactory: InkRipple.splashFactory,
      ),
      // Rutas de la aplicación
      routes: {
        '/all-destinations': (context) => const AllDestinationsPage(),
        '/map': (context) => const MapPage(),
      },
      // Usar AuthPage como página principal
      home: const AuthPage(),
    );
  }
}

// App de respaldo sin Firebase
class MyAppWithoutFirebase extends StatelessWidget {
  const MyAppWithoutFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nariño Travel & Food - Sin Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nariño Travel & Food'),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning, color: Colors.orange, size: 80),
                const SizedBox(height: 20),
                const Text(
                  'Modo sin Firebase',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'La aplicación funciona pero sin autenticación.\n'
                  'Firebase no se pudo inicializar correctamente.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Flutter Web funciona correctamente'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Probar Flutter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () {
                    // Recargar la página para intentar nuevamente
                    html.window.location.reload();
                  },
                  child: const Text('Reintentar Firebase'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}