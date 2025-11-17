// Pantalla principal de la app
// Gestiona la navegación entre páginas y el estado global
import 'package:flutter/material.dart';
import 'package:narino_travel_food/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/google_sign_in_service.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'favorites_page.dart';
import 'map_page.dart';
import '../widgets/language_selector.dart';

class MainScreen extends StatefulWidget {
  // Permite cambiar el idioma desde la pantalla principal
  final int initialIndex;
  final void Function(Locale)? onLocaleChanged;
  final Locale? currentLocale;

  const MainScreen({
    super.key,
    this.initialIndex = 1,
    this.onLocaleChanged,
    this.currentLocale,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  // Lista de páginas que se muestran según el ítem seleccionado
  final List<Widget> _pages = [
    SearchPage(),
    HomePage(),
    FavoritesPage(),
    MapPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Comienza en la página indicada (por defecto: Home)
    _selectedIndex = widget.initialIndex;
  }

  // Cambia la página seleccionada
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Cierra la sesión del usuario (Google y Firebase)
  void _signOut() async {
    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      print('Sesión cerrada completamente.');
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  // Construye el encabezado profesional con nombre y foto de usuario
  Widget _buildProfessionalHeader() {
    final user = FirebaseAuth.instance.currentUser;
    final profileText = user?.displayName ?? user?.email ?? 'Usuario';
    String? profileImageUrl = user?.photoURL;

    // Si la foto es de Google, ajusta el tamaño
    if (profileImageUrl != null &&
        profileImageUrl.contains('googleusercontent.com')) {
      profileImageUrl = '${profileImageUrl.split('=')[0]}=s96-c';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Título principal de la app
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
        // Línea con saludo, foto y nombre de usuario
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  // Saludo
                  Text(
                    AppLocalizations.of(context)!.greeting,
                    style: const TextStyle(
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
            // Botón para cerrar sesión
            TextButton.icon(
              onPressed: _signOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white70,
                size: 18,
              ),
              label: Text(
                AppLocalizations.of(context)!.logout,
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

  // Construye la interfaz principal con barra superior y navegación inferior
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
                        builder: (context) => LanguageSelector(
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
      // Muestra la página seleccionada
      body: _pages[_selectedIndex],
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: AppLocalizations.of(context)!.search,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.homeTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: AppLocalizations.of(context)!.favorites,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: AppLocalizations.of(context)!.map,
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
