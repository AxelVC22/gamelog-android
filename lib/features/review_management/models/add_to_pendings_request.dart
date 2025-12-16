import 'package:flutter/cupertino.dart';

@immutable
class AddToPendingsRequest {
  final int idGame;
  final int idPlayer;



  const AddToPendingsRequest({
    required this.idGame,
    required this.idPlayer,

  });

  Map<String, dynamic> toJson() => {
    'idJuego': idGame,
    'idJugador': idPlayer
  };
}
