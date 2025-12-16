import 'package:dartz/dartz.dart';
import 'package:gamelog/features/review_management/models/retrieve_player_reviews_response.dart';
import 'package:gamelog/features/review_management/models/review_game_request.dart';
import 'package:gamelog/features/review_management/models/review_game_response.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/failures/failure.dart';

abstract class ReviewManagementRepository {

  Future<Either<Failure, Game>> searchGame (String gameName);

  Future<Either<Failure, ReviewGameResponse>> reviewGame (ReviewGameRequest request);

  Future<Either<Failure, RetrievePlayerReviewsResponse>> retrievePlayerReviewsResponse (int idGame, int idPlayer);

}