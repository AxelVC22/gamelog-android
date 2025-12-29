
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/data/repositories/statistics/statistics_repository.dart';

import '../../../constants/api_constants.dart';
import '../../../domain/failures/failure.dart';
import '../../../constants/error_codes.dart';
import '../../models/statistics/retrieve_statistics_response.dart';

class StatisticsRepositoryImpl extends StatistisRepository {
  final FlutterSecureStorage storage;
  final Dio dio;

  StatisticsRepositoryImpl(


      this.storage,
      this.dio,
      );

  @override
  Future<Either<Failure, RetrieveStatisticsResponse>> retrieveTrendStatistics(String fromDate, String toDate) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        '${ApiConstants.retrieveTrendStatistics}/$fromDate/$toDate',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
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
  Future<Either<Failure, RetrieveStatisticsResponse>> retrieveRevivalRetroStatistics(String fromDate, String toDate) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        '${ApiConstants.retrieveRevivalRetroStatistics}/$fromDate/$toDate',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
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
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

}