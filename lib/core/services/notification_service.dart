
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static final NotificationService _instance =
  NotificationService._internal();

  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'gamelog_channel',
          channelName: 'GameLog Notifications',
          channelDescription: 'Notificaciones de GameLog',
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
      debug: true,
    );

    final isAllowed =
    await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowed) {
      await AwesomeNotifications()
          .requestPermissionToSendNotifications();
    }
  }

  Future<void> showNotification({
    required String title,
    required String message,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'gamelog_channel',
        title: title,
        body: message,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
