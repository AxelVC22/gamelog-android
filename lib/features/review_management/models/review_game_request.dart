import 'package:flutter/cupertino.dart';

@immutable
class ReviewGameRequest {
  final int idGame;
  final int idPlayer;
  final double rating;
  final String opinion;

  const ReviewGameRequest({
    required this.idGame,
    required this.idPlayer,
    required this.rating,
    required this.opinion,
  });

  Map<String, dynamic> toJson() => {
    'idJuego': idGame,
    'idJugador': idPlayer,
    'calificacion': rating,
    'opinion': opinion,
  };
}
