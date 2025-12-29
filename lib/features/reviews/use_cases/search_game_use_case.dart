import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/repositories/games/game_repository.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/constants/error_codes.dart';

class SearchGameUseCase {
  final GameRepository repository;

  SearchGameUseCase(this.repository);

  Future<Either<Failure, Game>> call(String gameName) async {
    if (gameName.trim().isEmpty || gameName.length > 50) {
      return left(Failure.local(ErrorCodes.invalidGameName));
    }
    final normalizedName = _normalizeGameName(gameName);

    final result = await repository.searchGame(normalizedName);

    return result;
  }

  String _normalizeGameName(String input) {
    return input
        .replaceAll(RegExp(r'\s*\(itch\)\s*', caseSensitive: false), '')
        .replaceAll(RegExp(r'\s*:\s*the game\s*', caseSensitive: false), '')
        .replaceAll(RegExp(r'\s*\+\s*'), '')
        .replaceAll(RegExp(r'\s*\.\s*'), '')
        .trim()
        .replaceAll(RegExp(r'\s+'), '-');

  }
}
