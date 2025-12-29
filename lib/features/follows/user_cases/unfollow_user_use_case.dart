
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/follows/unfollow_user_response.dart';
import 'package:gamelog/core/data/repositories/follows/follow_repository.dart';

class UnfollowUserUseCase {
  final FollowRepository repository;

  UnfollowUserUseCase(this.repository);

  Future<Either<Failure, UnfollowUserResponse>> call (int idPlayerFollower, int idPlayerFollowed) async {
    final result = await repository.unfollowUser(idPlayerFollower, idPlayerFollowed);
    return result;
  }
}