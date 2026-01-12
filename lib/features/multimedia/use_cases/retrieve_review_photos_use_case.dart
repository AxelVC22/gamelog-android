
import 'dart:typed_data';

import '../../../core/data/repositories/photos/reviews/review_multimedia_repository.dart';

class RetrievePhotosUseCase {
  final ReviewMultimediaRepository repository;

  RetrievePhotosUseCase(this.repository);

  Future<List<Uint8List>> call(String idReview) async {

    return await repository.retrievePhotos(idReview);
  }
}