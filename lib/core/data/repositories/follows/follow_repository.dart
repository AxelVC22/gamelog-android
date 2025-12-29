import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/follows/follow_user_request.dart';
import 'package:gamelog/core/data/models/follows/follow_user_response.dart';
import 'package:gamelog/core/data/models/follows/retrieve_social_response.dart';
import 'package:gamelog/core/data/models/follows/unfollow_user_response.dart';

import '../../../domain/failures/failure.dart';


abstract class FollowRepository {

  Future<Either<Failure, FollowUserResponse>> followUser(FollowUserRequest request);

  Future<Either<Failure, RetrieveSocialResponse>> retrieveFollowed(int idPlayer);

  Future<Either<Failure, RetrieveSocialResponse>> retrieveFollowers(int idPlayer);

  Future<Either<Failure, UnfollowUserResponse>> unfollowUser(int idPlayerFollower, int idPlayerFollowed);


}