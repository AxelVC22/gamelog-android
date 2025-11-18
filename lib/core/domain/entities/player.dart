import 'package:flutter/foundation.dart';

@immutable
class Player {
  final String username;


  const Player({
    required this.username,

  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        username: json['nombreDeUsuario'] as String,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombreDeUsuario': username,
    };
  }
}