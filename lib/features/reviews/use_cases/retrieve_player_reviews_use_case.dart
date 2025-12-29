
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_player_reviews_response.dart';
import 'package:gamelog/core/data/repositories/reviews/reviews_repository.dart';

class RetrievePlayerReviewsUseCase {
  final ReviewsRepository repository;

  RetrievePlayerReviewsUseCase(this.repository);

  Future<Either<Failure, RetrievePlayerReviewsResponse>> call (int idGame, int idPlayer) async {
    final result = await repository.retrievePlayerReviews(idGame, idPlayer);
    return result;
  }
}