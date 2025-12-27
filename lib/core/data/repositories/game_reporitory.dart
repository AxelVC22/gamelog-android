
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/add_to_favorites_request.dart';
import 'package:gamelog/core/data/models/add_to_favorites_response.dart';

import '../../domain/entities/game.dart';
import '../../domain/failures/failure.dart';

abstract class GameRepository {
  Future<Either<Failure, Game>> searchGame (String gameName);


  Future<Either<Failure, AddToFavoritesResponse>> addGameToFavorites (AddToFavoritesRequest request);

}