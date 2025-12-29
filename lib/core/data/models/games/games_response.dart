
import '../../../domain/entities/game.dart';

class GamesResponse {
  final bool error;
  final List<Game> games;

  const GamesResponse({
    required this.error,
    required this.games,
  });

  factory GamesResponse.fromJson(Map<String, dynamic> json) {
    return GamesResponse(
      error: json['error'] as bool,
      games: (json['juegos'] as List<dynamic>)
          .map((item) => Game.fromJson(item))
          .toList(),
    );
  }
}