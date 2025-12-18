
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/review_management/models/retrieve_review_history_response.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';

class RetrieveReviewHistoryUseCase {
  final ReviewManagementRepository repository;

  RetrieveReviewHistoryUseCase(this.repository);

  Future<Either<Failure, RetrieveReviewHistoryResponse>> call (int idPlayerToSearch, int idPlayer) async {
    final result = await repository.retrieveReviewHistory(idPlayerToSearch, idPlayer);
    return result;
  }
}