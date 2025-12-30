import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gamelog/core/data/repositories/statistics/statistics_repository.dart';

import '../../../constants/api_constants.dart';
import '../../../domain/failures/failure.dart';
import '../../../constants/error_codes.dart';
import '../../../presentation/dio_error_handler.dart';
import '../../models/statistics/retrieve_statistics_response.dart';

class StatisticsRepositoryImpl extends StatistisRepository {
  final Dio dio;

  StatisticsRepositoryImpl( this.dio);

  @override
  Future<Either<Failure, RetrieveStatisticsResponse>> retrieveTrendStatistics(
    String fromDate,
    String toDate,
  ) async {
    try {

      final response = await dio.get(
        '${ApiConstants.retrieveTrendStatistics}/$fromDate/$toDate',

      );

      if (response.statusCode == 200) {
        final res = RetrieveStatisticsResponse.fromJson(response.data);

        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(RetrieveStatisticsResponse(games: [], error: false));
      } else {
        final message = response.data['mensaje'];
        return Left(Failure.server(_parseMessages(message)));
      }
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));

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
  Future<Either<Failure, RetrieveStatisticsResponse>>
  retrieveRevivalRetroStatistics(String fromDate, String toDate) async {
    try {

      final response = await dio.get(
        '${ApiConstants.retrieveRevivalRetroStatistics}/$fromDate/$toDate',

      );

      if (response.statusCode == 200) {
        final res = RetrieveStatisticsResponse.fromJson(response.data);

        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(RetrieveStatisticsResponse(games: [], error: false));
      } else {
        final message = response.data['mensaje'];
        return Left(Failure.server(_parseMessages(message)));
      }
    } on DioException catch (e) {

      return Left(DioErrorHandler.handle(e));

    }
  }
}
