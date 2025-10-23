import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/review.dart';
import '../services/review_service.dart';
import '../widgets/star_rating.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Widget para mostrar la sección completa de reseñas en páginas de detalles
class ReviewsSection extends StatefulWidget {
  /// ID del lugar (destino o restaurante)
  final String placeId;

  /// Nombre del lugar para mostrar en el header
  final String placeName;

  const ReviewsSection({
    super.key,
    required this.placeId,
    required this.placeName,
  });

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final ReviewService _reviewService = ReviewService();
  bool _showAllReviews = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildStatsSection(),
          const SizedBox(height: 16),
          _buildWriteReviewButton(),
          const SizedBox(height: 16),
          _buildReviewsList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          Icons.rate_review,
          color: Colors.green.shade600,
          size: 24,
        ),
        const SizedBox(width: 8),
        const Text(
          'Reseñas y Calificaciones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return StreamBuilder<ReviewStats>(
      stream: _reviewService.getReviewStatsForPlace(widget.placeId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.red.shade50,
            child: Row(
              children: [
                Icon(Icons.error, color: Colors.red.shade400),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                        'Error al cargar estadísticas:\n${snapshot.error}')),
              ],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final stats = snapshot.data!;

        if (stats.totalReviews == 0) {
          return _buildEmptyState();
        }

        return _buildStatsDisplay(stats);
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.star_border,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            'Sin reseñas aún',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '¡Sé el primero en compartir tu experiencia!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsDisplay(ReviewStats stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          // Calificación grande
          Column(
            children: [
              Text(
                stats.averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              StarRating.display(
                rating: stats.averageRating.round(),
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                stats.reviewCountText,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // Distribución de estrellas
          Expanded(
            child: _buildRatingDistribution(stats),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingDistribution(ReviewStats stats) {
    return Column(
      children: [
        for (int rating = 5; rating >= 1; rating--)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Text('$rating'),
                const SizedBox(width: 4),
                Icon(Icons.star, size: 12, color: Colors.amber),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: stats.totalReviews > 0
                        ? stats.ratingDistribution[rating]! / stats.totalReviews
                        : 0,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green.shade400),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 20,
                  child: Text(
                    '${stats.ratingDistribution[rating]}',
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildWriteReviewButton() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.login, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              'Inicia sesión para escribir una reseña',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return FutureBuilder<bool>(
      future: _reviewService.canUserReview(widget.placeId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(12),
            color: Colors.red.shade50,
            child: Row(
              children: [
                Icon(Icons.error, color: Colors.red.shade400),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                        'Error al verificar si puedes reseñar:\n${snapshot.error}')),
              ],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final canReview = snapshot.data!;

        if (!canReview) {
          return FutureBuilder<Review?>(
            future: _reviewService.getCurrentUserReviewForPlace(widget.placeId),
            builder: (context, reviewSnapshot) {
              if (reviewSnapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.red.shade50,
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red.shade400),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(
                              'Error al cargar tu reseña:\n${reviewSnapshot.error}')),
                    ],
                  ),
                );
              }
              if (!reviewSnapshot.hasData || reviewSnapshot.data == null) {
                return const SizedBox.shrink();
              }

              final userReview = reviewSnapshot.data!;
              return _buildUserReviewCard(userReview);
            },
          );
        }

        return ElevatedButton.icon(
          onPressed: () => _showWriteReviewModal(),
          icon: const Icon(Icons.edit),
          label: const Text('Escribir Reseña'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserReviewCard(Review review) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.blue.shade600, size: 20),
              const SizedBox(width: 8),
              // Avatar del usuario autenticado
              CircleAvatar(
                radius: 16,
                backgroundImage: review.userPhotoUrl.isNotEmpty
                    ? NetworkImage(review.userPhotoUrl)
                    : null,
                child: review.userPhotoUrl.isEmpty
                    ? Icon(Icons.person, color: Colors.grey.shade600)
                    : null,
              ),
              const SizedBox(width: 8),
              Text(
                'Tu reseña',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  review.userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _showEditReviewModal(review),
                child: const Text('Editar'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              StarRating.display(rating: review.rating, size: 16),
              const SizedBox(width: 8),
              Text(
                timeago.format(review.createdAt, locale: 'es'),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReviewsList() {
    return StreamBuilder<List<Review>>(
      stream: _reviewService.getReviewsForPlace(widget.placeId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.red.shade50,
            child: Row(
              children: [
                Icon(Icons.error, color: Colors.red.shade400),
                const SizedBox(width: 8),
                Expanded(
                    child: Text('Error al cargar reseñas:\n${snapshot.error}')),
              ],
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final reviews = snapshot.data!;
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;

        // Filtrar la reseña del usuario actual para no mostrarla duplicada
        final otherReviews =
            reviews.where((review) => review.userId != currentUserId).toList();

        if (otherReviews.isEmpty) {
          return const SizedBox.shrink();
        }

        // Mostrar solo las primeras 3 reseñas inicialmente
        final displayReviews =
            _showAllReviews ? otherReviews : otherReviews.take(3).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reseñas de otros visitantes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            ...displayReviews.map((review) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildReviewCard(review),
                )),
            if (otherReviews.length > 3 && !_showAllReviews)
              TextButton(
                onPressed: () {
                  setState(() {
                    _showAllReviews = true;
                  });
                },
                child: Text('Ver todas las reseñas (${otherReviews.length})'),
              ),
            if (_showAllReviews && otherReviews.length > 3)
              TextButton(
                onPressed: () {
                  setState(() {
                    _showAllReviews = false;
                  });
                },
                child: const Text('Mostrar menos'),
              ),
          ],
        );
      },
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Foto de perfil
              CircleAvatar(
                radius: 20,
                backgroundImage: review.userPhotoUrl.isNotEmpty
                    ? NetworkImage(review.userPhotoUrl)
                    : null,
                child: review.userPhotoUrl.isEmpty
                    ? Icon(Icons.person, color: Colors.grey.shade600)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        StarRating.display(rating: review.rating, size: 14),
                        const SizedBox(width: 8),
                        Text(
                          timeago.format(review.createdAt, locale: 'es'),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showWriteReviewModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WriteReviewModal(
        placeId: widget.placeId,
        placeName: widget.placeName,
      ),
    );
  }

  void _showEditReviewModal(Review review) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WriteReviewModal(
        placeId: widget.placeId,
        placeName: widget.placeName,
        existingReview: review,
      ),
    );
  }
}

/// Modal para escribir o editar una reseña
class WriteReviewModal extends StatefulWidget {
  final String placeId;
  final String placeName;
  final Review? existingReview;

  const WriteReviewModal({
    super.key,
    required this.placeId,
    required this.placeName,
    this.existingReview,
  });

  @override
  State<WriteReviewModal> createState() => _WriteReviewModalState();
}

class _WriteReviewModalState extends State<WriteReviewModal> {
  final TextEditingController _commentController = TextEditingController();
  final ReviewService _reviewService = ReviewService();
  int _rating = 5;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingReview != null) {
      _rating = widget.existingReview!.rating;
      _commentController.text = widget.existingReview!.comment;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRatingSection(),
                  const SizedBox(height: 24),
                  _buildCommentSection(),
                  const Spacer(),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade600,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Icon(Icons.rate_review, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.existingReview != null
                      ? 'Editar Reseña'
                      : 'Escribir Reseña',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.placeName,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calificación',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: RatingSelector(
            rating: _rating,
            onRatingChanged: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comparte tu experiencia',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _commentController,
            maxLines: 6,
            maxLength: 500,
            decoration: const InputDecoration(
              hintText:
                  'Cuéntanos sobre tu visita, qué te gustó más, recomendaciones...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        if (widget.existingReview != null) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: _isLoading ? null : _deleteReview,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Eliminar'),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    widget.existingReview != null ? 'Actualizar' : 'Publicar'),
          ),
        ),
      ],
    );
  }

  Future<void> _saveReview() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una calificación')),
      );
      return;
    }

    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor escribe un comentario')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      print('🔄 Iniciando envío de reseña...');

      if (widget.existingReview != null) {
        // Actualizar reseña existente
        print('📝 Actualizando reseña existente...');
        await _reviewService.updateReview(
          reviewId: widget.existingReview!.id,
          rating: _rating,
          comment: _commentController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reseña actualizada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
        print('✅ Reseña actualizada exitosamente');
      } else {
        // Crear nueva reseña
        print('✨ Creando nueva reseña...');
        print('📍 Place ID: ${widget.placeId}');
        print('⭐ Rating: $_rating');
        print('💬 Comment length: ${_commentController.text.trim().length}');

        await _reviewService.addReview(
          placeId: widget.placeId,
          rating: _rating,
          comment: _commentController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reseña publicada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
        print('✅ Reseña creada exitosamente');
      }

      Navigator.pop(context);
    } catch (e) {
      print('❌ Error al enviar reseña: $e');

      String errorMessage = 'Error al publicar la reseña';
      if (e.toString().contains('Ya has escrito una reseña')) {
        errorMessage = 'Ya has escrito una reseña para este lugar';
      } else if (e.toString().contains('Usuario no autenticado')) {
        errorMessage = 'Debes iniciar sesión para escribir una reseña';
      } else if (e.toString().contains('permission-denied')) {
        errorMessage = 'No tienes permisos para escribir reseñas';
      } else {
        errorMessage = 'Error: ${e.toString()}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _deleteReview() async {
    if (widget.existingReview == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Reseña'),
        content: const Text('¿Estás seguro de que quieres eliminar tu reseña?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _reviewService.deleteReview(widget.existingReview!.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reseña eliminada exitosamente')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
