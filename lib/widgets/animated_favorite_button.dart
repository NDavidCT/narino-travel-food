import 'package:flutter/material.dart';
import '../services/favorites_service.dart';

class AnimatedFavoriteButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isFavorite;
  final Color? favoriteColor;
  final Color? unfavoriteColor;
  final double size;

  const AnimatedFavoriteButton({
    super.key,
    required this.onPressed,
    required this.isFavorite,
    this.favoriteColor = Colors.red,
    this.unfavoriteColor = Colors.white,
    this.size = 24,
  });

  @override
  State<AnimatedFavoriteButton> createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    // Activar animación
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Ejecutar callback
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.isFavorite
                      ? widget.favoriteColor
                      : widget.unfavoriteColor,
                  size: widget.size,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Widget para usar específicamente con destinos
class DestinationFavoriteButton extends StatelessWidget {
  final dynamic destination;
  final double size;

  const DestinationFavoriteButton({
    super.key,
    required this.destination,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesService = FavoritesService();

    return AnimatedBuilder(
      animation: favoritesService,
      builder: (context, child) {
        bool isFavorite =
            favoritesService.isDestinationFavorite(destination.name);

        return AnimatedFavoriteButton(
          isFavorite: isFavorite,
          size: size,
          onPressed: () async {
            await favoritesService.toggleDestinationFavorite(destination);

            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isFavorite
                      ? '${destination.name} eliminado de favoritos'
                      : '${destination.name} agregado a favoritos ❤️',
                ),
                backgroundColor: isFavorite ? Colors.orange : Colors.green,
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Widget para usar específicamente con restaurantes
class RestaurantFavoriteButton extends StatelessWidget {
  final dynamic restaurant;
  final double size;

  const RestaurantFavoriteButton({
    super.key,
    required this.restaurant,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesService = FavoritesService();

    return AnimatedBuilder(
      animation: favoritesService,
      builder: (context, child) {
        String restaurantName = restaurant.name ?? '';
        bool isFavorite = favoritesService.isRestaurantFavorite(restaurantName);

        return AnimatedFavoriteButton(
          isFavorite: isFavorite,
          size: size,
          onPressed: () async {
            await favoritesService.toggleRestaurantFavorite(restaurant);

            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isFavorite
                      ? '${restaurant.name} eliminado de favoritos'
                      : '${restaurant.name} agregado a favoritos ❤️',
                ),
                backgroundColor: isFavorite ? Colors.orange : Colors.green,
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
