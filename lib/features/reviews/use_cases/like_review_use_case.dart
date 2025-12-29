
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/reviews/like_request.dart';
import 'package:gamelog/core/data/models/reviews/like_response.dart';
import 'package:gamelog/core/data/repositories/reviews/reviews_repository.dart';

class LikeReviewUseCase {
  final ReviewsRepository repository;

  LikeReviewUseCase(this.repository);

  Future<Either<Failure, LikeResponse>> call (LikeRequest request) async {
    final result = await repository.likeReview(request);
    return result;
  }
}