
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/reviews/delete_review_response.dart';
import 'package:gamelog/core/data/repositories/reviews/reviews_repository.dart';

class DeleteReviewUseCase {
  final ReviewsRepository repository;

  DeleteReviewUseCase(this.repository);

  Future<Either<Failure, DeleteReviewResponse>> call (int idGame, int idReview) async {
    final result = await repository.deleteReview(idGame, idReview);
    return result;
  }
}