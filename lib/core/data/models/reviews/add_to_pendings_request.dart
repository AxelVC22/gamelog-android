import 'package:flutter/cupertino.dart';

@immutable
class AddToPendingsRequest {
  final int idGame;
  final int idPlayer;
  final String name;
  final String releaseDate;

  const AddToPendingsRequest({
    required this.name,
    required this.releaseDate,
    required this.idGame,
    required this.idPlayer,
  });

  Map<String, dynamic> toJson() => {'idJuego': idGame, 'idJugador': idPlayer};
}
