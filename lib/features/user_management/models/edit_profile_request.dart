
import 'package:flutter/cupertino.dart';

@immutable
class EditProfileRequest {
  final String? oldEmail;
  final String name;
  final String fathersSurname;
  final String? mothersSurname;
  final String username;
  final String description;
  final String? picture;
  final int? idAccess;
  final int? idPlayer;
  final String userType;

  const EditProfileRequest({

    required this.name,
    required this.fathersSurname,
    this.mothersSurname,
    required this.username,
    required this.description,
    this.picture,
    this.idAccess,
    this.idPlayer,
    this.oldEmail,
    required this.userType
  });

  Map<String, dynamic> toJson() => {

    'nombre': name,
    'primerApellido': fathersSurname,
    if (mothersSurname != null) 'segundoApellido': mothersSurname,
    'nombreDeUsuario': username,
    'descripcion': description,
    if (picture != null) 'foto': picture,
    'tipoDeUsuario' : userType
  };
}