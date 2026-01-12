
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/follows/follow_user_request.dart';
import 'package:gamelog/core/data/models/follows/follow_user_response.dart';
import 'package:gamelog/core/data/repositories/follows/follow_repository.dart';

class FollowUserUseCase {
  final FollowRepository repository;

  FollowUserUseCase(this.repository);

  Future<Either<Failure, FollowUserResponse>> call (FollowUserRequest request) async {

    final result = await repository.followUser(request);
    return result;
  }
}