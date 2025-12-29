

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/notifications/retrieve_notifications_response.dart';
import 'package:gamelog/core/data/repositories/notifications/notifications_repository.dart';

import '../../../constants/api_constants.dart';
import '../../../constants/error_codes.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
   final Dio dio;
   final FlutterSecureStorage storage;

  NotificationsRepositoryImpl( this.dio,  this.storage);

  @override
  Future<Either<Failure, RetrieveNotificationsResponse>> retrieveNotifications(int idPlayer) async {
    try {
      final token = await storage.read(key: 'access_token');

      final response = await dio.get(
        '${ApiConstants.retrieveNotifications}/$idPlayer',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (status) => status! < 600,
        ),
      );

      if (response.statusCode == 200) {
        final res = RetrieveNotificationsResponse.fromJson(response.data);

        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(RetrieveNotificationsResponse(notifications: [], error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }


}