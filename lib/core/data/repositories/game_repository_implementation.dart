import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/data/models/add_to_favorites_request.dart';
import 'package:gamelog/core/data/models/add_to_favorites_response.dart';
import 'package:gamelog/core/data/repositories/game_reporitory.dart';
import 'package:gamelog/core/domain/entities/game.dart';
import 'package:gamelog/core/domain/failures/failure.dart';

import '../../../features/auth/providers/auth_providers.dart';
import '../../constants/api_constants.dart';
import '../../messages/error_codes.dart';
import 'package:dio/dio.dart';

class GameRepositoryImpl implements GameRepository {
  final Dio dioRawg;
  final String apiKey;
  final FlutterSecureStorage storage;
  final Dio dio;

  GameRepositoryImpl(this.dioRawg, this.apiKey, this.storage, this.dio);

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
  Future<Either<Failure, AddToFavoritesResponse>> addGameToFavorites(AddToFavoritesRequest request) async {
    try {
      final token = await storage.read(key: 'access_token');

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
        return left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }
}
