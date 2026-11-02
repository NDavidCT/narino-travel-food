import 'package:flutter/material.dart';
import 'package:narino_travel_food/l10n/app_localizations.dart';
import 'package:narino_travel_food/l10n/kichwa_fallback_delegates.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:narino_travel_food/firebase_options.dart';
import 'package:flutter/foundation.dart';

// Importamos las páginas principales
import 'package:narino_travel_food/pages/auth_page.dart';
import 'package:narino_travel_food/pages/all_destinations_page.dart';
import 'package:narino_travel_food/pages/map_page.dart';

// Función principal que inicia la app
void main() async {
  // Necesario para inicializar plugins antes de correr la app
  WidgetsFlutterBinding.ensureInitialized();

  // Variable para saber si Firebase se inicializó correctamente
  bool firebaseInitialized = false;

  // Intentamos inicializar Firebase con dos estrategias
  try {
    print('🔥 Estrategia 1: Verificando Firebase apps...');

    // Verifica si ya hay apps de Firebase inicializadas
    final apps = Firebase.apps;
    print('📱 Apps encontradas: {apps.length}');

    if (apps.isEmpty) {
      // Si no hay, inicializa Firebase
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
      // Si falla la primera, intenta inicializar directamente
      print('🔥 Estrategia 2: Inicialización directa...');
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

  // Según el resultado, inicia la app con o sin Firebase
  if (firebaseInitialized) {
    print('🚀 Iniciando app CON Firebase...');
    runApp(const MyApp());
  } else {
    print('🔄 Iniciando app SIN Firebase...');
    runApp(const MyAppWithoutFirebase());
  }
}

// Widget principal de la app
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variable para guardar el idioma actual
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    // Intenta usar el idioma del sistema, si no, usa español
    try {
      final platformLocale = WidgetsBinding.instance.window.locale;
      _locale = platformLocale;
    } catch (_) {
      _locale = const Locale('es');
    }
  }

  // Función para cambiar el idioma
  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Configuración principal de la app
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
      locale: _locale, // Idioma actual
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...kichwaFallbackDelegates,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
        Locale('qu'),
        Locale('pt'),
        Locale('fr'),
        Locale('de'),
        Locale('zh'),
      ],
      // Rutas de navegación
      routes: {
        '/all-destinations': (context) => const AllDestinationsPage(),
        '/map': (context) => const MapPage(),
      },
      // Página de inicio (autenticación)
      home: AuthPage(
        onLocaleChanged: _setLocale,
        currentLocale: _locale,
      ),
    );
  }
}

// Widget alternativo si Firebase no se inicializa
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
                    // Muestra un mensaje de prueba
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
                    // Recargar la página solo en web
                    if (kIsWeb) {
                      // En web usaría JS para recargar
                      // html.window.location.reload();
                    }
                    // En cualquier plataforma, volver a intentar inicializar Firebase
                    main();
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
