
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/repositories/games/game_repository.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/games/games_response.dart';

class RetrieveFavoriteGamesUseCase {
  final GameRepository repository;

  RetrieveFavoriteGamesUseCase(this.repository);

  Future<Either<Failure, GamesResponse>> call (int idPlayer) async {
    final result = await repository.retrieveFavorites(idPlayer);
    return result;
  }
}