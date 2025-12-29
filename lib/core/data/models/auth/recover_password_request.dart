import 'package:flutter/cupertino.dart';

@immutable
class RecoverPasswordRequest {
  final String email;
  final String userType;
  final int? code;
  final int? idAccess;
  final String? password;


  const RecoverPasswordRequest ({
    required this.email,
    required this.userType,
    this.code,
    this.idAccess,
    this.password
});

  Map<String, dynamic> toJson() => {
    'correo': email,
    'tipoDeUsuario' : userType,
    'codigo': code,
    'contrasenia': password
  };
}