
import '../../../core/domain/entities/game.dart';

class RetrieveStatisticsResponse {
  final bool error;
  final List<Game> games;

  const RetrieveStatisticsResponse({
    required this.error,
    required this.games,
  });

  factory RetrieveStatisticsResponse.fromJson(Map<String, dynamic> json) {
    return RetrieveStatisticsResponse(
      error: json['error'] as bool,
      games: (json['juegos'] as List<dynamic>)
          .map((item) => Game.fromJson(item))
          .toList(),
    );
  }
}