import 'package:flutter/foundation.dart';

enum UserStatus {
  Desbaneado
}

enum UserType {
  Jugador,
  Administrador
}

@immutable
class User {
  final String email;
  final String? password;
  final String status;
  final String name;
  final String fathersSurname;
  final String? mothersSurname;
  final String username;
  final String description;
  final String? picture;
  final String userType;

  const User({
    required this.email,
    this.password,
    required this.status,
    required this.name,
    required this.fathersSurname,
    this.mothersSurname,
    required this.username,
    required this.description,
    this.picture,
    required this.userType,
  });
}
