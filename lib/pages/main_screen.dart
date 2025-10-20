import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/google_sign_in_service.dart';
// Asegúrate de que estas importaciones sean correctas para tus archivos:
import 'home_page.dart';
import 'search_page.dart';
import 'favorites_page.dart';
import 'map_page.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 1});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex; // Quitamos la inicialización aquí

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

  Widget _buildProfileTitle() {
    // Obtiene el usuario de Firebase actualmente logueado
    final user = FirebaseAuth.instance.currentUser;
    // El texto a mostrar (Nombre del usuario o su correo)
    final profileText = user?.displayName ?? user?.email ?? 'Usuario';
    // La URL de la foto de perfil (si usa Google o proveedor con foto)
    final profileImageUrl = user?.photoURL;

    return Row(
      mainAxisSize: MainAxisSize.min, // Ocupa solo el espacio necesario
      children: [
        // 1. Ícono de Perfil o Foto
        ClipOval(
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white, // Fondo blanco para el placeholder
              shape: BoxShape.circle,
            ),
            child: profileImageUrl != null && profileImageUrl.isNotEmpty
                ? Image.network(
                    profileImageUrl,
                    fit: BoxFit.cover,
                    // Si falla la carga de la imagen, muestra el ícono por defecto
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, color: Colors.red, size: 20),
                  )
                : const Icon(Icons.person,
                    color: Colors.red, size: 20), // Ícono por defecto
          ),
        ),
        const SizedBox(width: 8),

        // 2. Nombre / Correo del Usuario
        Flexible(
          child: Text(
            profileText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              // Permite que el texto se envuelva si es muy largo, aunque en AppBar se verá truncado
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ¡CAMBIO AQUÍ! Usamos la función para generar el título dinámico.
        title: _buildProfileTitle(),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Ícono de cerrar sesión
            onPressed: _signOut,
            tooltip: 'Cerrar Sesión',
          ),
        ],
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
