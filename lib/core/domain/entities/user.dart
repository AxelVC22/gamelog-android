import 'package:flutter/foundation.dart';

@immutable
class User {
  final String nombreDeUsuario;
  final String tipoDeAcceso;

  const User({
    required this.nombreDeUsuario,
    required this.tipoDeAcceso,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nombreDeUsuario: json['nombreDeUsuario'] as String,
      tipoDeAcceso: json['tipoDeAcceso'] as String,
    );
  }
}