
import 'package:flutter/cupertino.dart';

@immutable
class EditProfileRequest {
  final String email;
  final String password;
  final String name;
  final String fathersSurname;
  final String? mothersSurname;
  final String username;
  final String description;
  final String? picture;
  final int? idAccess;
  final int? idPlayer;
  final bool changePasswordOrEmail;
  final bool changeUserDate;

  const EditProfileRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.fathersSurname,
    this.mothersSurname,
    required this.username,
    required this.description,
    this.picture,
    this.idAccess,
    this.idPlayer,
    required this.changePasswordOrEmail,
    required this.changeUserDate
  });

  Map<String, dynamic> toJson() => {
    'correo': email,
    'contrasenia': password,
    'nombre': name,
    'primerApellido': fathersSurname,
    if (mothersSurname != null) 'segundoApellido': mothersSurname,
    'nombreDeUsuario': username,
    'descripcion': description,
    if (picture != null) 'foto': picture,
  };
}