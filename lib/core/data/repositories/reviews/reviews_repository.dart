import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/reviews/add_to_pendings_request.dart';
import 'package:gamelog/core/data/models/reviews/add_to_pendings_response.dart';
import 'package:gamelog/core/data/models/reviews/delete_review_response.dart';
import 'package:gamelog/core/data/models/reviews/like_request.dart';
import 'package:gamelog/core/data/models/reviews/like_response.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_player_reviews_response.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_review_history_response.dart';
import 'package:gamelog/core/data/models/reviews/review_game_request.dart';
import 'package:gamelog/core/data/models/reviews/review_game_response.dart';

import '../../../domain/failures/failure.dart';

abstract class ReviewsRepository {


  Future<Either<Failure, ReviewGameResponse>> reviewGame (ReviewGameRequest request);

  Future<Either<Failure, RetrievePlayerReviewsResponse>> retrievePlayerReviews (int idGame, int idPlayer);

  Future<Either<Failure, RetrievePlayerReviewsResponse>> retrieveFollowedPlayerReviews (int idGame, int idPlayer);

  Future<Either<Failure, AddToPendingsResponse>> addGameToPendings (AddToPendingsRequest request);


  Future<Either<Failure, RetrieveReviewHistoryResponse>> retrieveReviewHistory (int idPlayerToSearch, int idPlayer);

  Future <Either<Failure, DeleteReviewResponse>> deleteReview(int idGame, int idReview);

  Future<Either<Failure, LikeResponse>> likeReview(LikeRequest request);

  Future<Either<Failure, LikeResponse>> unlikeReview(LikeRequest request);

}