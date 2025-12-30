import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gamelog/core/presentation/dio_error_handler.dart';
import 'package:gamelog/core/data/models/follows/follow_user_response.dart';
import 'package:gamelog/core/data/models/follows/retrieve_social_response.dart';
import 'package:gamelog/core/data/models/follows/unfollow_user_response.dart';
import '../../../constants/api_constants.dart';
import '../../../domain/failures/failure.dart';
import '../../models/follows/follow_user_request.dart';
import 'follow_repository.dart';

class FollowRepositoryImpl implements FollowRepository {
  final Dio dio;

  FollowRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, FollowUserResponse>> followUser(
    FollowUserRequest request,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.followUser,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final res = FollowUserResponse.fromJson(response.data);
        return Right(res);
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, RetrieveSocialResponse>> retrieveFollowed(
    int idPlayer,
  ) async {
    try {
      final response = await dio.get(
        '${ApiConstants.retrieveFollowed}${idPlayer}',
      );

      if (response.statusCode == 200) {
        final res = RetrieveSocialResponse.fromJson(response.data);
        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(RetrieveSocialResponse(accounts: [], error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, RetrieveSocialResponse>> retrieveFollowers(
    int idPlayer,
  ) async {
    try {
      final response = await dio.get(
        '${ApiConstants.retrieveFollowers}${idPlayer}',
      );

      if (response.statusCode == 200) {
        final res = RetrieveSocialResponse.fromJson(response.data);
        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(RetrieveSocialResponse(accounts: [], error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UnfollowUserResponse>> unfollowUser(
    int idPlayerFollower,
    int idPlayerFollowed,
  ) async {
    try {
      final response = await dio.delete(
        '${ApiConstants.unfollowUser}${idPlayerFollower}/${idPlayerFollowed}',
      );

      if (response.statusCode == 200) {
        final res = UnfollowUserResponse.fromJson(response.data);
        return Right(res);
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
