// Widget para mostrar calificaciones con estrellas
// Permite mostrar y seleccionar rating de 1 a 5 estrellas
import 'package:flutter/material.dart';

/// Widget para mostrar y seleccionar calificaciones con estrellas
class StarRating extends StatefulWidget {
  /// Calificación actual (1-5)
  final int rating;

  /// Callback cuando cambia la calificación (solo para modo interactivo)
  final ValueChanged<int>? onRatingChanged;

  /// Tamaño de las estrellas
  final double size;

  /// Color de las estrellas llenas
  final Color filledColor;

  /// Color de las estrellas vacías
  final Color unfilledColor;

  /// Si permite interacción para cambiar la calificación
  final bool interactive;

  /// Espaciado entre estrellas
  final double spacing;

  const StarRating({
    super.key,
    required this.rating,
    this.onRatingChanged,
    this.size = 24.0,
    this.filledColor = Colors.amber,
    this.unfilledColor = Colors.grey,
    this.interactive = false,
    this.spacing = 2.0,
  });

  /// Constructor para modo solo lectura (mostrar calificación)
  const StarRating.display({
    super.key,
    required this.rating,
    this.size = 20.0,
    this.filledColor = Colors.amber,
    this.unfilledColor = Colors.grey,
    this.spacing = 1.0,
  })  : onRatingChanged = null,
        interactive = false;

  /// Constructor para modo interactivo (seleccionar calificación)
  const StarRating.input({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.size = 32.0,
    this.filledColor = Colors.amber,
    this.unfilledColor = Colors.grey,
    this.spacing = 4.0,
  }) : interactive = true;

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int _hoveredStar = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onStarTap(int rating) {
    if (!widget.interactive || widget.onRatingChanged == null) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    widget.onRatingChanged!(rating);
  }

  void _onStarHover(int star) {
    if (!widget.interactive) return;

    setState(() {
      _hoveredStar = star;
    });
  }

  void _onStarExit() {
    if (!widget.interactive) return;

    setState(() {
      _hoveredStar = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starNumber = index + 1;
        final isSelected = starNumber <= widget.rating;
        final isHovered = widget.interactive && starNumber <= _hoveredStar;
        final starColor = (isSelected || isHovered)
            ? widget.filledColor
            : widget.unfilledColor;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
          child: widget.interactive
              ? _InteractiveStar(
                  starNumber: starNumber,
                  size: widget.size,
                  color: starColor,
                  isSelected: isSelected,
                  scaleAnimation: _scaleAnimation,
                  onTap: () => _onStarTap(starNumber),
                  onHover: () => _onStarHover(starNumber),
                  onExit: _onStarExit,
                )
              : _DisplayStar(
                  size: widget.size,
                  color: starColor,
                  isSelected: isSelected,
                ),
        );
      }),
    );
  }
}

/// Widget para estrella en modo interactivo
class _InteractiveStar extends StatelessWidget {
  final int starNumber;
  final double size;
  final Color color;
  final bool isSelected;
  final Animation<double> scaleAnimation;
  final VoidCallback onTap;
  final VoidCallback onHover;
  final VoidCallback onExit;

  const _InteractiveStar({
    required this.starNumber,
    required this.size,
    required this.color,
    required this.isSelected,
    required this.scaleAnimation,
    required this.onTap,
    required this.onHover,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(),
      onExit: (_) => onExit(),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isSelected ? scaleAnimation.value : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                child: Icon(
                  isSelected ? Icons.star : Icons.star_border,
                  size: size,
                  color: color,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Widget para estrella en modo solo lectura
class _DisplayStar extends StatelessWidget {
  final double size;
  final Color color;
  final bool isSelected;

  const _DisplayStar({
    required this.size,
    required this.color,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      isSelected ? Icons.star : Icons.star_border,
      size: size,
      color: color,
    );
  }
}

/// Widget para mostrar promedio de calificación con estrellas y texto
class RatingDisplay extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final double starSize;
  final double fontSize;
  final Color textColor;

  const RatingDisplay({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.starSize = 16.0,
    this.fontSize = 14.0,
    this.textColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StarRating.display(
          rating: rating.round(),
          size: starSize,
        ),
        const SizedBox(width: 8),
        Text(
          '${rating.toStringAsFixed(1)}/5',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($reviewCount ${reviewCount == 1 ? 'reseña' : 'reseñas'})',
          style: TextStyle(
            fontSize: fontSize - 2,
            color: textColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

/// Widget para selector de calificación con descripción
class RatingSelector extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;
  final double starSize;

  const RatingSelector({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.starSize = 40.0,
  });

  String _getRatingDescription(int rating) {
    switch (rating) {
      case 1:
        return 'Muy malo';
      case 2:
        return 'Malo';
      case 3:
        return 'Regular';
      case 4:
        return 'Bueno';
      case 5:
        return 'Excelente';
      default:
        return 'Selecciona una calificación';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StarRating.input(
          rating: rating,
          onRatingChanged: onRatingChanged,
          size: starSize,
        ),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            _getRatingDescription(rating),
            key: ValueKey(rating),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
