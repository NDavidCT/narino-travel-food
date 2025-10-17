import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ipi_deli_tour/firebase_options.dart';

// Importamos la nueva AuthPage que maneja la lógica de login/home
import 'package:ipi_deli_tour/pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ipi Deli Tour',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      // Manda directamente a la AuthPage para manejar el flujo de sesión.
      home: const AuthPage(),
    );
  }
}
