
import 'dart:io';

import '../../../core/data/repositories/photos/reviews/review_multimedia_repository.dart';

class SubirVideoUseCase {
  final ReviewMultimediaRepository repository;

  SubirVideoUseCase(this.repository);

  Future<void> call({
    required String idReview,
    required File video,
    Function(double)? onProgress,
  }) async {
    final extension = video.path.split('.').last.toLowerCase();
    if (extension != 'mp4') {
      throw Exception('Solo se permiten videos MP4');
    }

    final fileSize = await video.length();
    if (fileSize > 50 * 1024 * 1024) {
      throw Exception('El video no debe exceder 50MB');
    }

    return await repository.uploadVideo(
      idReview,
      video,
      onProgress: onProgress,
    );
  }
}