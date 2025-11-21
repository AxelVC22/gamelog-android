import 'package:flutter/cupertino.dart';

@immutable
class LoginRequest {
  final String email;
  final String password;
  final String userType;

  const LoginRequest({
    required this.email,
    required this.password,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
    'correo': email,
    'contrasenia': password,
    'tipoDeUsuario': userType,
  };
}
