
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/repositories/games/game_repository.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/games/games_response.dart';

class RetrievePendingGamesUseCase {
  final GameRepository repository;

  RetrievePendingGamesUseCase(this.repository);

  Future<Either<Failure, GamesResponse>> call (int idPlayer) async {
    final result = await repository.retrievePendings(idPlayer);
    return result;
  }
}