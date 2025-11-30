

import 'package:dartz/dartz.dart';
import 'package:gamelog/features/review_management/models/review_game_request.dart';
import 'package:gamelog/features/review_management/models/review_game_response.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';

import '../../../core/domain/failures/failure.dart';

class ReviewGameUseCase {
  final ReviewManagementRepository repository;

  ReviewGameUseCase(this.repository);

  Future<Either<Failure, ReviewGameResponse>> call (ReviewGameRequest request) async {

    //todo: validaciones
    final result = await repository.reviewGame(request);

    return result;
  }
}