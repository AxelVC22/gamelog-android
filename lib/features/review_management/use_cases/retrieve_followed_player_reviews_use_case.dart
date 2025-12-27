
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/review_management/models/retrieve_player_reviews_response.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';

class RetrieveFollowedPlayerReviewsUseCase {
  final ReviewManagementRepository repository;

  RetrieveFollowedPlayerReviewsUseCase(this.repository);

  Future<Either<Failure, RetrievePlayerReviewsResponse>> call (int idGame, int idPlayer) async {
    final result = await repository.retrieveFollowedPlayerReviews(idGame, idPlayer);
    return result;
  }
}