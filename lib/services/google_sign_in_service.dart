// Configuración de Google Sign-In para autenticación con Google
// Permite iniciar sesión con cuentas de Google en web y móvil
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Instancia global de GoogleSignIn configurada con el Client ID de OAuth Web
final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId: kIsWeb
      ? '860020371265-ir9kl5fb30fbbtfa23nmtri91og4crp3.apps.googleusercontent.com'
      : null,
  scopes: <String>['email', 'profile'],
);
