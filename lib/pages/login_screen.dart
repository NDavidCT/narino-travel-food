import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/google_sign_in_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  // LÓGICA DE LOGIN CON CORREO Y CONTRASEÑA
  Future<void> _signInWithEmail() async {
    setState(() {
      _errorMessage = null;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'No se encontró un usuario con ese correo.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Contraseña incorrecta.';
        } else {
          _errorMessage = 'Error de inicio de sesión: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ocurrió un error inesperado: $e';
      });
    }
  }

  // LÓGICA DE LOGIN CON GOOGLE
  Future<void> _signInWithGoogle() async {
    setState(() {
      _errorMessage = null;
    });
    try {
      // Usar signInSilently en web para evitar popups cuando sea posible.
      GoogleSignInAccount? googleUser;
      if (kIsWeb) {
        googleUser = await googleSignIn.signInSilently();
        if (googleUser == null) {
          // Pide confirmación antes de abrir popup
          final bool? openPopup = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Iniciar sesión con Google'),
              content: const Text(
                  'Se abrirá una ventana emergente para iniciar sesión. Asegúrate de permitir ventanas emergentes y cookies para localhost. ¿Deseas continuar?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Continuar'),
                ),
              ],
            ),
          );

          if (openPopup == true) {
            googleUser = await googleSignIn.signIn();
          } else {
            // Usuario canceló
            return;
          }
        }
      } else {
        // No web: flujo normal
        googleUser = await googleSignIn.signIn();
      }

      if (googleUser == null) {
        // El usuario canceló o no se obtuvo cuenta
        return;
      }

      // 2. Obtener los detalles de autenticación de la solicitud
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 3. Iniciar sesión en Firebase con las credenciales de Google
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = 'Error con Google Sign-In: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ocurrió un error inesperado: $e';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Utilizamos Stack para colocar la imagen de fondo detrás de todo
      body: Stack(
        children: [
          // 1. IMAGEN DE FONDO (Utiliza una imagen que ya debe estar en 'assets/images/')
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // Recomiendo usar una imagen de Ipiales o de Las Lajas que ya tienes
                image: AssetImage('assets/images/santuario_lajas.jpg'),
                fit: BoxFit.cover, // Cubre toda la pantalla
              ),
            ),
          ),

          // 2. CAPA DE SOMBRA (OVERLAY) para mejorar la legibilidad del texto
          Container(
            color:
                Colors.black.withOpacity(0.6), // Tono oscuro y semitransparente
          ),

          // 3. CONTENIDO PRINCIPAL (Formulario)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TÍTULO DE LA APLICACIÓN
                  const Text(
                    'Ipi Deli Tour',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Letras blancas
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Iniciar Sesión',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white70, // Letras blancas sutiles
                    ),
                  ),
                  const SizedBox(height: 40),

                  // MENSAJE DE ERROR
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

                  // CAMPO CORREO
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                        color: Colors.white), // Texto escrito en blanco
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      labelStyle: const TextStyle(color: Colors.white70),
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white
                          .withOpacity(0.1), // Fondo semitransparente
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // Bordes sutiles
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

                  // CAMPO CONTRASEÑA
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
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

                  // BOTÓN INICIAR SESIÓN (CORREO)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signInWithEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600, // Rojo vibrante
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: const Text('Ingresar',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // SEPARADOR
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

                  // BOTÓN INICIAR SESIÓN (GOOGLE)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _signInWithGoogle,
                      icon: const Icon(Icons.g_mobiledata, size: 28),
                      label: const Text('Continuar con Google'),
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

                  // ENLACE A REGISTRO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿No tienes una cuenta?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: Text('Regístrate Aquí',
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
