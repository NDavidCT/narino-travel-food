// Pantalla de registro de usuario
// Permite crear una nueva cuenta en la app
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:narino_travel_food/l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controlador para el campo de correo
  final _emailController = TextEditingController();
  // Controlador para el campo de contraseña
  final _passwordController = TextEditingController();
  // Controlador para confirmar la contraseña
  final _confirmPasswordController = TextEditingController();
  // Variable para mostrar mensajes de error
  String? _errorMessage;

  // Método para registrar un nuevo usuario
  Future<void> _signUp() async {
    final l = AppLocalizations.of(context)!;
    setState(() {
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Verifica que las contraseñas sean iguales
    if (password != confirmPassword) {
      setState(() {
        _errorMessage = l.passwordsDontMatch;
      });
      return;
    }

    // Verifica que la contraseña tenga al menos 6 caracteres
    if (password.length < 6) {
      setState(() {
        _errorMessage = l.passwordTooShort;
      });
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Si el registro es exitoso, regresa a la pantalla de login
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Muestra mensajes de error amigables
        if (e.code == 'weak-password') {
          _errorMessage = l.weakPassword;
        } else if (e.code == 'email-already-in-use') {
          _errorMessage = l.emailInUse;
        } else if (e.code == 'invalid-email') {
          _errorMessage = l.invalidEmail;
        } else {
          _errorMessage = '${l.registerError}: ${e.message}';
        }
        print('Error de registro: ${e.message}');
      });
    } catch (e) {
      setState(() {
        _errorMessage = '${l.unexpectedError}: $e';
        print('Error inesperado: $e');
      });
    }
  }

  @override
  void dispose() {
    // Libera los controladores cuando se cierra la pantalla
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Construye la interfaz de usuario del registro
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createAccount),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icono de usuario
              const Icon(
                Icons.person_add,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 30),

              // Muestra mensaje de error si existe
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Campo para escribir el correo
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.emailLabel,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),

              // CAMPO CONTRASEÑA
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.passwordLabel,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),

              // CAMPO CONFIRMAR CONTRASEÑA
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.confirmPasswordLabel,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock_open),
                ),
              ),
              const SizedBox(height: 25),

              // BOTÓN REGISTRAR
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.registerAccount,
                      style: TextStyle(fontSize: 18)),
                ),
              ),

              const SizedBox(height: 20),

              // ENLACE A LOGIN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.haveAccountQuestion),
                  TextButton(
                    onPressed: () {
                      // Regresa a la pantalla de login
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.signInLink,
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
