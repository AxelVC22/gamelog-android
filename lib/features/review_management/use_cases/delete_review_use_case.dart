
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/review_management/models/delete_review_response.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';

class DeleteReviewUseCase {
  final ReviewManagementRepository repository;

  DeleteReviewUseCase(this.repository);

  Future<Either<Failure, DeleteReviewResponse>> call (int idGame, int idReview) async {
    final result = await repository.deleteReview(idGame, idReview);
    return result;
  }
}