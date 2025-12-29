
import 'package:flutter/cupertino.dart';

@immutable
class RegisterUserRequest {
  final String email;
  final String password;
  final String status;
  final String name;
  final String fathersSurname;
  final String? mothersSurname;
  final String username;
  final String description;
  final String? picture;
  final String userType;

  const RegisterUserRequest({
    required this.email,
    required this.password,
    required this.status,
    required this.name,
    required this.fathersSurname,
    this.mothersSurname,
    required this.username,
    required this.description,
    this.picture,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
    'correo': email,
    'contrasenia': password,
    'estado': status,
    'nombre': name,
    'primerApellido': fathersSurname,
    if (mothersSurname != null) 'segundoApellido': mothersSurname,
    'nombreDeUsuario': username,
    'descripcion': description,
    if (picture != null) 'foto': picture,
    'tipoDeUsuario': userType,
  };
}
