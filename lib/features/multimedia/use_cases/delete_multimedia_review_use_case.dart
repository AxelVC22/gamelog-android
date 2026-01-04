
import '../../../core/data/repositories/photos/reviews/review_multimedia_repository.dart';

class EliminarArchivosUseCase {
  final ReviewMultimediaRepository repository;

  EliminarArchivosUseCase(this.repository);

  Future<void> call(String idReview) async {
    if (idReview.isEmpty) {
      throw Exception('ID de reseña no puede estar vacío');
    }

    return await repository.deleteFiles(idReview);
  }
}