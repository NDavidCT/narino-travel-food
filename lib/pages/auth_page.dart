// Pantalla de autenticación principal
// Permite gestionar el acceso de usuarios a la app
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'main_screen.dart';
import '../l10n/app_localizations.dart';

// Esta página decide si mostrar el login o la pantalla principal según el estado de autenticación
class AuthPage extends StatelessWidget {
  // Función para cambiar el idioma
  final void Function(Locale)? onLocaleChanged;
  // Idioma actual
  final Locale? currentLocale;
  const AuthPage({super.key, this.onLocaleChanged, this.currentLocale});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder escucha los cambios de autenticación en Firebase
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Muestra un indicador de carga mientras se verifica el estado inicial
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.green),
                  const SizedBox(height: 20),
                  // Mensaje de verificación
                  Text(AppLocalizations.of(context)?.verifyingAuth ??
                      'Verificando autenticación...')
                ],
              ),
            ),
          );
        }

        // Si hay error en el stream, muestra mensaje de error
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

        // Si el usuario está conectado, mostrar la pantalla principal
        if (snapshot.hasData && snapshot.data != null) {
          return MainScreen(
            initialIndex: 1,
            onLocaleChanged: onLocaleChanged,
            currentLocale: currentLocale,
          );
        }

        // Si no está conectado, mostrar la pantalla de login
        else {
          return LoginScreen(
            onLocaleChanged: onLocaleChanged,
            currentLocale: currentLocale,
          );
        }
      },
    );
  }
}
