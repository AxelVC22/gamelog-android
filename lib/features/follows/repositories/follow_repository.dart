import 'package:dartz/dartz.dart';
import 'package:gamelog/features/follows/models/follow_user_request.dart';
import 'package:gamelog/features/follows/models/follow_user_response.dart';
import 'package:gamelog/features/follows/models/retrieve_social_response.dart';
import 'package:gamelog/features/follows/models/unfollow_user_response.dart';

import '../../../core/domain/failures/failure.dart';


abstract class FollowRepository {

  Future<Either<Failure, FollowUserResponse>> followUser(FollowUserRequest request);

  Future<Either<Failure, RetrieveSocialResponse>> retrieveFollowed(int idPlayer);

  Future<Either<Failure, RetrieveSocialResponse>> retrieveFollowers(int idPlayer);

  Future<Either<Failure, UnfollowUserResponse>> unfollowUser(int idPlayerFollower, int idPlayerFollowed);


}