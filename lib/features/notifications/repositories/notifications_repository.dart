import 'package:dartz/dartz.dart';



import '../../../core/domain/failures/failure.dart';
import '../models/retrieve_notifications_response.dart';

abstract class NotificationsRepository {



  Future<Either<Failure, RetrieveNotificationsResponse>> retrieveNotifications (int idPlayer);


}