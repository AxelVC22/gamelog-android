import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/data/models/games/add_to_favorites_request.dart';
import 'package:gamelog/core/data/models/games/add_to_favorites_response.dart';
import 'package:gamelog/core/data/repositories/games/game_repository.dart';
import 'package:gamelog/core/domain/entities/game.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/games/games_response.dart';

import '../../models/reviews/register_game_request.dart';
import '../../models/reviews/register_game_response.dart';
import '../../../constants/api_constants.dart';
import '../../../constants/error_codes.dart';
import 'package:dio/dio.dart';

class GameRepositoryImpl implements GameRepository {
  final Dio dioRawg;
  final String apiKey;
  final FlutterSecureStorage storage;
  final Dio dio;

  GameRepositoryImpl(this.dioRawg, this.apiKey, this.storage, this.dio);

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
  Future<Either<Failure, Game>> searchGame(String gameName) async {
    try {
      final response = await dioRawg.get(
        '${ApiConstants.searchGame}/$gameName',
        queryParameters: {'key': apiKey},
        options: Options(validateStatus: (status) => status! < 600),
      );

      if (response.statusCode == 200) {
        final res = Game.fromJson(response.data);
        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(Game(id: 0, name: '', rating: 0, ratingTop: 0));
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

  @override
  Future<Either<Failure, AddToFavoritesResponse>> addGameToFavorites(
      AddToFavoritesRequest request,
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
            ApiConstants.addGameToFavorites,
            data: request.toJson(),
            options: Options(
              headers: {"Authorization": "Bearer $token"},
              validateStatus: (status) => status! < 600,
            ),
          );

          if (response.statusCode == 200) {
            final res = AddToFavoritesResponse.fromJson(response.data);
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
  Future<Either<Failure, GamesResponse>> retrieveFavorites(int idPlayer) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        '${ApiConstants.addGameToFavorites}/$idPlayer',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final res = GamesResponse.fromJson(response.data);

        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(GamesResponse(games: [], error: false));
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
  Future<Either<Failure, GamesResponse>> retrievePendings(int idPlayer) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        '${ApiConstants.addGameToPendings}/$idPlayer',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final res = GamesResponse.fromJson(response.data);

        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(GamesResponse(games: [], error: false));
      } else {
        final message = response.data['mensaje'];
        return Left(Failure.server(_parseMessages(message)));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }
}
