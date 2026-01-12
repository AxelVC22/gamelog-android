import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/notifications/retrieve_notifications_response.dart';
import 'package:gamelog/core/data/repositories/notifications/notifications_repository.dart';

import '../../../constants/api_constants.dart';
import '../../../presentation/dio_error_handler.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  final Dio dio;

  NotificationsRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, RetrieveNotificationsResponse>> retrieveNotifications(
    int idPlayer,
  ) async {
    try {
      final response = await dio.get(
        '${ApiConstants.retrieveNotifications}/$idPlayer',
      );

      if (response.statusCode == 200) {
        final res = RetrieveNotificationsResponse.fromJson(response.data);

        return Right(res);
      } else if (response.statusCode == 404) {
        return Right(
          RetrieveNotificationsResponse(notifications: [], error: false),
        );
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
