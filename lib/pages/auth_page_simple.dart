import 'package:flutter/material.dart';
import 'main_screen.dart'; // Importamos el nuevo contenedor

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // MODO TEMPORAL: Ir directamente a la pantalla principal
    // sin autenticación para probar la app
    return const MainScreen();
  }
}
