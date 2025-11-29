import 'package:flutter/foundation.dart';
import 'player.dart';
import 'game.dart';

@immutable
class Review {
  final int id;
  final double rating;
  final String opinion;
 // final Game game;
  final Player player;
  final DateTime date;

  const Review({
    required this.id,
    required this.rating,
    required this.opinion,
   // required this.game,
    required this.date,
    required this.player
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int,
      rating: (json['rating'] as num).toDouble(),
      opinion: json['comentario'] as String,
   //   game: Game.fromJson(json['game']),
      date: DateTime.parse(json['fecha']),
      player: Player.fromJson(json['jugador'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'comentario': opinion,
     // 'game': game.toJson(),
      'fecha': date.toIso8601String(),
    };
  }
}
