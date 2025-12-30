import 'package:flutter/cupertino.dart';

@immutable
class Account {
  final int? idAccount;
  final String? email;
  final String? status;
  final String? accessType;
  final int idPlayer;
  final String name;
  final String fathersSurname;
  final String mothersSurname;
  final String username;
  final String description;
  final String picture;
  final int? idAccess;

  const Account({
    required this.idAccount,
    required this.email,
    required this.status,
    required this.accessType,
    required this.idPlayer,
    required this.name,
    required this.fathersSurname,
    required this.mothersSurname,
    required this.username,
    required this.description,
    required this.picture,
    this.idAccess
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      idAccount: json['idCuenta'] as int?,
      email: json['correo'] as String?,
      status: json['estado'] as String?,
      accessType: json['tipoDeAcceso'] as String?,
      idPlayer: json['idJugador'] as int,
      name: json['nombre'] as String,
      fathersSurname: json['primerApellido'] as String,
      mothersSurname: json['segundoApellido'] as String,
      username: json['nombreDeUsuario'] as String,
      description: json['descripcion'] as String,
      picture: json['foto'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCuenta': idAccount,
      'correo': email,
      'estado': status,
      'tipoDeAcceso': accessType,
      'idJugador': idPlayer,
      'nombre': name,
      'primerApellido': fathersSurname,
      'segundoApellido': mothersSurname,
      'nombreDeUsuario': username,
      'descripcion': description,
      'foto': picture,
      //'idAcceso': idAccess,
    };
  }
}
