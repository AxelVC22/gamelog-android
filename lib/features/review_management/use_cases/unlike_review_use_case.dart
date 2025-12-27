
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/review_management/models/like_request.dart';
import 'package:gamelog/features/review_management/models/like_response.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';

class UnlikeReviewUseCase {
  final ReviewManagementRepository repository;

  UnlikeReviewUseCase(this.repository);

  Future<Either<Failure, LikeResponse>> call (LikeRequest request) async {
    final result = await repository.unlikeReview(request);
    return result;
  }
}