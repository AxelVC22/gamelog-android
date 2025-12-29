import 'package:flutter/cupertino.dart';

@immutable
class ReviewGameRequest {
  final int idGame;
  final int idPlayer;
  final double rating;
  final String opinion;

  final String name;
  final String released;


  const ReviewGameRequest({
    required this.idGame,
    required this.idPlayer,
    required this.rating,
    required this.opinion,
    required this.name,
    required this.released
  });

  Map<String, dynamic> toJson() => {
    'idJuego': idGame,
    'idJugador': idPlayer,
    'calificacion': rating,
    'opinion': opinion,
  };
}
