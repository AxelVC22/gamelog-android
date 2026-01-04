
import 'dart:typed_data';

import '../../../core/data/repositories/photos/reviews/review_multimedia_repository.dart';

class ObtenerFotosUseCase {
  final ReviewMultimediaRepository repository;

  ObtenerFotosUseCase(this.repository);

  Future<List<Uint8List>> call(String idReview) async {
    if (idReview.isEmpty) {
      throw Exception('ID de reseña no puede estar vacío');
    }

    return await repository.retrievePhotos(idReview);
  }
}