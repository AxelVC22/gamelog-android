import 'package:dartz/dartz.dart';



import '../../../domain/failures/failure.dart';
import '../../models/notifications/retrieve_notifications_response.dart';

abstract class NotificationsRepository {



  Future<Either<Failure, RetrieveNotificationsResponse>> retrieveNotifications (int idPlayer);


}