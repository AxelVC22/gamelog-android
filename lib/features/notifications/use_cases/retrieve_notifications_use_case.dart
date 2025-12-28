
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/notifications/models/retrieve_notifications_response.dart';
import 'package:gamelog/features/notifications/repositories/notifications_repository.dart';

class RetrieveNotificationsUseCase {
  final NotificationsRepository repository;

  RetrieveNotificationsUseCase(this.repository);

  Future<Either<Failure, RetrieveNotificationsResponse>> call (int idPlayer) async {
    final result = await repository.retrieveNotifications(idPlayer);
    return result;
  }
}