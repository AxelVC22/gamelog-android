
import 'dart:typed_data';

import '../../../core/data/repositories/photos/reviews/review_multimedia_repository.dart';

class RetrieveVideoUseCase {
  final ReviewMultimediaRepository repository;

  RetrieveVideoUseCase(this.repository);

  Future<Uint8List?> call({
    required String idReview,
    Function(double)? onProgress,
  }) async {
    if (idReview.isEmpty) {
      throw Exception('ID de reseña no puede estar vacío');
    }

    return await repository.retrieveVideo(
      idReview,
      onProgress: onProgress,
    );
  }
}