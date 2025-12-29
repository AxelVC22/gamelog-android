import 'package:flutter/cupertino.dart';

@immutable
class RegisterGameRequest {
  final int idGame;
  final String name;
  final String releaseDate;


  const RegisterGameRequest({
    required this.idGame,
    required this.name,
    required this.releaseDate
  });

  Map<String, dynamic> toJson() => {
    'idJuego': idGame,
    'nombre': name,
    'fechaDeLanzamiento': releaseDate,
  };
}
