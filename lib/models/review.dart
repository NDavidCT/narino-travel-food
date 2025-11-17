// Modelo para reseñas de lugares turísticos y restaurantes
// Permite guardar y recuperar opiniones de usuarios
import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo para las reseñas de lugares turísticos y restaurantes
class Review {
  final String id; // ID único de la reseña
  final String placeId; // ID del lugar (ej: "santuario-las-lajas")
  final String userId; // ID del usuario de Firebase Auth
  final String userName; // Nombre del usuario
  final String userPhotoUrl; // URL de la foto de perfil
  final int rating; // Calificación de 1-5 estrellas
  final String comment; // Comentario/experiencia del usuario
  final DateTime createdAt; // Fecha de creación

  Review({
    required this.id,
    required this.placeId,
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  /// Constructor para crear una nueva reseña (sin ID, se genera automáticamente)
  Review.create({
    required this.placeId,
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.rating,
    required this.comment,
  })  : id = '',
        createdAt = DateTime.now();

  /// Convierte la reseña a un Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'rating': rating,
      'comment': comment,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Crea una reseña desde un documento de Firestore
  factory Review.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Review(
      id: doc.id,
      placeId: data['placeId'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? 'Usuario Anónimo',
      userPhotoUrl: data['userPhotoUrl'] ?? '',
      rating: data['rating'] ?? 1,
      comment: data['comment'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Crea una reseña desde un Map (para JSON)
  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] ?? '',
      placeId: map['placeId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? 'Usuario Anónimo',
      userPhotoUrl: map['userPhotoUrl'] ?? '',
      rating: map['rating'] ?? 1,
      comment: map['comment'] ?? '',
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.parse(
              map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  /// Convierte a Map para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'placeId': placeId,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Crea una copia de la reseña con campos modificados
  Review copyWith({
    String? id,
    String? placeId,
    String? userId,
    String? userName,
    String? userPhotoUrl,
    int? rating,
    String? comment,
    DateTime? createdAt,
  }) {
    return Review(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Review(id: $id, placeId: $placeId, userName: $userName, rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Review &&
        other.id == id &&
        other.placeId == placeId &&
        other.userId == userId &&
        other.rating == rating &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        placeId.hashCode ^
        userId.hashCode ^
        rating.hashCode ^
        comment.hashCode;
  }
}

/// Estadísticas de reseñas para un lugar
class ReviewStats {
  final double averageRating;
  final int totalReviews;
  final Map<int, int>
      ratingDistribution; // Cuántas reseñas de cada rating (1-5)

  ReviewStats({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  /// Constructor vacío para lugares sin reseñas
  ReviewStats.empty()
      : averageRating = 0.0,
        totalReviews = 0,
        ratingDistribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

  /// Calcula las estadísticas a partir de una lista de reseñas
  factory ReviewStats.fromReviews(List<Review> reviews) {
    if (reviews.isEmpty) {
      return ReviewStats.empty();
    }

    final totalReviews = reviews.length;
    final sumRatings =
        reviews.fold<int>(0, (sum, review) => sum + review.rating);
    final averageRating = sumRatings / totalReviews;

    // Distribución de calificaciones
    final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (final review in reviews) {
      distribution[review.rating] = distribution[review.rating]! + 1;
    }

    return ReviewStats(
      averageRating: averageRating,
      totalReviews: totalReviews,
      ratingDistribution: distribution,
    );
  }

  /// Texto descriptivo del promedio
  String get ratingText {
    if (totalReviews == 0) return 'Sin calificaciones';
    return '${averageRating.toStringAsFixed(1)}/5';
  }

  /// Texto descriptivo del total
  String get reviewCountText {
    if (totalReviews == 0) return 'Sin reseñas';
    if (totalReviews == 1) return '1 reseña';
    return '$totalReviews reseñas';
  }
}
