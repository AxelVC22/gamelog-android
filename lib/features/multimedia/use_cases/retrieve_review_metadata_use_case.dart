
import '../../../core/data/repositories/photos/reviews/review_multimedia_repository.dart';

class ObtenerMetadataUseCase {
  final ReviewMultimediaRepository repository;

  ObtenerMetadataUseCase(this.repository);

  Future<MultimediaMetadata> call(String idReview) async {
    if (idReview.isEmpty) {
      throw Exception('ID de reseña no puede estar vacío');
    }

    return await repository.retrieveMetadata(idReview);
  }
}