
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/add_to_favorites_request.dart';
import 'package:gamelog/core/data/models/add_to_favorites_response.dart';
import 'package:gamelog/core/data/repositories/game_repository.dart';
import 'package:gamelog/core/domain/failures/failure.dart';

class AddGameToFavoritesUseCase {
  final GameRepository repository;

  AddGameToFavoritesUseCase(this.repository);

  Future<Either<Failure, AddToFavoritesResponse>> call (AddToFavoritesRequest request) async {
    final result = await repository.addGameToFavorites(request);
    return result;
  }
}