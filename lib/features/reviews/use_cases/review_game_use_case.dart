

import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/reviews/review_game_request.dart';
import 'package:gamelog/core/data/models/reviews/review_game_response.dart';
import 'package:gamelog/core/data/repositories/reviews/reviews_repository.dart';

import '../../../core/domain/failures/failure.dart';

class ReviewGameUseCase {
  final ReviewsRepository repository;

  ReviewGameUseCase(this.repository);

  Future<Either<Failure, ReviewGameResponse>> call (ReviewGameRequest request) async {

    //todo: validaciones
    final result = await repository.reviewGame(request);

    return result;
  }
}