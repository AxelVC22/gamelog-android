
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/follows/unfollow_user_response.dart';
import 'package:gamelog/core/data/repositories/follows/follow_repository.dart';

import '../../../core/constants/error_codes.dart';

class UnfollowUserUseCase {
  final FollowRepository repository;

  UnfollowUserUseCase(this.repository);

  Future<Either<Failure, UnfollowUserResponse>> call (int idPlayerFollower, int idPlayerFollowed) async {

    if (idPlayerFollowed <= 0 || idPlayerFollower <= 0) {
      return left(Failure(ErrorCodes.unexpectedValuesError));
    }

    final result = await repository.unfollowUser(idPlayerFollower, idPlayerFollowed);
    return result;
  }
}