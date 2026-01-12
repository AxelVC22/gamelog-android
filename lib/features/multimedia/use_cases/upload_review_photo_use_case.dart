
import 'dart:io';

import '../../../core/data/repositories/photos/reviews/review_multimedia_repository.dart';

class UploadPhotoUseCase {
  final ReviewMultimediaRepository repository;

  UploadPhotoUseCase(this.repository);

  Future<void> call({
    required String idReview,
    required int indice,
    required File foto,
  }) async {
    if (indice < 1 || indice > 3) {
      throw Exception('Índice debe ser entre 1 y 3');
    }

    final extension = foto.path.split('.').last.toLowerCase();
    if (!['jpg', 'jpeg', 'png'].contains(extension)) {
      throw Exception('Solo se permiten fotos JPG o PNG');
    }

    final fileSize = await foto.length();
    if (fileSize > 5 * 1024 * 1024) { // 5MB
      throw Exception('La foto no debe exceder 5MB');
    }

    return await repository.uploadPhoto(idReview, indice, foto);
  }
}