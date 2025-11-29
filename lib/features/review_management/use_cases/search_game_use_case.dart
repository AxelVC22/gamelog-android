
import 'package:dartz/dartz.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/messages/error_codes.dart';

class SearchGameUseCase {
  final ReviewManagementRepository repository;

  SearchGameUseCase(this.repository);

  Future<Either<Failure, Game>> call(String gameName) async {

    if (gameName.trim().isEmpty || gameName.length > 50) {
      return left(Failure.local(ErrorCodes.invalidUsername));
    }
    final result = await repository.searchGame(gameName.replaceAll(' ', '-'));

    return result;
  }
}