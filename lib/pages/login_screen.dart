// Pantalla de login principal para la app Nariño Travel & Food
// Permite iniciar sesión con correo o Google, y navegar al registro
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/google_sign_in_service.dart';
import 'register_screen.dart';
import '../widgets/language_selector.dart';
import 'package:narino_travel_food/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  // Permite cambiar el idioma desde el login
  final void Function(Locale)? onLocaleChanged;
  final Locale? currentLocale;

  const LoginScreen({
    super.key,
    this.onLocaleChanged,
    this.currentLocale,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controlador para el campo de correo
  final _emailController = TextEditingController();
  // Controlador para el campo de contraseña
  final _passwordController = TextEditingController();
  // Variable para mostrar mensajes de error
  String? _errorMessage;

  // Inicia sesión usando correo y contraseña
  Future<void> _signInWithEmail() async {
    final l = AppLocalizations.of(context)!;
    setState(() {
      _errorMessage = null;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Si todo sale bien, el usuario entra a la app
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = l.userNotFound;
        } else if (e.code == 'wrong-password') {
          _errorMessage = l.wrongPassword;
        } else {
          _errorMessage = '${l.loginError}: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = '${l.unexpectedError}: $e';
      });
    }
  }

  // Inicia sesión usando Google
  Future<void> _signInWithGoogle() async {
    final l = AppLocalizations.of(context)!;
    setState(() {
      _errorMessage = null;
    });
    try {
      GoogleSignInAccount? googleUser;

      if (kIsWeb) {
        // En web, intenta primero sin mostrar ventana
        googleUser = await googleSignIn.signInSilently();
        // Si no funciona, muestra ventana de Google
        googleUser ??= await googleSignIn.signIn();
      } else {
        // En móvil o escritorio, flujo normal
        googleUser = await googleSignIn.signIn();
      }

      if (googleUser == null) {
        // Si el usuario cancela
        return;
      }

      // Obtiene credenciales de Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Inicia sesión en Firebase con Google
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = '${l.googleSignInError}: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _errorMessage = '${l.unexpectedError}: $e';
      });
    }
  }

  @override
  void dispose() {
    // Libera los controladores cuando se cierra la pantalla
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Construye la interfaz de usuario del login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Utilizamos Stack para poner la imagen de fondo y el formulario encima
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/santuario_lajas.jpg'),
                fit: BoxFit.cover, // Cubre toda la pantalla
              ),
            ),
          ),

          // Capa oscura para que el texto se vea mejor
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // Formulario principal
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Selector de idioma (si está disponible)
                  if (widget.onLocaleChanged != null &&
                      widget.currentLocale != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        height: 40,
                        child: LanguageSelector(
                          currentLocale: widget.currentLocale!,
                          onLocaleChanged: widget.onLocaleChanged!,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  // Logo de la aplicación
                  Center(
                    child: Semantics(
                      image: true,
                      label: 'Logo de Nariño Travel & Food',
                      child: Container(
                        width: MediaQuery.of(context).size.width > 600 ? 300 : 230,
                        height: MediaQuery.of(context).size.width > 600 ? 300 : 230,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Transform.scale(
                            scale: 1.06,
                            child: Image.asset(
                              'assets/images/logo_narino.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.tagline,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppLocalizations.of(context)!.signInTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Muestra mensaje de error si existe
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 179, 179),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Campo para escribir el correo
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.emailLabel,
                      labelStyle: const TextStyle(color: Colors.white70),
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                      ),
                      prefixIcon:
                          const Icon(Icons.email, color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Campo para escribir la contraseña
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.passwordLabel,
                      labelStyle: const TextStyle(color: Colors.white70),
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Botón para iniciar sesión con correo
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signInWithEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text(AppLocalizations.of(context)!.signInButton,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Línea separadora entre métodos de acceso
                  const Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.white30,
                        thickness: 1,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child:
                            Text('O', style: TextStyle(color: Colors.white70)),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.white30,
                        thickness: 1,
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Botón para iniciar sesión con Google
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _signInWithGoogle,
                      icon: const Icon(Icons.g_mobiledata, size: 28),
                      label: Text(AppLocalizations.of(context)!.continueWithGoogle),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Fondo blanco para Google
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Enlace para ir a la pantalla de registro
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.noAccountQuestion,
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          // Cuando se presiona, va a la pantalla de registro
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.registerHere,
                            style: TextStyle(
                                color: Colors.red.shade300,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
