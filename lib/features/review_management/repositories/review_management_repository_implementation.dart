import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/review_management/models/add_to_pendings_response.dart';
import 'package:gamelog/features/review_management/models/delete_review_response.dart';
import 'package:gamelog/features/review_management/models/register_game_request.dart';
import 'package:gamelog/features/review_management/models/retrieve_player_reviews_response.dart';
import 'package:gamelog/features/review_management/models/retrieve_review_history_response.dart';
import 'package:gamelog/features/review_management/models/review_game_request.dart';
import 'package:gamelog/features/review_management/models/review_game_response.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/domain/entities/game.dart';
import '../../../core/messages/error_codes.dart';
import '../models/add_to_pendings_request.dart';
import '../models/register_game_response.dart';

class ReviewManagementRepositoryImpl implements ReviewManagementRepository {
  final Dio dioRawg;
  final String apiKey;
  final FlutterSecureStorage storage;
  final Dio dio;

  ReviewManagementRepositoryImpl(
    this.dioRawg,
    this.apiKey,
    this.storage,
    this.dio,
  );

  @override
  Future<Either<Failure, Game>> searchGame(String gameName) async {
    try {
      final response = await dioRawg.get(
        '${ApiConstants.searchGame}/$gameName',
        queryParameters: {'key': apiKey},
      );

      if (response.statusCode == 200) {
        final res = Game.fromJson(response.data);
        return Right(res);
      } else {
        final data = response.data;

        final message =
            data['error'] ??
            data['detail'] ??
            data['message'] ??
            'Unknown server error';

        return Left(Failure.server(message));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

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
  retrievePlayerReviewsResponse(int idGame, int idPlayer) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        '${ApiConstants.retrievePlayerReviews}/$idGame',
        queryParameters: {'idJugadorBuscador': idPlayer},
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
        return left(Failure.server(response.data['mensaje']));
      }
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
        queryParameters: {'idJugadorBuscador': idPlayer},
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
}
