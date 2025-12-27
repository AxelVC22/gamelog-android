import 'package:flutter/cupertino.dart';

@immutable
class AddToFavoritesRequest {
  final int idGame;
  final int idPlayer;
  final String name;
  final String releaseDate;



  const AddToFavoritesRequest({
    required this.idGame,
    required this.idPlayer,
    required this.name,
    required this.releaseDate

  });

  Map<String, dynamic> toJson() => {
    'idJuego': idGame,
    'idJugador': idPlayer
  };
}
