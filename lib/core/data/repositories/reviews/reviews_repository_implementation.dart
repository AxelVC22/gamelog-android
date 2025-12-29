import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/reviews/add_to_pendings_response.dart';
import 'package:gamelog/core/data/models/reviews/delete_review_response.dart';
import 'package:gamelog/core/data/models/reviews/like_request.dart';
import 'package:gamelog/core/data/models/reviews/like_response.dart';
import 'package:gamelog/core/data/models/reviews/register_game_request.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_player_reviews_response.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_review_history_response.dart';
import 'package:gamelog/core/data/models/reviews/review_game_request.dart';
import 'package:gamelog/core/data/models/reviews/review_game_response.dart';
import 'package:gamelog/core/data/repositories/reviews/reviews_repository.dart';

import '../../../constants/api_constants.dart';
import '../../../constants/error_codes.dart';
import '../../models/reviews/add_to_pendings_request.dart';
import '../../models/reviews/register_game_response.dart';

class ReviewsRepositoryImpl extends ReviewsRepository {
  final FlutterSecureStorage storage;
  final Dio dio;

  ReviewsRepositoryImpl(
    this.storage,
    this.dio,
  );



  Future<Either<Failure, RegisterGameResponse>> _registerGame(
    RegisterGameRequest request,
  ) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.post(
        ApiConstants.registerGame,
        data: request.toJson(),
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );
      final res = RegisterGameResponse.fromJson(response.data);
      return Right(res);
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, ReviewGameResponse>> reviewGame(
    ReviewGameRequest request,
  ) async {
    try {
      final token = await storage.read(key: 'access_token');

      final registerGameRequest = RegisterGameRequest(
        idGame: request.idGame,
        name: request.name,
        releaseDate: request.released,
      );

      final gameRegistration = await _registerGame(registerGameRequest);

      return gameRegistration.fold((failure) => Left(failure), (
        response,
      ) async {
        final response = await dio.post(
          ApiConstants.reviewGame,
          data: request.toJson(),
          options: Options(
            headers: {"Authorization": "Bearer $token"},
            validateStatus: (status) => status! < 600,
          ),
        );

        if (response.statusCode == 200) {
          final res = ReviewGameResponse.fromJson(response.data);
          return Right(res);
        } else {
          return Left(Failure.server(response.data['mensaje']));
        }
      });
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, RetrievePlayerReviewsResponse>>
  retrievePlayerReviews(int idGame, int idPlayer) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        '${ApiConstants.retrievePlayerReviews}/$idGame',
        queryParameters: {ApiConstants.queryIdPlayerSeeker: idPlayer},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final res = RetrievePlayerReviewsResponse.fromJson(response.data);
        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(RetrievePlayerReviewsResponse(reviews: [], error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, AddToPendingsResponse>> addGameToPendings(
      AddToPendingsRequest request,
      ) async {
    try {
      final token = await storage.read(key: 'access_token');

      final registerGameRequest = RegisterGameRequest(
        idGame: request.idGame,
        name: request.name,
        releaseDate: request.releaseDate,
      );

      final gameRegistration = await _registerGame(registerGameRequest);

      return gameRegistration.fold(
            (failure) => Left(failure),
            (_) async {
          final response = await dio.post(
            ApiConstants.addGameToPendings,
            data: request.toJson(),
            options: Options(
              headers: {"Authorization": "Bearer $token"},
              validateStatus: (status) => status! < 600,
            ),
          );

          if (response.statusCode == 200) {
            final res = AddToPendingsResponse.fromJson(response.data);
            return Right(res);
          } else {
            return Left(Failure.server(response.data['mensaje']));
          }
        },
      );
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }


  @override
  Future<Either<Failure, RetrieveReviewHistoryResponse>> retrieveReviewHistory(
    int idPlayerToSearch,
    int idPlayer,
  ) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        '${ApiConstants.retriveReviewHistory}/$idPlayerToSearch',
        queryParameters: {ApiConstants.queryIdPlayerSeeker: idPlayer},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final res = RetrieveReviewHistoryResponse.fromJson(response.data);
        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(RetrieveReviewHistoryResponse(reviews: [], error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, DeleteReviewResponse>> deleteReview(int idGame, int idReview) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.delete(
        '${ApiConstants.deleteReview}/$idGame/$idReview',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final base = DeleteReviewResponse.fromJson(response.data);

        final res = base.copyWith(idReview: idReview);
        return Right(res);
      } else {
        final message = response.data['mensaje'];
        return Left(Failure.server(_parseMessages(message)));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }


  static String _parseMessages(dynamic message) {
    if (message == null) return '';

    if (message is String) {
      return message;
    }

    if (message is List) {
      String concatString = '';
      message.map((e) => concatString = concatString + e.toString());
      return concatString;
    }

    return ErrorCodes.unexpectedError;
  }

  @override
  Future<Either<Failure, LikeResponse>> likeReview(LikeRequest request) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.post(
        ApiConstants.likeReview,
        data: request.toJson(),
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final base = LikeResponse.fromJson(response.data);

        final res = base.copyWith(idReview: request.idReview);
        return Right(res);
      } else {
        final message = _parseMessages(response.data['mensaje']);
        return Left(Failure.server(_parseMessages(message)));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, LikeResponse>> unlikeReview(LikeRequest request) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.delete(
        '${ApiConstants.likeReview}/${request.idGame}',
        data: request.toJson(),
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final base = LikeResponse.fromJson(response.data);

        final res = base.copyWith(idReview: request.idReview);
        return Right(res);
      } else {
        final message = _parseMessages(response.data['mensaje']);
        return Left(Failure.server(_parseMessages(message)));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, RetrievePlayerReviewsResponse>> retrieveFollowedPlayerReviews(int idGame, int idPlayer) async{
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        ApiConstants.retrieveFollowedPlayerReview(idGame),
        queryParameters: {'idJugador': idPlayer},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final res = RetrievePlayerReviewsResponse.fromJson(response.data);
        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(RetrievePlayerReviewsResponse(reviews: [], error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }


}
