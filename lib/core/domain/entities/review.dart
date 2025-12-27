import 'package:flutter/foundation.dart';

@immutable
class Review {
  final int idReview;
  final int idPlayer;
  final String? username;
  final String? picture;
  final int idGame;
  final String name;
  final String date;
  final String opinion;
  final double rating;
  final int likesTotal;
  final bool isLiked;

  const Review({
    required this.idReview,
    required this.idPlayer,
    this.username,
    this.picture,
    required this.idGame,
    required this.name,
    required this.date,
    required this.opinion,
    required this.rating,
    required this.likesTotal,
    required this.isLiked,
  });
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      idReview: json['idResenia'] as int,
      idPlayer: json['idJugador'] as int,
      username: json['nombreDeUsuario'] as String?,
      picture: json['foto'] as String?,
      idGame: json['idJuego'] as int,
      name: json['nombre'] as String,
      date: json['fecha'] as String,
      opinion: json['opinion'] as String,
      rating: (json['calificacion'] as num).toDouble(),
      likesTotal: json['totalDeMeGusta'] as int,
      isLiked:
          (json['existeMeGusta'] as bool? ?? false) ||
          (json['existeLike'] as bool? ?? false),
    );
  }

  Review copyWith({
    int? likesTotal,
    bool? isLiked,
  }) {
    return Review(
      idReview: idReview,
      idPlayer: idPlayer,
      username: username,
      picture: picture,
      idGame: idGame,
      name: name,
      date: date,
      opinion: opinion,
      rating: rating,
      likesTotal: likesTotal ?? this.likesTotal,
      isLiked: isLiked ?? this.isLiked,
    );
  }

}
