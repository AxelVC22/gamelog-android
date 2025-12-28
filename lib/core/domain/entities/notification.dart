import 'package:flutter/foundation.dart';
import 'player.dart';

@immutable
class Notification {
  final int idNotification;
  final int idNotifiedPlayer;
  final int idNotifierPlayer;
  final String message;
  final DateTime date;

  const Notification({
    required this.idNotification,
    required this.idNotifiedPlayer,
    required this.idNotifierPlayer,
    required this.message,
    required this.date
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
        idNotification: json['idNotificacion'] as int,
        message: json['mensajeNotificacion'] as String,
        date: DateTime.parse(json['fechaNotificacion']),
        idNotifiedPlayer:json['idJugadorNotificado'] as int,
        idNotifierPlayer: json['idJugadorNotificante'] as int
    );
  }


}
