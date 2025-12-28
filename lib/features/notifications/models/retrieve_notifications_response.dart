
import '../../../core/domain/entities/game.dart';
import '../../../core/domain/entities/notification.dart';

class RetrieveNotificationsResponse {
  final bool error;
  final List<Notification> notifications;

  const RetrieveNotificationsResponse({
    required this.error,
    required this.notifications,
  });

  factory RetrieveNotificationsResponse.fromJson(Map<String, dynamic> json) {
    return RetrieveNotificationsResponse(
      error: json['error'] as bool,
      notifications: (json['notificaciones'] as List<dynamic>)
          .map((item) => Notification.fromJson(item))
          .toList(),
    );
  }
}