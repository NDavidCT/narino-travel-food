import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/review.dart';

/// Servicio para manejar las reseñas en Firestore
class ReviewService {
  static final ReviewService _instance = ReviewService._internal();
  factory ReviewService() => _instance;
  ReviewService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Nombre de la colección en Firestore
  static const String _collectionName = 'reviews';

  /// Referencia a la colección de reseñas
  CollectionReference get _reviewsCollection =>
      _firestore.collection(_collectionName);

  /// Agrega una nueva reseña
  Future<String> addReview({
    required String placeId,
    required int rating,
    required String comment,
  }) async {
    try {
      print('🔄 Iniciando proceso de agregar reseña...');

      final user = _auth.currentUser;
      if (user == null) {
        print('❌ Error: Usuario no autenticado');
        throw Exception('Usuario no autenticado');
      }

      print('✅ Usuario autenticado: ${user.uid}');

      // Verificar si el usuario ya tiene una reseña para este lugar
      print('🔍 Verificando reseña existente...');
      try {
        final existingReview = await getReviewByUserAndPlace(user.uid, placeId);
        if (existingReview != null) {
          print('❌ Ya existe una reseña para este lugar');
          throw Exception('Ya has escrito una reseña para este lugar');
        }
        print('✅ No hay reseña existente, procediendo...');
      } catch (e) {
        if (e.toString().contains('Ya has escrito una reseña')) {
          rethrow;
        }
        print('⚠️ Error al verificar reseña existente (continuando): $e');
        // Continuamos si hay error en la verificación
      }

      // Optimizar URL de foto de Google
      String photoUrl = user.photoURL ?? '';
      if (photoUrl.isNotEmpty && photoUrl.contains('googleusercontent.com')) {
        photoUrl = photoUrl.split('=')[0] + '=s96-c';
      }

      print('📝 Creando objeto Review...');
      final review = Review.create(
        placeId: placeId,
        userId: user.uid,
        userName: user.displayName ?? user.email ?? 'Usuario Anónimo',
        userPhotoUrl: photoUrl,
        rating: rating,
        comment: comment,
      );

      print('💾 Guardando en Firestore...');
      final docRef = await _reviewsCollection.add(review.toMap());
      print('✅ Reseña agregada con ID: ${docRef.id}');

      return docRef.id;
    } catch (e) {
      print('❌ Error al agregar reseña: $e');
      rethrow;
    }
  }

  /// Actualiza una reseña existente
  Future<void> updateReview({
    required String reviewId,
    required int rating,
    required String comment,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('Usuario no autenticado');
      }

      // Optimizar URL de foto de Google
      String photoUrl = user.photoURL ?? '';
      if (photoUrl.isNotEmpty && photoUrl.contains('googleusercontent.com')) {
        photoUrl = photoUrl.split('=')[0] + '=s96-c';
      }

      await _reviewsCollection.doc(reviewId).update({
        'rating': rating,
        'comment': comment,
        'userName': user.displayName ?? user.email ?? 'Usuario Anónimo',
        'userPhotoUrl': photoUrl,
        'updatedAt': Timestamp.now(),
      });

      print('✅ Reseña actualizada: $reviewId');
    } catch (e) {
      print('❌ Error al actualizar reseña: $e');
      rethrow;
    }
  }

  /// Elimina una reseña
  Future<void> deleteReview(String reviewId) async {
    try {
      await _reviewsCollection.doc(reviewId).delete();
      print('✅ Reseña eliminada: $reviewId');
    } catch (e) {
      print('❌ Error al eliminar reseña: $e');
      rethrow;
    }
  }

  /// Obtiene todas las reseñas de un lugar específico
  Stream<List<Review>> getReviewsForPlace(String placeId) {
    try {
      return _reviewsCollection
          .where('placeId', isEqualTo: placeId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();
      });
    } catch (e) {
      print('❌ Error al obtener reseñas para $placeId: $e');
      return Stream.value([]);
    }
  }

  /// Obtiene una reseña específica de un usuario para un lugar
  Future<Review?> getReviewByUserAndPlace(String userId, String placeId) async {
    try {
      final snapshot = await _reviewsCollection
          .where('userId', isEqualTo: userId)
          .where('placeId', isEqualTo: placeId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return Review.fromFirestore(snapshot.docs.first);
    } catch (e) {
      print('❌ Error al obtener reseña del usuario: $e');
      return null;
    }
  }

  /// Obtiene las estadísticas de reseñas para un lugar
  Stream<ReviewStats> getReviewStatsForPlace(String placeId) {
    return getReviewsForPlace(placeId).map((reviews) {
      return ReviewStats.fromReviews(reviews);
    });
  }

  /// Obtiene todas las reseñas de un usuario
  Stream<List<Review>> getReviewsByUser(String userId) {
    try {
      return _reviewsCollection
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();
      });
    } catch (e) {
      print('❌ Error al obtener reseñas del usuario: $e');
      return Stream.value([]);
    }
  }

  /// Verifica si el usuario actual puede escribir una reseña para un lugar
  Future<bool> canUserReview(String placeId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      final existingReview = await getReviewByUserAndPlace(user.uid, placeId);
      return existingReview == null;
    } catch (e) {
      print('❌ Error al verificar si puede reseñar: $e');
      return false;
    }
  }

  /// Obtiene la reseña del usuario actual para un lugar específico
  Future<Review?> getCurrentUserReviewForPlace(String placeId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      return await getReviewByUserAndPlace(user.uid, placeId);
    } catch (e) {
      print('❌ Error al obtener reseña del usuario actual: $e');
      return null;
    }
  }

  /// Obtiene las últimas reseñas globales (para feed de actividad)
  Stream<List<Review>> getLatestReviews({int limit = 10}) {
    try {
      return _reviewsCollection
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();
      });
    } catch (e) {
      print('❌ Error al obtener últimas reseñas: $e');
      return Stream.value([]);
    }
  }

  /// Busca reseñas por texto en el comentario
  Future<List<Review>> searchReviews(String searchText,
      {String? placeId}) async {
    try {
      Query query = _reviewsCollection;

      if (placeId != null) {
        query = query.where('placeId', isEqualTo: placeId);
      }

      final snapshot = await query.orderBy('createdAt', descending: true).get();

      final reviews = snapshot.docs
          .map((doc) => Review.fromFirestore(doc))
          .where((review) =>
              review.comment.toLowerCase().contains(searchText.toLowerCase()))
          .toList();

      return reviews;
    } catch (e) {
      print('❌ Error al buscar reseñas: $e');
      return [];
    }
  }

  /// Obtiene las mejores reseñas (4-5 estrellas) para un lugar
  Stream<List<Review>> getTopReviewsForPlace(String placeId, {int limit = 5}) {
    try {
      return _reviewsCollection
          .where('placeId', isEqualTo: placeId)
          .where('rating', whereIn: [4, 5])
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map((doc) => Review.fromFirestore(doc))
                .toList();
          });
    } catch (e) {
      print('❌ Error al obtener mejores reseñas: $e');
      return Stream.value([]);
    }
  }
}
