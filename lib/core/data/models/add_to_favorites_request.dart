import 'package:flutter/cupertino.dart';

@immutable
class AddToFavoritesRequest {
  final int idGame;
  final int idPlayer;



  const AddToFavoritesRequest({
    required this.idGame,
    required this.idPlayer,

  });

  Map<String, dynamic> toJson() => {
    'idJuego': idGame,
    'idJugador': idPlayer
  };
}
