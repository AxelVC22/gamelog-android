// core/services/notification_service.dart

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static final NotificationService _instance =
  NotificationService._internal();

  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Inicialización (llamar una sola vez, ej. en main)
  Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null, // usa el icono por defecto de la app
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

    // Permisos (Android 13+ y iOS)
    final isAllowed =
    await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowed) {
      await AwesomeNotifications()
          .requestPermissionToSendNotifications();
    }
  }

  /// Mostrar notificación simple
  Future<void> mostrarNotificacion({
    required String titulo,
    required String mensaje,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'gamelog_channel',
        title: titulo,
        body: mensaje,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
