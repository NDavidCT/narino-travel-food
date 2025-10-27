import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'main_screen.dart';
import '../l10n/app_localizations.dart';

class AuthPage extends StatelessWidget {
  final void Function(Locale)? onLocaleChanged;
  final Locale? currentLocale;
  const AuthPage({super.key, this.onLocaleChanged, this.currentLocale});

  @override
  Widget build(BuildContext context) {
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
                  Text(AppLocalizations.of(context)?.verifyingAuth ??
                      'Verificando autenticación...')
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

        // Si el usuario está conectado, mostrar la pantalla principal con navegación

        if (snapshot.hasData && snapshot.data != null) {
          return MainScreen(
            initialIndex: 1,
            onLocaleChanged: onLocaleChanged,
            currentLocale: currentLocale,
          );
        }

        // Si no está conectado, vamos al Login
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
