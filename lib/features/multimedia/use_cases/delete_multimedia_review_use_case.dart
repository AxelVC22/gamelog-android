
import '../../../core/data/repositories/photos/reviews/review_multimedia_repository.dart';

class DeleteFilesUseCase {
  final ReviewMultimediaRepository repository;

  DeleteFilesUseCase(this.repository);

  Future<void> call(String idReview) async {
    if (idReview.isEmpty) {
      throw Exception('ID de reseña no puede estar vacío');
    }

    return await repository.deleteFiles(idReview);
  }
}