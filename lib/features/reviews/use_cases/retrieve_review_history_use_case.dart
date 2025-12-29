
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_review_history_response.dart';
import 'package:gamelog/core/data/repositories/reviews/reviews_repository.dart';

class RetrieveReviewHistoryUseCase {
  final ReviewsRepository repository;

  RetrieveReviewHistoryUseCase(this.repository);

  Future<Either<Failure, RetrieveReviewHistoryResponse>> call (int idPlayerToSearch, int idPlayer) async {
    final result = await repository.retrieveReviewHistory(idPlayerToSearch, idPlayer);
    return result;
  }
}