import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'player.dart';
import 'game.dart';

@immutable
class Notification {
  final int id;
  final Player notified;
  final Player notifier;
  final String message;
  final DateTime date;

  const Notification({
    required this.id,
    required this.message,
    required this.date,
    required this.notified,
    required this.notifier
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
        id: json['id'] as int,
        message: json['mensaje'] as String,

        date: DateTime.parse(json['fecha']),
        notified: Player.fromJson(json['notificado']),
        notifier: Player.fromJson(json['notificador'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'fecha': date.toIso8601String(),
    };
  }
}
