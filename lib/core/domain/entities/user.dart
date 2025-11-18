import 'package:flutter/foundation.dart';

@immutable
class User {
  final String username;
  final String accessType;
  final String description;

  const User({
    required this.username,
    required this.accessType,
    required this. description
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['nombreDeUsuario'] as String,
      accessType: json['tipoDeAcceso'] as String,
      description: json ['descripcion'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombreDeUsuario': username,
      'tipoDeAcceso': accessType,
    };
  }
}