import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/review_management/providers/review_management_providers.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/messages/error_codes.dart';

class ReviewManagementRepositoryImpl implements ReviewManagementRepository {
  final Dio dio;
  final String apiKey;

  ReviewManagementRepositoryImpl(this.dio, this.apiKey);

  @override
  Future<Either<Failure, Game>> searchGame(
    String gameName,
  ) async {
      try {

        final response = await dio.get(
          '${ApiConstants.searchGame}/$gameName',
          queryParameters: {
            'key': apiKey,
          },
        );



        if (response.statusCode == 200 ) {
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

}
