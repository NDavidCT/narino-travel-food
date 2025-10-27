import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/google_sign_in_service.dart';
// Asegúrate de que estas importaciones sean correctas para tus archivos:
import 'home_page.dart';
import 'search_page.dart';
import 'favorites_page.dart';
import 'map_page.dart';
import '../widgets/language_selector.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  final void Function(Locale)? onLocaleChanged;
  final Locale? currentLocale;

  const MainScreen(
      {super.key,
      this.initialIndex = 1,
      this.onLocaleChanged,
      this.currentLocale});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    const SearchPage(),
    const HomePage(),
    const FavoritesPage(),
    const MapPage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Usamos el valor del widget
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // FUNCIÓN PARA CERRAR SESIÓN (Restaurada)
  void _signOut() async {
    try {
      // 1. Cerrar la sesión de Google en el dispositivo
      await googleSignIn.signOut();

      // 2. Cerrar la sesión de Firebase
      await FirebaseAuth.instance.signOut();

      print('Sesión cerrada completamente.');
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  } // WIDGET AUXILIAR PARA EL TÍTULO DEL APP BAR CON INFORMACIÓN DEL USUARIO

  // WIDGET AUXILIAR PARA EL HEADER PROFESIONAL CON BRANDING Y USUARIO

  Widget _buildProfessionalHeader() {
    // Obtiene el usuario de Firebase actualmente logueado
    final user = FirebaseAuth.instance.currentUser;
    // El texto a mostrar (Nombre del usuario o su correo)
    final profileText = user?.displayName ?? user?.email ?? 'Usuario';
    // La URL de la foto de perfil (si usa Google o proveedor con foto)
    String? profileImageUrl = user?.photoURL;

    // Mejora para fotos de Google: agregar parámetro de tamaño
    if (profileImageUrl != null &&
        profileImageUrl.contains('googleusercontent.com')) {
      // Remover parámetros existentes y agregar tamaño específico
      profileImageUrl = '${profileImageUrl.split('=')[0]}=s96-c';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. TÍTULO PRINCIPAL DE LA APP (MÁS PROMINENTE)
        const Text(
          'NARIÑO TRAVEL & FOOD',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 2.0,
                color: Colors.black26,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        // 2. LÍNEA DE USUARIO (MÁS SUTIL)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Lado izquierdo: Saludo + foto + nombre
            Expanded(
              child: Row(
                children: [
                  // Saludo "Hola,"
                  const Text(
                    'Hola, ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),

                  // Foto de perfil
                  ClipOval(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child:
                          profileImageUrl != null && profileImageUrl.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    profileImageUrl,
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: SizedBox(
                                            width: 12,
                                            height: 12,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1.5,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.account_circle,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.account_circle,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),
                    ),
                  ),

                  const SizedBox(width: 6),

                  // Nombre del usuario
                  Flexible(
                    child: Text(
                      profileText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Lado derecho: Botón cerrar sesión
            TextButton.icon(
              onPressed: _signOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white70,
                size: 18,
              ),
              label: const Text(
                'Cerrar Sesión',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildProfessionalHeader()),
                if (widget.onLocaleChanged != null &&
                    widget.currentLocale != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: SizedBox(
                      height: 40,
                      child: Builder(
                        builder: (context) =>
                            // Importa el widget creado para el selector de idioma
                            // ignore: prefer_const_constructors
                            LanguageSelector(
                          currentLocale: widget.currentLocale!,
                          onLocaleChanged: widget.onLocaleChanged!,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),

      body: _pages[_selectedIndex],

      // BARRA DE NAVEGACIÓN INFERIOR (BottomNavigationBar)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
