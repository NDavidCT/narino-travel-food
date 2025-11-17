// Servicio para cachear el usuario autenticado y optimizar consultas
// Evita llamadas repetidas a FirebaseAuth y mejora el rendimiento
import 'package:firebase_auth/firebase_auth.dart';

class AuthCache {
  // Usuario cacheado
  static User? _cachedUser;
  static DateTime? _lastCheck;
  static const Duration _cacheTimeout = Duration(minutes: 2);

  // Obtiene el usuario actual usando cache
  static User? getCurrentUser() {
    final now = DateTime.now();
    // Si el cache es válido, lo devuelve
    if (_cachedUser != null &&
        _lastCheck != null &&
        now.difference(_lastCheck!) < _cacheTimeout) {
      return _cachedUser;
    }
    // Actualiza el cache
    _cachedUser = FirebaseAuth.instance.currentUser;
    _lastCheck = now;
    return _cachedUser;
  }

  // Cierra sesión y limpia el cache
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      _clearCache();
    } catch (e) {
      // Maneja errores silenciosamente
    }
  }

  // Escucha cambios de autenticación y actualiza el cache
  static Stream<User?> get authStateChanges {
    return FirebaseAuth.instance.authStateChanges().map((user) {
      _cachedUser = user;
      _lastCheck = DateTime.now();
      return user;
    });
  }

  // Verifica si el usuario está autenticado
  static bool isUserSignedIn() {
    return getCurrentUser() != null;
  }

  // Limpia el cache manualmente
  static void _clearCache() {
    _cachedUser = null;
    _lastCheck = null;
  }

  // Refresca el cache
  static void refreshCache() {
    _clearCache();
    getCurrentUser();
  }
}
