import 'package:flutter/cupertino.dart';

@immutable
class LikeRequest {
  final int idReview;
  final int idGame;
  final int idPlayerAuthor;
  final int idPlayer;
  final String gameName;

  const LikeRequest({
    required this.idReview,
    required this.idGame,
    required this.idPlayerAuthor,
    required this.idPlayer,
    required this.gameName,
  });

  Map<String, dynamic> toJson() => {
    'idResena': idReview,
    'idJuego': idGame,
    'idJugadorAutor': idPlayerAuthor,
    'idJugador': idPlayer,
    'nombreJuego': gameName,
  };
}
