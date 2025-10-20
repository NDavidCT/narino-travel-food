import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart'; // Importamos el nuevo contenedor
import 'login_screen.dart';
import '../services/auth_cache.dart'; // Importamos las optimizaciones

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthCache.authStateChanges, // Usar stream optimizado
      builder: (context, snapshot) {
        // Verificación rápida del cache antes del stream
        final cachedUser = AuthCache.getCurrentUser();
        if (cachedUser != null && !snapshot.hasData) {
          return const MainScreen();
        }

        // Muestra un indicador de carga mientras se verifica el estado inicial
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.red),
            ),
          );
        }

        // Si el usuario está conectado, vamos al contenedor principal (con el menú)
        if (snapshot.hasData) {
          return const MainScreen();
        }

        // Si no está conectado, vamos al Login
        else {
          return const LoginScreen();
        }
      },
    );
  }
}
