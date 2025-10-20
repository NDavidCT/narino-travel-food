import 'package:firebase_auth/firebase_auth.dart';

class AuthCache {
  // Cache para evitar múltiples verificaciones
  static User? _cachedUser;
  static DateTime? _lastCheck;
  static const Duration _cacheTimeout = Duration(minutes: 2);

  // Verificación rápida de usuario actual con cache
  static User? getCurrentUser() {
    final now = DateTime.now();

    // Si el cache es válido, devolverlo
    if (_cachedUser != null &&
        _lastCheck != null &&
        now.difference(_lastCheck!) < _cacheTimeout) {
      return _cachedUser;
    }

    // Actualizar cache
    _cachedUser = FirebaseAuth.instance.currentUser;
    _lastCheck = now;
    return _cachedUser;
  }

  // Limpiar caché al cerrar sesión
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      _clearCache();
    } catch (e) {
      // Manejar errores silenciosamente
    }
  }

  // Listener optimizado de cambios de autenticación
  static Stream<User?> get authStateChanges {
    return FirebaseAuth.instance.authStateChanges().map((user) {
      _cachedUser = user;
      _lastCheck = DateTime.now();
      return user;
    });
  }

  // Verificar si el usuario está autenticado sin hacer llamadas costosas
  static bool isUserSignedIn() {
    return getCurrentUser() != null;
  }

  // Limpiar cache manualmente
  static void _clearCache() {
    _cachedUser = null;
    _lastCheck = null;
  }

  // Refrescar cache
  static void refreshCache() {
    _clearCache();
    getCurrentUser();
  }
}
