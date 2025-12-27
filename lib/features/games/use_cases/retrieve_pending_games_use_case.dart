
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/repositories/game_repository.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/games/models/games_response.dart';

class RetrievePendingGamesUseCase {
  final GameRepository repository;

  RetrievePendingGamesUseCase(this.repository);

  Future<Either<Failure, GamesResponse>> call (int idPlayer) async {
    final result = await repository.retrievePendings(idPlayer);
    return result;
  }
}