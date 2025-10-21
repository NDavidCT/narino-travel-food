import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Muestra un indicador de carga mientras se verifica el estado inicial
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.green),
                  SizedBox(height: 20),
                  Text('Verificando autenticación...')
                ],
              ),
            ),
          );
        }

        // Si hay error en el stream
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 60),
                  const SizedBox(height: 20),
                  const Text('Error de autenticación'),
                  const SizedBox(height: 10),
                  Text('${snapshot.error}'),
                ],
              ),
            ),
          );
        }

        // Si el usuario está conectado, mostrar la página principal
        if (snapshot.hasData && snapshot.data != null) {
          return const HomePage();
        }

        // Si no está conectado, vamos al Login
        else {
          return const LoginScreen();
        }
      },
    );
  }
}
